// Author:
// Date:
cd "[SET DIRECTORY]"
clear

// The number of observations, and a given seed so that my graphs are replicable
set obs 100
set seed 98034

// [todo] Generating the boxes, using the Yummy probability as a cut off
// Outputting a value of 1 signifies that the observation is Crummy
// runiform() generates a random value between 0 and 1.

gen box1 = runiform() > .8

gen box2 = runiform() > 

gen box3 = runiform() > 

// [todo] Run a summary to see how to data looks

/*
	Problem 1
	The following code is used to run a chi-squared test to estimate Pr(D|h)
*/

// Generating the observation number

gen observation = _n

// [todo] Generate the expected number of Crummies for each type of box


// Generating the running count of Crummies eaten in each box
// also called observed number of crummies
gen runsum1 = 0
replace runsum1 = box1[observation] + runsum1[observation-1] if _n>1

gen runsum2 = 0
replace runsum2 = box2[observation] + runsum2[observation-1] if _n>1

gen runsum3 = 0
replace runsum3 = box3[observation] + runsum3[observation-1] if _n>1

/* 
   [todo] Generate the chi-squared statistic
   Do observered minus the expected, squared. Divide by the expected crummies
   (obs - exp)^2/exp
   There are 9 total. For each of the 3 boxes you have to check the expected for
   every other box.
*/

// box1, testing expected 1, 2, 3
gen b1test1 = 
gen b1test2 = 
gen b1test3 = 

// box2, testing expected 1, 2, 3
gen b2test1 = 
gen b2test2 = 
gen b2test3 = 

// box3, testing expected 1, 2, 3
gen b3test1 = 
gen b3test2 = 
gen b3test3 = 

// From the chi-squared values, generate p-values for each test
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

// [todo] Generate the line graphs and save them

/*
	Problem 2
	This one has hard code if you haven't worked with indexing.
	Read to understand what the code is doing. The [] brackets indicate which
	observation we are looking at. _n is the current observation.
*/
	
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

// [todo] Generate a single graph with 3 lines using obs from above
// observation runs from 1-100 and obs runs 1-99


/* 
	Problem 3
	Now we are assuming we have prior knowledge. The knowledge is that there is
	a 0.8 probability that the box has 70% Crummy candies, and 0.1 probability
	that it is one of the other two box types

	This is equivalent to Pr(D|h) * Pr(h)
*/

// [todo] Update your chi-squared tests by multiplying the prior information
// box1, testing expected 1, 2, 3
replace b1test1 = 
replace b1test2 = 
replace b1test3 = 

// box2, testing expected 1, 2, 3
replace b2test1 = 
replace b2test2 = 
replace b2test3 = 

// box3, testing expected 1, 2, 3
replace b3test1 = 
replace b3test2 = 
replace b3test3 = 

// From the new chi-squared values, generate p-values for each test
// This is equivalent Pr(D|h)

gen b1bayes1 = (1 - chi2(1, b1test1))
gen b1bayes2 = (1 - chi2(1, b1test2))
gen b1bayes3 = (1 - chi2(1, b1test3))

gen b2bayes1 = (1 - chi2(1, b2test1))
gen b2bayes2 = (1 - chi2(1, b2test2))
gen b2bayes3 = (1 - chi2(1, b2test3))

gen b3bayes1 = (1 - chi2(1, b3test1))
gen b3bayes2 = (1 - chi2(1, b3test2))
gen b3bayes3 = (1 - chi2(1, b3test3))

// [todo] Generate the new line graphs using observation, not obs

