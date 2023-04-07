// CA Parcel Prediction

clear 
set more off
cd "C:\Users\K\Documents\LA ML"
capture log close
log using LAML.log, replace

// This is code by Nick Cox
ssc install extremes

// renamed to pd.dta
use pd.dta

// fill in 0's
drop pin
foreach i of varlist _all {
	replace `i' = 0 if `i' ==.
}

// merge
merge 1:1 objectid using "C:\Users\K\Documents\LA ML\nhbd.dta"

// gen bp_exists and look at distribution by z_nhbd
gen bp_exists = (bp_units>0)
tab z_nhbd if bp_exists==1, sort

// Cross Validation
set seed 5301
gen insamp = (runiform() > 0.05)


/*
	The following neighborhoods caused issues for the logistic regression:
	'neighborhood' != 0 predicts failure perfectly
    'neighborhood' dropped and 14 obs not used

	I am lumping them all together into a dummy variable called 'Cohort D'
	I then removed them from the logreg and replaced them with the new var.
*/

// None of these areas got building permits
gen cohort_d=0
replace cohort_d=1 if blairhills==1
replace cohort_d=1 if canyoncountry==1
replace cohort_d=1 if culverwest==1
replace cohort_d=1 if elysianpark==1
replace cohort_d=1 if foxhills==1
replace cohort_d=1 if glendale==1
replace cohort_d=1 if mclaughlin==1
replace cohort_d=1 if oceanpark==1
replace cohort_d=1 if riversiderancho==1
replace cohort_d=1 if somerset==1
replace cohort_d=1 if southarroyo==1
replace cohort_d=1 if terminalisland==1
replace cohort_d=1 if vineyard==1


//drop y1 npv_m2_op opt_npv_sq npv_sq* npv_m24_e rlvlv30_e npv_pe_sq_* cohort_c

gen cohort_c=0
replace cohort_c=1 if southcarthay==1
replace cohort_c=1 if latunacanyon==1
replace cohort_c=1 if leimertpark==1
replace cohort_c=1 if crenshaw==1
replace cohort_c=1 if chinatown==1

set seed 1444

// This interaction helped slightly
gen npv_m2_op = npv_m2*optimum_precluded

// quadratic at optimum
gen opt_npv_sq = 0
replace opt_npv_sq = opt_npv_m * opt_npv_m if opt_npv_m > 0

// quadratic loop non-opt
local num 2 4 50 100
foreach i of local num {
	gen npv_sq_`i'=0
	replace npv_sq_`i' = npv_m`i' * npv_m`i' if npv_m`i' > 0
}

// quadratic loop non-opt
local numw 2 4 6 16 35 45 50 60 65 100 130
foreach i of local numw {
	gen npv_pe_sq_`i'=0
	replace npv_pe_sq_`i' = npv_per_equity`i' * npv_per_equity`i' if npv_per_equity`i' > 0
}

gen npv_m24_e = (npv_m24 != 0)
gen rlvlv30_e = (rlvlv50 != 0)

/*
	THIS ONE HELPS A LOT, everything before makes no improvement.
	Seattle has the smallest average apt at 882sqft per apt. So I'm cutting out
	places that have less sqft/opt_du than that. The probit gets a "backed up"
	message and will iterate indefinitely. I added iterate(4) to stop after
	the first backed up message.
*/

local small 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
foreach i of local small {
	drop if (opt_du>`i' & lot_size_sqft < 950*`i' & insamp==1) 
}

/*
	This graph is L-shaped, doesn't seem like it would be very predictive unless
	you removed a lot of obs
*/
//scatter opt_du lot_size_sqft
//extremes opt_du lot_size_sqft

// The changes led to an increase in from 0.7518 -> 0.7646
probit bp_exists adamsnormandie arleta arlingtonheights atwatervillage belair beverlyglen beverlywood boyleheights brentwood canogapark centralcity centralcityeast centurycity chatsworth cheviothills chinatown crenshaw crestview cypresspark delrey downtown eaglerock echopark elsereno elysianvalley encino glassellpark granadahills harborcity harborgateway harvardheights hermon highlandpark hollywood hollywoodhills hydepark jeffersonpark koreatown lakebalboa lakeviewterrace latunacanyon leimertpark lincolnheights losfeliz marvista midcity midcitywest midwilshire missionhills montecitoheights mountwashington northhills northhollywood northridge pacificpalisades pacoima palms panoramacity picorobertson picounion playadelrey playavista porterranch reseda sanpedro sawtelle shadowhills shermanoaks silverlake southcarthay southeastlosangeles southlosangeles studiocity sunland sunvalley sylmar tarzana tolucalake tujunga universityhills universitypark valleyglen valleyvillage vannuys venice watts westadams westchester westhills westlake westlosangeles westwood wilmington winnetka woodlandhills opt_du_pre opt_du opt_du_post_redux opt_npv_m_pre opt_npv_m opt_npv_m_post_redux opt_npv_per_eq_pre opt_npv_per_eq opt_npv_per_eq_post_redux optimum_precluded npv_per_equity2 npv_per_equity4 npv_per_equity5 npv_per_equity6 npv_per_equity16 npv_per_equity18 npv_per_equity22 npv_per_equity24 npv_per_equity26 npv_per_equity30 npv_per_equity35 npv_per_equity45 npv_per_equity50 npv_per_equity55 npv_per_equity60 npv_per_equity65 npv_per_equity75 npv_per_equity80 npv_per_equity90 npv_per_equity95 npv_per_equity100 npv_per_equity130 npv_per_equity140 npv_per_equity900 npv_m2 npv_m4 npv_m6 npv_m8 rlvlv10 rlvlv12 rlvlv400 opt_npv_sq npv_sq* npv_m24_e rlvlv30_e npv_pe_sq_* if insamp==1, difficult
predict y1
roctab bp_exists y1 if insamp==0
