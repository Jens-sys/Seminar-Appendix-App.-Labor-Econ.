clear all

cd "C:\Users\JensB\Documents\Kandidat\2. semester\Labor"
use Datasættet

//Use only data for year 2018 and only for persons aged 18 - 65
drop if year < 2018

drop if age <= 17
drop if age >= 66

//create age^2
gen ages = age*age/100

//Create education dummies
gen edu1 = (iscd975==2)
gen edu2 = (iscd975==3)
gen edu3 = (iscd975==4)
gen edu4 = (iscd975==5)

drop if iscd975 == -32 //drop observations for which iscd975 could not be generated, coded as "-32".

//Create gender dummies
gen female = (sex == 2)

//							Create variables that can explain differences in earnings / employment rates:
//Correct answers variables
gen correctpk12 = (pk12 == 4)
drop if pk12 == -1

gen correctpk13 = (pk13 == 2)
drop if pk13 == -1

gen correctpk14 = (pk14 == 3)
drop if pk14 == -1

gen correctpk15 = (pk15 == 2)
drop if pk15 == -1

gen correctpk16 = (pk16 == 2)
drop if pk16 == -1

gen correctpk17 = (pk17 == 2)
drop if pk17 == -1

gen correctpk = correctpk12 + correctpk13 + correctpk14 + correctpk15 + correctpk16 + correctpk17

// Confidence questions:
drop if pe02 == -8
drop if pe02 == -9

drop if pe03 == -8
drop if pe03 == -9

drop if pe04 == -8
drop if pe04 == -9

drop if pe06 == -8
drop if pe06 == -9

//Health
drop if hs01 == -9

//Create ekstra frame for probit analysis
frame rename default ols
frame copy ols logit

// 							OLS frame:
frame change ols

// Drop if weekly working hours < 10
gen hour = (dw15 >= 10)
drop if hour == 0

// Drop if monthly income < 400
drop if inc < 400


//Create dependent variable.
gen linc = log(inc)

//Create working hour dummies
gen hours2 = (15 < dw15 & dw15 <= 20)
gen hours3 = (20 < dw15 & dw15 <= 25)
gen hours4 = (25 < dw15 & dw15 <= 30)
gen hours5 = (30 < dw15 & dw15 <= 35)
gen hours6 = (35 < dw15 & dw15 <= 40)
gen hours7 = (40 < dw15 & dw15 <= 45)
gen hours8 = (45 < dw15 & dw15 <= 50)
gen hours9 = (50 < dw15 & dw15 <= 55)
gen hours10 = (55 < dw15 & dw15 <= 60)
gen hours11 = (60 < dw15)

//Gen social index
drop if isco88 < 0

drop if isco88 == 7000
drop if isco88 == 3000
drop if isco88 == 9000

gen social = 0

replace social = 11 if isco88 == 7321 
replace social = 28 if isco88 == 2411 
replace social = 22 if isco88 == 4121 
replace social = 50 if isco88 == 2470 
replace social = 22 if isco88 == 3439 
replace social = 22 if isco88 == 3430 
replace social = 50 if isco88 == 3431 
replace social = 50 if isco88 == 1234 
replace social = 17 if isco88 == 7233 
replace social = 22 if isco88 == 2213 
replace social = 17 if isco88 == 3212 
replace social = 33 if isco88 == 3144 
replace social = 11 if isco88 == 3145 
replace social = 11 if isco88 == 7232 
replace social = 33 if isco88 == 3143 
replace social = 56 if isco88 == 3417 
replace social = 39 if isco88 == 2141 
replace social = 33 if isco88 == 2140 
replace social = 33 if isco88 == 2149 
replace social = 44 if isco88 == 3470 

replace social = 11 if isco88 == 8280 
replace social = 11 if isco88 == 9321 
replace social = 61 if isco88 == 5151 
replace social = 50 if isco88 == 3475 
replace social = 33 if isco88 == 2451 
replace social = 11 if isco88 == 8171 
replace social = 28 if isco88 == 8274 
replace social = 28 if isco88 == 7412 
replace social = 11 if isco88 == 7424 
replace social = 17 if isco88 == 2211 
replace social = 11 if isco88 == 7221 
replace social = 11 if isco88 == 8264 
replace social = 11 if isco88 == 7345 
replace social = 22 if isco88 == 3433 
replace social = 39 if isco88 == 4213 
replace social = 11 if isco88 == 7122 
replace social = 33 if isco88 == 3132 
replace social = 22 if isco88 == 3151 
replace social = 22 if isco88 == 9141 
replace social = 22 if isco88 == 9140 

replace social = 11 if isco88 == 9313 
replace social = 11 if isco88 == 7130 
replace social = 11 if isco88 == 7129 
replace social = 11 if isco88 == 7120 
replace social = 11 if isco88 == 7143 
replace social = 11 if isco88 == 7137 
replace social = 50 if isco88 == 8323 
replace social = 28 if isco88 == 2410 
replace social = 28 if isco88 == 2419 
replace social = 33 if isco88 == 7411 
replace social = 33 if isco88 == 3416 
replace social = 11 if isco88 == 7422 
replace social = 39 if isco88 == 8322 
replace social = 11 if isco88 == 7124 
replace social = 17 if isco88 == 2148 
replace social = 33 if isco88 == 4211 
replace social = 11 if isco88 == 8212 
replace social = 28 if isco88 == 2146 
replace social = 11 if isco88 == 3111 
replace social = 11 if isco88 == 8150
 
replace social = 11 if isco88 == 8229
replace social = 17 if isco88 == 2113 
replace social = 94 if isco88 == 5131 
replace social = 67 if isco88 == 2454 
replace social = 17 if isco88 == 3112 
replace social = 28 if isco88 == 2142 
replace social = 28 if isco88 == 3422 
replace social = 33 if isco88 == 4143 
replace social = 78 if isco88 == 2310 
replace social = 39 if isco88 == 2453 
replace social = 22 if isco88 == 3121 
replace social = 22 if isco88 == 3120 
replace social = 22 if isco88 == 3122 
replace social = 17 if isco88 == 2132 
replace social = 22 if isco88 == 2139
replace social = 17 if isco88 == 2130
replace social = 33 if isco88 == 1236
replace social = 17 if isco88 == 2131
replace social = 11 if isco88 == 7123
replace social = 11 if isco88 == 9312

replace social = 39 if isco88 == 5122 
replace social = 50 if isco88 == 1200 
replace social = 11 if isco88 == 8333 
replace social = 56 if isco88 == 4200 
replace social = 56 if isco88 == 3441 
replace social = 22 if isco88 == 3449 
replace social = 22 if isco88 == 3440 
replace social = 33 if isco88 == 6121 
replace social = 11 if isco88 == 7413 
replace social = 11 if isco88 == 4113 
replace social = 22 if isco88 == 4215 
replace social = 11 if isco88 == 3471 
replace social = 83 if isco88 == 3225 
replace social = 61 if isco88 == 2222 
replace social = 61 if isco88 == 3223 
replace social = 56 if isco88 == 1210 
replace social = 67 if isco88 == 9131 
replace social = 67 if isco88 == 9130 
replace social = 83 if isco88 == 9152 
replace social = 56 if isco88 == 9113 

replace social = 39 if isco88 == 3118 
replace social = 11 if isco88 == 8332 
replace social = 39 if isco88 == 2441 
replace social = 72 if isco88 == 2351 
replace social = 22 if isco88 == 3113 
replace social = 22 if isco88 == 2143 
replace social = 11 if isco88 == 7245 
replace social = 11 if isco88 == 7241 
replace social = 11 if isco88 == 7240 
replace social = 11 if isco88 == 8282
replace social = 11 if isco88 == 8283 
replace social = 11 if isco88 == 7242 
replace social = 11 if isco88 == 7243 
replace social = 22 if isco88 == 2144 
replace social = 11 if isco88 == 3114 
replace social = 89 if isco88 == 3423 
replace social = 67 if isco88 == 3413 
replace social = 11 if isco88 == 7100 
replace social = 17 if isco88 == 9211 
replace social = 33 if isco88 == 6111 
replace social = 56 if isco88 == 2455

replace social = 44 if isco88 == 1231 
replace social = 56 if isco88 == 3419 
replace social = 56 if isco88 == 3410 
replace social = 61 if isco88 == 5161 
replace social = 28 if isco88 == 6150 
replace social = 11 if isco88 == 7132 
replace social = 11 if isco88 == 8270 
replace social = 22 if isco88 == 6141 
replace social = 11 if isco88 == 9333 
replace social = 11 if isco88 == 9161 
replace social = 11 if isco88 == 6113 
replace social = 50 if isco88 == 1317 
replace social = 72 if isco88 == 1318 
replace social = 61 if isco88 == 1315 
replace social = 28 if isco88 == 1316 
replace social = 56 if isco88 == 1314 
replace social = 50 if isco88 == 1310 
replace social = 50 if isco88 == 1319 
replace social = 33 if isco88 == 1311 
replace social = 28 if isco88 == 1313

replace social = 33 if isco88 == 1312 
replace social = 17 if isco88 == 2114 
replace social = 11 if isco88 == 7324 
replace social = 11 if isco88 == 7322 
replace social = 11 if isco88 == 7135 
replace social = 33 if isco88 == 3444 
replace social = 56 if isco88 == 3443 
replace social = 22 if isco88 == 3442 
replace social = 61 if isco88 == 5141 
replace social = 11 if isco88 == 9322 
replace social = 11 if isco88 == 7331 
replace social = 11 if isco88 == 9133 
replace social = 61 if isco88 == 2220 
replace social = 11 if isco88 == 8324 
replace social = 22 if isco88 == 9132 
replace social = 83 if isco88 == 5133 
replace social = 67 if isco88 == 5121 
replace social = 67 if isco88 == 5120 
replace social = 11 if isco88 == 8163 
replace social = 11 if isco88 == 8172

replace social = 83 if isco88 == 5132 
replace social = 11 if isco88 == 7134
replace social = 50 if isco88 == 3412 
replace social = 28 if isco88 == 7313 
replace social = 72 if isco88 == 2422 
replace social = 11 if isco88 == 9300 
replace social = 50 if isco88 == 2421 
replace social = 50 if isco88 == 2429 
replace social = 39 if isco88 == 3432 
replace social = 44 if isco88 == 2432 
replace social = 44 if isco88 == 4141 
replace social = 22 if isco88 == 3211 
replace social = 11 if isco88 == 8334 
replace social = 17 if isco88 == 8311 
replace social = 11 if isco88 == 7230 
replace social = 11 if isco88 == 8211 
replace social = 11 if isco88 == 7223 
replace social = 22 if isco88 == 4142 
replace social = 11 if isco88 == 9320 
replace social = 11 if isco88 == 6110

replace social = 17 if isco88 == 6130 
replace social = 17 if isco88 == 6129 
replace social = 11 if isco88 == 7900 
replace social = 22 if isco88 == 4130 
replace social = 17 if isco88 == 2121 
replace social = 11 if isco88 == 8271 
replace social = 17 if isco88 == 3115 
replace social = 28 if isco88 == 2145 
replace social = 11 if isco88 == 8281 
replace social = 83 if isco88 == 3221 
replace social = 61 if isco88 == 2221 
replace social = 28 if isco88 == 3133 
replace social = 33 if isco88 == 9151 
replace social = 11 if isco88 == 8223 
replace social = 11 if isco88 == 8122 
replace social = 11 if isco88 == 7211 
replace social = 11 if isco88 == 7210 
replace social = 11 if isco88 == 7224 
replace social = 11 if isco88 == 7510 

replace social = 11 if isco88 == 7200 
replace social = 11 if isco88 == 8284 
replace social = 11 if isco88 == 8123 
replace social = 11 if isco88 == 8120 
replace social = 83 if isco88 == 3232 
replace social = 17 if isco88 == 8112 
replace social = 11 if isco88 == 7111 
replace social = 11 if isco88 == 9310 
replace social = 17 if isco88 == 3117 
replace social = 22 if isco88 == 2147 
replace social = 11 if isco88 == 8111 
replace social = 33 if isco88 == 6114 
replace social = 100 if isco88 == 3229 
replace social = 11 if isco88 == 7231 
replace social = 17 if isco88 == 8331 
replace social = 11 if isco88 == 8320 
replace social = 11 if isco88 == 7312 
replace social = 17 if isco88 == 4120 
replace social = 83 if isco88 == 3231 
replace social = 83 if isco88 == 3230 

replace social = 28 if isco88 == 4100 
replace social = 28 if isco88 == 4000 
replace social = 11 if isco88 == 3130 
replace social = 61 if isco88 == 3224 
replace social = 67 if isco88 == 3400 
replace social = 56 if isco88 == 3429 
replace social = 44 if isco88 == 1230 
replace social = 44 if isco88 == 1239 
replace social = 11 if isco88 == 8290 
replace social = 83 if isco88 == 3239 
replace social = 56 if isco88 == 4190 
replace social = 67 if isco88 == 5149 
replace social = 94 if isco88 == 2359 
replace social = 50 if isco88 == 2400 
replace social = 56 if isco88 == 3340 
replace social = 22 if isco88 == 4139 
replace social = 11 if isco88 == 7141 
replace social = 11 if isco88 == 8143 
replace social = 11 if isco88 == 8253 
replace social = 83 if isco88 == 5130 
replace social = 83 if isco88 == 5139 

replace social = 78 if isco88 == 2412 
replace social = 72 if isco88 == 1232 
replace social = 44 if isco88 == 3228 
replace social = 33 if isco88 == 2224 
replace social = 50 if isco88 == 2212 
replace social = 67 if isco88 == 2444 
replace social = 44 if isco88 == 2443 
replace social = 44 if isco88 == 3131 
replace social = 17 if isco88 == 3119 
replace social = 17 if isco88 == 3100 
replace social = 17 if isco88 == 3110 
replace social = 17 if isco88 == 2111 
replace social = 89 if isco88 == 3226 
replace social = 11 if isco88 == 7133 
replace social = 11 if isco88 == 8232 
replace social = 11 if isco88 == 7136 
replace social = 67 if isco88 == 3450 
replace social = 67 if isco88 == 5162 
replace social = 11 if isco88 == 8161 
replace social = 11 if isco88 == 7311 
replace social = 100 if isco88 == 3320 

replace social = 100 if isco88 == 2332 
replace social = 100 if isco88 == 3310 
replace social = 100 if isco88 == 2331 
replace social = 11 if isco88 == 8251 
replace social = 83 if isco88 == 5163 
replace social = 39 if isco88 == 1229 
replace social = 33 if isco88 == 1221 
replace social = 50 if isco88 == 1227 
replace social = 61 if isco88 == 1228 
replace social = 28 if isco88 == 1223 
replace social = 33 if isco88 == 1222 
replace social = 33 if isco88 == 1224 
replace social = 50 if isco88 == 1226 
replace social = 33 if isco88 == 4132 
replace social = 33 if isco88 == 1220 
replace social = 61 if isco88 == 5160 
replace social = 83 if isco88 == 5169 
replace social = 61 if isco88 == 2445 
replace social = 72 if isco88 == 8312 
replace social = 67 if isco88 == 4222

replace social = 94 if isco88 == 3480
replace social = 94 if isco88 == 2460 
replace social = 72 if isco88 == 1237 
replace social = 11 if isco88 == 7131 
replace social = 11 if isco88 == 8230 
replace social = 11 if isco88 == 8231 
replace social = 72 if isco88 == 3150 
replace social = 72 if isco88 == 3152 
replace social = 44 if isco88 == 1233 
replace social = 56 if isco88 == 9100 
replace social = 67 if isco88 == 3222 
replace social = 17 if isco88 == 2000 
replace social = 39 if isco88 == 2452 
replace social = 100 if isco88 == 2320 
replace social = 50 if isco88 ==  4115
replace social = 44 if isco88 == 3411 
replace social = 50 if isco88 == 1142 
replace social = 50 if isco88 == 1141 
replace social = 67 if isco88 == 1120 
replace social = 11 if isco88 == 7436 

replace social = 11 if isco88 == 7213 
replace social = 11 if isco88 == 8340 
replace social = 44 if isco88 == 3142 
replace social = 11 if isco88 == 7442 
replace social = 56 if isco88 == 5220 
replace social = 11 if isco88 == 7346 
replace social = 100 if isco88 == 3460 
replace social = 100 if isco88 == 2446 
replace social = 56 if isco88 == 2442 
replace social = 81 if isco88 == 1 
replace social = 100 if isco88 == 3330 
replace social = 100 if isco88 == 2340 
replace social = 11 if isco88 == 8261 
replace social = 56 if isco88 == 5230 
replace social = 11 if isco88 == 8000 
replace social = 17 if isco88 == 4122 
replace social = 17 if isco88 == 2122 
replace social = 28 if isco88 == 4111 
replace social = 33 if isco88 == 4131 
replace social = 17 if isco88 == 7113 

replace social = 11 if isco88 == 7214 
replace social = 33 if isco88 == 1235 
replace social = 11 if isco88 == 9162 
replace social = 17 if isco88 == 7433 
replace social = 100 if isco88 == 3300 
replace social = 100 if isco88 == 2300 
replace social = 50 if isco88 == 3415 
replace social = 11 if isco88 == 7244 
replace social = 50 if isco88 == 4223 
replace social = 44 if isco88 == 4212 
replace social = 11 if isco88 == 8260 
replace social = 11 if isco88 == 7222 
replace social = 89 if isco88 == 3240 
replace social = 50 if isco88 == 1130 
replace social = 89 if isco88 == 3241 
replace social = 22 if isco88 == 4133 
replace social = 33 if isco88 == 5112 
replace social = 67 if isco88 == 4221 
replace social = 72 if isco88 == 5111 

replace social = 72 if isco88 == 5113 
replace social = 28 if isco88 == 5143 
replace social = 11 if isco88 == 7437 
replace social = 11 if isco88 == 7142 
replace social = 11 if isco88 == 9142 
replace social = 28 if isco88 == 9153 
replace social = 44 if isco88 == 2223 
replace social = 56 if isco88 == 3227 
replace social = 83 if isco88 == 5123 
replace social = 11 if isco88 == 8262 
replace social = 11 if isco88 == 7212 
replace social = 11 if isco88 == 8141 
replace social = 11 if isco88 == 7423 

gen socialdum = (social > 59) //Set dummy = 1 in case social > 49


gen socbea = socialdum*xr14

// 							Regression 1: Showing the relationship between beauty and earnings 
reg linc age ages edu1 edu2 edu3 edu4 hours* xr14 female 
est store c1

reg linc age ages edu1 edu2 edu3 edu4 hours* xr14 if female == 1
est store c2

reg linc age ages edu1 edu2 edu3 edu4 hours* xr14 if female == 0
est store c3

cd "C:\Users\JensB\Documents\Kandidat\2. semester\Labor\Output" 
outreg2 [c*] using output1, word 


// 							Regression 2: Testing The Individual Differences Hypothesis
reg linc age ages edu1 edu2 edu3 edu4 hours* correctpk pe02 pe04 pe06 hs01 xr14 female
est store d1

reg linc age ages edu1 edu2 edu3 edu4 hours* correctpk pe02 pe04 pe06 hs01 xr14 if female == 1
est store d2

reg linc age ages edu1 edu2 edu3 edu4 hours* correctpk pe02 pe04 pe06 hs01 xr14 if female == 0
est store d3

cd "C:\Users\JensB\Documents\Kandidat\2. semester\Labor\Output" 
outreg2 [d*] using output2, word 


//							Regression 3: Productivity or employer discrimination?
reg linc age ages edu1 edu2 edu3 edu4 hours* correctpk pe02 pe04 pe06 hs01 xr14 socialdum socbea female
est store e1

reg linc age ages edu1 edu2 edu3 edu4 hours* correctpk pe02 pe04 pe06 hs01 xr14 socialdum socbea if female == 1
est store e2

reg linc age ages edu1 edu2 edu3 edu4 hours* correctpk pe02 pe04 pe06 hs01 xr14 socialdum socbea if female == 0
est store e3

cd "C:\Users\JensB\Documents\Kandidat\2. semester\Labor\Output" 
outreg2 [e*] using output3, word 
 
// 							Regression 4: Dividing the sample by age (for the discussion)
reg linc age ages edu1 edu2 edu3 edu4 hours* xr14 female if age < 31
est store f1

reg linc age ages edu1 edu2 edu3 edu4 hours* xr14 if female == 1 & age < 31
est store f2

reg linc age ages edu1 edu2 edu3 edu4 hours* xr14 if female == 0 & age < 31
est store f3

reg linc age ages edu1 edu2 edu3 edu4 hours* xr14 female if age > 30
est store f4

reg linc age ages edu1 edu2 edu3 edu4 hours* xr14 if female == 1 & age > 30
est store f5

reg linc age ages edu1 edu2 edu3 edu4 hours* xr14 if female == 0 & age > 30
est store f6

cd "C:\Users\JensB\Documents\Kandidat\2. semester\Labor\Output" 
outreg2 [f*] using output4, word 

// 						Sum ratings of beauty for different characteristics of the inteviewer
sum xr14 if xi02 == 1
sum xr14 if xi02 == 2

sum xr14 if xi03 >= 40
sum xr14 if xi03 < 40

sum xr14 if xi04 >= 3
sum xr14 if xi04 < 3


							// Chance frame for the marginal analysis
frame change logit

//Create dependent variable
gen emp = 0
replace emp = 1 if work == 1
replace emp = 1 if work == 2

// 							Probit 1: Showing the relationship between beauty and earnings 
probit emp age ages edu1 edu2 edu3 edu4 xr14 female
margins, dydx(*) post
est store p4

probit emp age ages edu1 edu2 edu3 edu4 xr14 if female == 1
margins, dydx(*) post
est store p5

probit emp age ages edu1 edu2 edu3 edu4 xr14 if female == 0
margins, dydx(*) post
est store p6

cd "C:\Users\JensB\Documents\Kandidat\2. semester\Labor\Output" 
outreg2 [p*] using output1, word 

// 							Probit 2: Testing The Individual Differences Hypothesis
probit emp age ages edu1 edu2 edu3 edu4 correctpk pe02 pe04 pe06 hs01 xr14 female
margins, dydx(*) post
est store q1

probit emp age ages edu1 edu2 edu3 edu4 correctpk pe02 pe04 pe06 hs01 xr14 if female == 1
margins, dydx(*) post
est store q2

probit emp age ages edu1 edu2 edu3 edu4 correctpk pe02 pe04 pe06 hs01 xr14 if female == 0
margins, dydx(*) post
est store q3

cd "C:\Users\JensB\Documents\Kandidat\2. semester\Labor\Output" 
outreg2 [q*] using output2, word 

