// CA Parcel Prediction
/*
clear 
set more off
cd "C:\Users\K\Documents\LA ML"
capture log close
log using LAML.log, replace

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
//set seed 5301
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


// Highest likeliehood cohort
gen cohort_a=0
replace cohort_a=1 if southeastlosangeles==1
replace cohort_a=1 if southlosangeles==1
replace cohort_a=1 if porterranch==1

*/
drop cohort_c
gen cohort_c=0

replace cohort_c=1 if southcarthay==1
replace cohort_c=1 if latunacanyon==1
replace cohort_c=1 if leimertpark==1
replace cohort_c=1 if crenshaw==1
replace cohort_c=1 if chinatown==1

set seed 6463
drop y1 npv_m2_op opt_npv_sq npv_sq* npv_eq_sq_* npv_d

// This interaction helped slightly
gen npv_m2_op = npv_m2*optimum_precluded

// quadratic at optimum
gen opt_npv_sq = 0
replace opt_npv_sq = opt_npv_m * opt_npv_m if opt_npv_m > 0

// quadratic loop non-opt
local num 2 4 6 8 50 100
foreach i of local num {
	gen npv_sq_`i'=0
	replace npv_sq_`i' = npv_m`i' * npv_m`i' if npv_m`i' > 0
}

// quadratic loop non-opt
local num2 2 4 6
foreach i of local num2 {
	gen npv_eq_sq_`i'=0
	replace npv_eq_sq_`i' = npv_per_equity`i' * npv_per_equity`i' if npv_per_equity`i' > 0
}

gen npv_d = (opt_npv_m > .12 & opt_rlvlv > 1) 
logistic bp_exists cohort_c adamsnormandie arleta arlingtonheights atwatervillage belair beverlyglen beverlywood boyleheights brentwood canogapark centralcity centralcityeast centurycity chatsworth cheviothills chinatown crenshaw crestview cypresspark delrey downtown eaglerock echopark elsereno elysianvalley encino glassellpark granadahills harborcity harborgateway harvardheights hermon highlandpark hollywood hollywoodhills hydepark jeffersonpark koreatown lakebalboa lakeviewterrace latunacanyon leimertpark lincolnheights losfeliz marvista midcity midcitywest midwilshire missionhills montecitoheights mountwashington northhills northhollywood northridge pacificpalisades pacoima palms panoramacity picorobertson picounion playadelrey playavista porterranch reseda sanpedro sawtelle shadowhills shermanoaks silverlake southeastlosangeles southlosangeles studiocity sunland sunvalley sylmar tarzana tolucalake tujunga universityhills universitypark valleyglen valleyvillage vannuys venice watts westadams westchester westhills westlake westlosangeles westwood wilmington winnetka woodlandhills opt_du_pre opt_du opt_du_post_redux opt_rlvlv_pre opt_rlvlv opt_rlvlv_post_redux opt_npv_m_pre opt_npv_m opt_npv_m_post_redux opt_npv_per_eq_pre opt_npv_per_eq opt_npv_per_eq_post_redux optimum_precluded npv_per_equity* npv_m* rlvlv10 rlvlv12 rlvlv400 opt_npv_sq npv_sq* if insamp==1
predict y1
roctab bp_exists y1 if insamp==0

/*
	More quadratic interaction terms (npv_per_eq, etc.)
	
	Each nhbd in Cohort_D has no building permits. This prevents it from being
	used in the logreg. If we switch a single observation to have a bp in any of
	the nhbds in Cohort_D, the logreg might pick it up.
	
	Try creating new cohorts. Try 'most likely' cohort first, then try 'least
	likely' cohort. Maybe using both would work.
	
	Use lot size
*/
