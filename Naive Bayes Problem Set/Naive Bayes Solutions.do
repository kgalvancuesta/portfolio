// Author: Kevin Galvan Cuesta
// Date: 7/12/2021
cd ""
clear

// The number of observations, and a given seed so that my graphs are replicable
set obs 100
set seed 98034

// Generating the boxes, using the Yummy probability as a cut off
// Outputting a value of 1 signifies that the observation is Crummy
// runiform() generates a random value between 0 and 1.

gen box1 = runiform() > .8

gen box2 = runiform() > .55

gen box3 = runiform() > .3

// Running a summary to see how to data looks
// This seed generates a perfect match for box1, box2 off by .03, and box3 off by .05
sum box1
sum box2
sum box3

// The following code is used to run a chi-squared test to estimate Pr(D|h)

// Generating the observation number

gen observation = _n

// Generating the expected number of Crummies for each type of box

gen e1 = _n * .2
gen e2 = _n * .45
gen e3 = _n * .7

// Generating the running count of Crummies eaten in each box
gen runsum1 = 0
replace runsum1 = box1[observation] + runsum1[observation-1] if _n>1

gen runsum2 = 0
replace runsum2 = box2[observation] + runsum2[observation-1] if _n>1

gen runsum3 = 0
replace runsum3 = box3[observation] + runsum3[observation-1] if _n>1

// Generating the chi-squared statistic
// observered minus the expected, squared. divided by the expected

// box1, testing expected 1, 2, 3
gen b1test1 = ((runsum1 - e1)^2)/e1
gen b1test2 = ((runsum1 - e2)^2)/e2
gen b1test3 = ((runsum1 - e3)^2)/e3

// box2, testing expected 1, 2, 3
gen b2test1 = ((runsum2 - e1)^2)/e1
gen b2test2 = ((runsum2 - e2)^2)/e2
gen b2test3 = ((runsum2 - e3)^2)/e3

// box3, testing expected 1, 2, 3
gen b3test1 = ((runsum3 - e1)^2)/e1
gen b3test2 = ((runsum3 - e2)^2)/e2
gen b3test3 = ((runsum3 - e3)^2)/e3

// Generating the chi-squared p-values for each test
// This is equivalent Pr(D|h)

gen b1chi1 = 1 - chi2(1, b1test1)
gen b1chi2 = 1 - chi2(1, b1test2)
gen b1chi3 = 1 - chi2(1, b1test3)

gen b2chi1 = 1 - chi2(1, b2test1)
gen b2chi2 = 1 - chi2(1, b2test2)
gen b2chi3 = 1 - chi2(1, b2test3)

gen b3chi1 = 1 - chi2(1, b3test1)
gen b3chi2 = 1 - chi2(1, b3test2)
gen b3chi3 = 1 - chi2(1, b3test3)

// Creating the first three graphs
// The highest line is our best guess for a box

line b1chi1 b1chi2 b1chi3 observation, ytitle("Probability") xtitle("Observation") title("Rough Probability Sample is of Box Type 1") legend(label(1 "Sample Box 1") label(2 "Sample Box 2") label(3 "Sample Box 3"))
graph export box1.png, replace

line b2chi1 b2chi2 b2chi3 observation, ytitle("Probability") xtitle("Observation") title("Rough Probability Sample is of Box Type 2") legend(label(1 "Sample Box 1") label(2 "Sample Box 2") label(3 "Sample Box 3"))
graph export box2.png, replace

line b3chi1 b3chi2 b3chi3 observation, ytitle("Probability") xtitle("Observation") title("Rough Probability Sample is of Box Type 3") legend(label(1 "Sample Box 1") label(2 "Sample Box 2") label(3 "Sample Box 3"))
graph export box3.png, replace


// Generating a prediction for the next observation given the current data
// We need to normalize the prediction to 1

gen nfactor1 = b1chi1[_n - 1] + b1chi2[_n - 1] + b1chi3[_n - 1] if _n > 1
gen nfactor2 = b2chi1[_n - 1] + b2chi2[_n - 1] + b2chi3[_n - 1] if _n > 1
gen nfactor3 = b3chi1[_n - 1] + b3chi2[_n - 1] + b3chi3[_n - 1] if _n > 1

// Next, multiply the probability of each hypothesis by the number of Crummy candies
// That is the expectation, and dividing by the normalizing factor gives us the probability
gen predbox1 = (b1chi1[_n - 1]*.2 + b1chi2[_n - 1]*.45 + b1chi3[_n - 1]*.7)/nfactor1
gen predbox2 = (b2chi1[_n - 1]*.2 + b2chi2[_n - 1]*.45 + b2chi3[_n - 1]*.7)/nfactor2
gen predbox3 = (b3chi1[_n - 1]*.2 + b3chi2[_n - 1]*.45 + b3chi3[_n - 1]*.7)/nfactor3

// Generating a variable to only count observations + 1
gen obs = observation - 1 if _n > 1

// Generating the next graph
graph twoway line predbox1 predbox2 predbox3 obs, ytitle("Probability") xtitle("Observation") title("Probability Next Observation is Positive") legend(label(1 "Sample Box 1") label(2 "Sample Box 2") label(3 "Sample Box 3"))
graph export predictions.png, replace


/* Now we are assuming we have prior knowledge. The knowledge is that there is
a 0.8 probability that the box has 70% Crummy candies, and 0.1 probability that
it is one of the other two box types */
// This is equivalent to Pr(D|h) * Pr(h)

// box1, testing expected 1, 2, 3
replace b1test1 = 0.1 * ((runsum1 - e1)^2)/e1
replace b1test2 = 0.1 * ((runsum1 - e2)^2)/e2
replace b1test3 = 0.8 * ((runsum1 - e3)^2)/e3

// box2, testing expected 1, 2, 3
replace b2test1 = 0.1 * ((runsum2 - e1)^2)/e1
replace b2test2 = 0.1 * ((runsum2 - e2)^2)/e2
replace b2test3 = 0.8 * ((runsum2 - e3)^2)/e3

// box3, testing expected 1, 2, 3
replace b3test1 = 0.1 * ((runsum3 - e1)^2)/e1
replace b3test2 = 0.1 * ((runsum3 - e2)^2)/e2
replace b3test3 = 0.8 * ((runsum3 - e3)^2)/e3


gen b1bayes1 = (1 - chi2(1, b1test1))
gen b1bayes2 = (1 - chi2(1, b1test2))
gen b1bayes3 = (1 - chi2(1, b1test3))

gen b2bayes1 = (1 - chi2(1, b2test1))
gen b2bayes2 = (1 - chi2(1, b2test2))
gen b2bayes3 = (1 - chi2(1, b2test3))

gen b3bayes1 = (1 - chi2(1, b3test1))
gen b3bayes2 = (1 - chi2(1, b3test2))
gen b3bayes3 = (1 - chi2(1, b3test3))

// Generating the graphs for the Bayesian predictions
// The highest line if our best guess

line b1bayes1 b1bayes2 b1bayes3 observation, ytitle("Probability") xtitle("Observation") title("Naive Bayes Estimate Sample is of Box Type 1") legend(label(1 "Sample Box 1") label(2 "Sample Box 2") label(3 "Sample Box 3"))
graph export bayes1.png, replace

line b2bayes1 b2bayes2 b2bayes3 observation, ytitle("Probability") xtitle("Observation") title("Naive Bayes Estimate Sample is of Box Type 2") legend(label(1 "Sample Box 1") label(2 "Sample Box 2") label(3 "Sample Box 3"))
graph export bayes2.png, replace

line b3bayes1 b3bayes2 b3bayes3 observation, ytitle("Probability") xtitle("Observation") title("Naive Bayes Estimate Sample is of Box Type 3") legend(label(1 "Sample Box 1") label(2 "Sample Box 2") label(3 "Sample Box 3"))
graph export bayes3.png, replace
