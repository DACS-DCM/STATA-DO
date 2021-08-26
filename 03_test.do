************
*** TEST ***
************
*check if the decoded variables are equal to the original variables upto upper/lowercase and transforming danish letters æøåÆØÅ


** LOAD ORIGINAL DATA **
*use "dat", clear

ds, has(type string) 
local strvars `r(varlist)'

**if some variables were dropped before the encoder, add those varnames to the following exclude list:**
*local excludevars "CPR FORLOEBS_ID DATABASE ANGIV_AARSAG HVAD HVAD_EFTER HVILKEN"

local strvars : list strvars - excludevars
bro `strvars'
di "`strvars'"




** MERGE WITH DECODED DATA **
**idvars should be a combination of variables that uniquely identifies observations**
*merge 1:1 idvars using "dat_decoded", nogen

** COUNT NUMBER OF SIGNIFICANT DIFFERENCES **
foreach v of varlist `strvars'{
	
	quietly gen copy = lower(`v')
	quietly replace copy = subinstr(copy,"æ","ae",.)
	quietly replace copy = subinstr(copy,"ø","oe",.)
	quietly replace copy = subinstr(copy,"å","aa",.)
	quietly replace copy = subinstr(copy,"Æ","ae",.)
	quietly replace copy = subinstr(copy,"Ø","oe",.)
	quietly replace copy = subinstr(copy,"Å","aa",.)
	di "`v'"
	count if copy != `v'_done
	quietly drop copy
}
*displays number of significant differences between original and decoded variable.
*a significant difference is one that is any difference that is not due to danish letters or lower/upper case discrepancies.
*if the code produced no errors it means that every relevant string variable has been encoded and decoded (since if `v'_done doesn't exist then the loop fails).




** CHECK THE DIFFERENCES IF THERE ARE ANY**
*'varwithdifferences' should be a variable that needs to be checked. variable name should come from the OG data set
/*
gen copy = lower(varwithdifferences)
replace copy = subinstr(copy,"æ","ae",.)
replace copy = subinstr(copy,"ø","oe",.)
replace copy = subinstr(copy,"å","aa",.)
replace copy = subinstr(copy,"Æ","ae",.)
replace copy = subinstr(copy,"Ø","oe",.)
replace copy = subinstr(copy,"Å","aa",.)

di "`v'"
count if copy != varwithdifferences_done
bro varwithdifferences* if copy != varwithdifferences_done
*/



