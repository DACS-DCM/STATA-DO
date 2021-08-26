*this .do file contains an algorithms that converts general string variables to a several numerical variables in a reversible manner. Several numerical variables are needed (generally), due to problems with precision of doubles.
*precisely, with the encoding scheme used here, only strings of maximum length of 7 can be converted to doubles in a reversible manner. Strings longer than 8 characters long will be converted to a double of size > 9*10^16 for which doubles do not have absolute precision.
*the code therefore splits strings into several string variables where each entry has a maximum of 7 characters. these individual strings are then converted to doubles in a reversible manner.


*** 	MUST NOT CONTAIN VARIABLES STARTING WITH:  		***
*** 		copy, char, num, or comb					***
*** 	ANY VARIABLES WITH SUCH NAMES WILL BE DELETED 	***


***		ALWAYS RUN THE DECODER AND TEST .do FILES TO	***
***		MAKE SURE THAT NO DATA IS LOST					***


*** LOAD DATA ***
*use "dat", clear



*** FIND ALL STRING VARS EXCEPT CPR ***
**displays all variables the code will affect, unless some variables are dropped in the "TRIM DATA SET" section**
ds, has(type string) 
local strvars `r(varlist)'
local excludeCPR "CPR"
local strvars : list strvars - excludeCPR
bro `strvars'
di "`strvars'"


*** TRIM DATA SET ***
**drop unneeded variables and "illegal" variables**
*drop dropvar1 dropvar2



*** RENAME ***
**rename variables that have too long names**
*rename varname1 newvarname1
*rename varname2 newvarname2



*** ENCODER BEGINS ***

*updating varlist
ds, has(type string) 
local strvars `r(varlist)'
local excludeCPR "CPR"
local strvars : list strvars - excludeCPR


foreach currentvar of varlist `strvars'{

	**PREPROCESS**
	gen copy = lower(`currentvar')
	replace copy = subinstr(copy,"æ","ae",.)
	replace copy = subinstr(copy,"ø","oe",.)
	replace copy = subinstr(copy,"å","aa",.)
	replace copy = subinstr(copy,"Æ","ae",.)
	replace copy = subinstr(copy,"Ø","oe",.)
	replace copy = subinstr(copy,"Å","aa",.)
	gen copy_len = strlen(copy)
	sum copy_len, meanonly
	local N = r(max)
	local i = 1
	
	**SPLITTER 1**
	while `N' > 0{
		gen `currentvar'_c`i' = substr(copy,1,7)
		replace copy = substr(copy,8,.)
		replace copy_len = strlen(copy)
		sum copy_len, meanonly
		local N = r(max)
		di `N'
		local i = `i'+1
	}
	drop copy*

	foreach v of varlist `currentvar'_c*{
		gen copy = `v'
		gen copy_len = strlen(copy)
		sum copy_len, meanonly
		local N = r(max)
		local a = r(max)
		local i = 1
		
		**SPLITTER 2**
		*split into several character strings
		while `a' > 0{
			gen char_temp`i' = substr(copy,1,1)
			replace copy = substr(copy,2,.)
			replace copy_len = strlen(copy)
			sum copy_len, meanonly
			local a = r(max)
			local i = `i'+1
		}
		
		**TRANSFORM 1**
		forval i = 1/`N'{
			gen num_temp`i' = .
			replace num_temp`i' = 0 		if char_temp`i' == ""
			replace num_temp`i' = 1 		if char_temp`i' == "a"
			replace num_temp`i' = 2			if char_temp`i' == "b"
			replace num_temp`i' = 3			if char_temp`i' == "c"
			replace num_temp`i' = 4			if char_temp`i' == "d"
			replace num_temp`i' = 5			if char_temp`i' == "e"
			replace num_temp`i' = 6			if char_temp`i' == "f"
			replace num_temp`i' = 7			if char_temp`i' == "g"
			replace num_temp`i' = 8			if char_temp`i' == "h"
			replace num_temp`i' = 9			if char_temp`i' == "i"
			replace num_temp`i' = 10 		if char_temp`i' == "j"
			replace num_temp`i' = 11		if char_temp`i' == "k"
			replace num_temp`i' = 12 		if char_temp`i' == "l"
			replace num_temp`i' = 13 		if char_temp`i' == "m"
			replace num_temp`i' = 14		if char_temp`i' == "n"
			replace num_temp`i' = 15		if char_temp`i' == "o"
			replace num_temp`i' = 16 		if char_temp`i' == "p"
			replace num_temp`i' = 17 		if char_temp`i' == "q"
			replace num_temp`i' = 18 		if char_temp`i' == "r"
			replace num_temp`i' = 19 		if char_temp`i' == "s"
			replace num_temp`i' = 20 		if char_temp`i' == "t"
			replace num_temp`i' = 21 		if char_temp`i' == "u"
			replace num_temp`i' = 22 		if char_temp`i' == "v"
			replace num_temp`i' = 23 		if char_temp`i' == "w"
			replace num_temp`i' = 24 		if char_temp`i' == "x"
			replace num_temp`i' = 25 		if char_temp`i' == "y"
			replace num_temp`i' = 26 		if char_temp`i' == "z"
			replace num_temp`i' = 27 		if char_temp`i' == "æ"
			replace num_temp`i' = 28 		if char_temp`i' == "ø"
			replace num_temp`i' = 29 		if char_temp`i' == "å"
			replace num_temp`i' = 30 		if char_temp`i' == " "
			replace num_temp`i' = 31 		if char_temp`i' == "."
			replace num_temp`i' = 32 		if char_temp`i' == ","
			replace num_temp`i' = 33 		if char_temp`i' == "_"
			replace num_temp`i' = 34 		if char_temp`i' == "-"
			replace num_temp`i' = 35 		if char_temp`i' == "0"
			replace num_temp`i' = 36 		if char_temp`i' == "1"
			replace num_temp`i' = 37 		if char_temp`i' == "2"
			replace num_temp`i' = 38 		if char_temp`i' == "3"
			replace num_temp`i' = 39 		if char_temp`i' == "4"
			replace num_temp`i' = 40 		if char_temp`i' == "5"
			replace num_temp`i' = 41 		if char_temp`i' == "6"
			replace num_temp`i' = 42 		if char_temp`i' == "7"
			replace num_temp`i' = 43 		if char_temp`i' == "8"
			replace num_temp`i' = 44 		if char_temp`i' == "9"
			replace num_temp`i' = 45		if char_temp`i' == "*"
			replace num_temp`i' = 46		if char_temp`i' == "´"
			replace num_temp`i' = 47		if char_temp`i' == "!"
			replace num_temp`i' = 48		if char_temp`i' == "Ø"
			replace num_temp`i' = 49		if char_temp`i' == "+"
			replace num_temp`i' = 50		if char_temp`i' == "/"
			replace num_temp`i' = 51		if char_temp`i' == "("
			replace num_temp`i' = 52		if char_temp`i' == ")"
			replace num_temp`i' = 53		if char_temp`i' == "%"	
			replace num_temp`i' = 54		if char_temp`i' == "<"	
			replace num_temp`i' = 55		if char_temp`i' == ">"	
			replace num_temp`i' = 56		if char_temp`i' == ":"	
		}

		**COMBINER 1**
		gen double comb_temp = 0
		forval i = 1/`N'{
			replace comb_temp = comb_temp + num_temp`i'*(10^(2*(`i'-1)))
		}
		
		gen double `v'_num = comb_temp
		order `v'_num, after(`v')
		drop `v' copy* char* num* comb*
		
	}



}

*dropping string vars except CPR
ds, has(type string) 
local strvars `r(varlist)'
local excludeCPR "CPR"
local strvars : list strvars - excludeCPR
drop `strvars'

*** END OF ENCODER ***




*** SAVE DATA ***
save "dat_encoded", replace







