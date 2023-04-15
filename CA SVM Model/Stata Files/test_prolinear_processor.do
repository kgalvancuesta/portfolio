// CA Parcel Prediction

clear 
set more off
cd "C:\Users\Dublt\Documents\000\23 A\Job Search\CAML Data\Data Generator"

// renamed to pd.dta
use pd.dta

/*
	PREPROCESSING
*/

// fill in 0's
drop pin
foreach i of varlist _all {
	replace `i' = 0 if `i' ==.
}

// merge
merge 1:1 objectid using "C:\Users\Dublt\Documents\000\23 A\Job Search\CAML Data\Data Generator\nhbd.dta"

// gen bp_exists and look at distribution by z_nhbd
gen bp_exists = (bp_units>0)

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
	SEPARATE TEST AND TRAINING SETS
*/


set seed 777
gen test_set = (runiform() > 0.9)

probit bp_exists adamsnormandie arleta arlingtonheights atwatervillage belair beverlyglen beverlywood boyleheights brentwood canogapark centralcity centralcityeast centurycity chatsworth cheviothills chinatown crenshaw crestview cypresspark delrey downtown eaglerock echopark elsereno elysianvalley encino glassellpark granadahills harborcity harborgateway harvardheights hermon highlandpark hollywood hollywoodhills hydepark jeffersonpark koreatown lakebalboa lakeviewterrace latunacanyon leimertpark lincolnheights losfeliz marvista midcity midcitywest midwilshire missionhills montecitoheights mountwashington northhills northhollywood northridge pacificpalisades pacoima palms panoramacity picorobertson picounion playadelrey playavista porterranch reseda sanpedro sawtelle shadowhills shermanoaks silverlake southcarthay southeastlosangeles southlosangeles studiocity sunland sunvalley sylmar tarzana tolucalake tujunga universityhills universitypark valleyglen valleyvillage vannuys venice watts westadams westchester westhills westlake westlosangeles westwood wilmington winnetka woodlandhills opt_du_pre opt_du opt_du_post_redux opt_npv_m_pre opt_npv_m opt_npv_m_post_redux opt_npv_per_eq_pre opt_npv_per_eq opt_npv_per_eq_post_redux optimum_precluded npv_per_equity2 npv_per_equity4 npv_per_equity5 npv_per_equity6 npv_per_equity16 npv_per_equity18 npv_per_equity22 npv_per_equity24 npv_per_equity26 npv_per_equity30 npv_per_equity35 npv_per_equity45 npv_per_equity50 npv_per_equity55 npv_per_equity60 npv_per_equity65 npv_per_equity75 npv_per_equity80 npv_per_equity90 npv_per_equity95 npv_per_equity100 npv_per_equity130 npv_per_equity140 npv_per_equity900 npv_m2 npv_m4 npv_m6 npv_m8 rlvlv10 rlvlv12 rlvlv400 opt_npv_sq npv_sq* npv_m24_e rlvlv30_e npv_pe_sq_* if test_set==0, difficult
predict y1

regress bp_exists adamsnormandie arleta arlingtonheights atwatervillage belair beverlyglen beverlywood boyleheights brentwood canogapark centralcity centralcityeast centurycity chatsworth cheviothills chinatown crenshaw crestview cypresspark delrey downtown eaglerock echopark elsereno elysianvalley encino glassellpark granadahills harborcity harborgateway harvardheights hermon highlandpark hollywood hollywoodhills hydepark jeffersonpark koreatown lakebalboa lakeviewterrace latunacanyon leimertpark lincolnheights losfeliz marvista midcity midcitywest midwilshire missionhills montecitoheights mountwashington northhills northhollywood northridge pacificpalisades pacoima palms panoramacity picorobertson picounion playadelrey playavista porterranch reseda sanpedro sawtelle shadowhills shermanoaks silverlake southcarthay southeastlosangeles southlosangeles studiocity sunland sunvalley sylmar tarzana tolucalake tujunga universityhills universitypark valleyglen valleyvillage vannuys venice watts westadams westchester westhills westlake westlosangeles westwood wilmington winnetka woodlandhills opt_du_pre opt_du opt_du_post_redux opt_npv_m_pre opt_npv_m opt_npv_m_post_redux opt_npv_per_eq_pre opt_npv_per_eq opt_npv_per_eq_post_redux optimum_precluded npv_per_equity* npv_m* rlvlv* opt_npv_sq npv_sq* npv_m24_e npv_pe_sq_* if test_set==0
predict y2

keep if test_set == 1


/*
	FINAL PROCESSING
*/


// removing rlvlv's
local rlvlvdrop 14 16 18 20 22 24 26 28 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 300 350 450 500 550 600 650 700 750 800 850 900 950 
foreach i of local rlvlvdrop {
	drop rlvlv`i'
}

drop bp_units test_set z_nhbd new_bldg issue_month _merge objectid npv_m2_op rlvlv30_e npv_m24_e opt_npv_sq npv_sq_2 npv_sq_4 npv_sq_50 npv_sq_100 npv_pe_sq_2 npv_pe_sq_4 npv_pe_sq_6 npv_pe_sq_16 npv_pe_sq_35 npv_pe_sq_45 npv_pe_sq_50 npv_pe_sq_60 npv_pe_sq_65 npv_pe_sq_100 npv_pe_sq_130

save "test_prolinear", replace
