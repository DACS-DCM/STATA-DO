***LOAD DATA***
use "dat_encoded", clear


*** DECODER BEGINS ***

foreach v of varlist *_c1_num{

	**FIND ALL RELEVANT VARNAMES**
	unab w : `v'
	local pos = strpos("`w'","c1")
	local w = substr("`w'",1,`pos')
	di "`w'"
	foreach z of varlist `w'*{
		
		
		**The "TOSTRING"-er**
		tostring `z', gen(`z'_comb) format(%16.8g) 
		replace `z'_comb = "" if `z'_comb == "."
		replace `z'_comb = "0"+`z'_comb if mod(strlen(`z'_comb),2)
		gen `z'_combl = strlen(`z'_comb)
		sum `z'_combl, meanonly
		local N = r(max)
		local a = r(max)
		local i = 1

		**SPLITTER 3**
		*split into several 2-character strings
		while `a' > 0{
			gen `z'_code`i' = substr( `z'_comb,1,2)
			replace  `z'_comb = substr( `z'_comb,3,.)
			replace  `z'_combl = strlen( `z'_comb)
			sum  `z'_combl, meanonly
			local a = r(max)
			local i = `i'+1
		}
		*N will always be even
		local N = `N'/2

		**TRANSFORM 2**
		forval i = 1/`N'{
			gen `z'_ct`i' = ""
			replace  `z'_ct`i' = "" 		if `z'_code`i' == "00"
			replace `z'_ct`i' = "a" 		if `z'_code`i' == "01"
			replace `z'_ct`i' = "b"			if `z'_code`i' == "02"
			replace `z'_ct`i' = "c"			if `z'_code`i' == "03"
			replace `z'_ct`i' = "d"			if `z'_code`i' == "04"
			replace `z'_ct`i' = "e"			if `z'_code`i' == "05"
			replace `z'_ct`i' = "f"			if `z'_code`i' == "06"
			replace `z'_ct`i' = "g"			if `z'_code`i' == "07"
			replace `z'_ct`i' = "h"			if `z'_code`i' == "08"
			replace `z'_ct`i' = "i"			if `z'_code`i' == "09"
			replace `z'_ct`i' = "j" 		if `z'_code`i' == "10"
			replace `z'_ct`i' = "k"			if `z'_code`i' == "11"
			replace `z'_ct`i' = "l" 		if `z'_code`i' == "12"
			replace `z'_ct`i' = "m" 		if `z'_code`i' == "13"
			replace `z'_ct`i' = "n"			if `z'_code`i' == "14"
			replace `z'_ct`i' = "o"			if `z'_code`i' == "15"
			replace `z'_ct`i' = "p" 		if `z'_code`i' == "16"
			replace `z'_ct`i' = "q" 		if `z'_code`i' == "17"
			replace `z'_ct`i' = "r" 		if `z'_code`i' == "18"
			replace `z'_ct`i' = "s" 		if `z'_code`i' == "19"
			replace `z'_ct`i' = "t" 		if `z'_code`i' == "20"
			replace `z'_ct`i' = "u" 		if `z'_code`i' == "21"
			replace `z'_ct`i' = "v" 		if `z'_code`i' == "22"
			replace `z'_ct`i' = "w" 		if `z'_code`i' == "23"
			replace `z'_ct`i' = "x" 		if `z'_code`i' == "24"
			replace `z'_ct`i' = "y"			if `z'_code`i' == "25"
			replace `z'_ct`i' = "z" 		if `z'_code`i' == "26"
			replace `z'_ct`i' = "æ" 		if `z'_code`i' == "27"
			replace `z'_ct`i' = "ø" 		if `z'_code`i' == "28"
			replace `z'_ct`i' = "å" 		if `z'_code`i' == "29"
			replace `z'_ct`i' = " " 		if `z'_code`i' == "30"
			replace `z'_ct`i' = "." 		if `z'_code`i' == "31"
			replace `z'_ct`i' = "," 		if `z'_code`i' == "32"
			replace `z'_ct`i' = "_" 		if `z'_code`i' == "33"
			replace `z'_ct`i' = "-" 		if `z'_code`i' == "34"
			replace `z'_ct`i' = "0" 		if `z'_code`i' == "35"
			replace `z'_ct`i' = "1" 		if `z'_code`i' == "36"
			replace `z'_ct`i' = "2" 		if `z'_code`i' == "37"
			replace `z'_ct`i' = "3"			if `z'_code`i' == "38"
			replace `z'_ct`i' = "4" 		if `z'_code`i' == "39"
			replace `z'_ct`i' = "5" 		if `z'_code`i' == "40"
			replace `z'_ct`i' = "6" 		if `z'_code`i' == "41"
			replace `z'_ct`i' = "7" 		if `z'_code`i' == "42"
			replace `z'_ct`i' = "8" 		if `z'_code`i' == "43"
			replace `z'_ct`i' = "9" 		if `z'_code`i' == "44"
			replace `z'_ct`i' = "*"			if `z'_code`i' == "45"
			replace `z'_ct`i' = "´"			if `z'_code`i' == "46"
			replace `z'_ct`i' = "!"			if `z'_code`i' == "47"
			replace `z'_ct`i' = "Ø"			if `z'_code`i' == "48"
			replace `z'_ct`i' = "+"			if `z'_code`i' == "49"
			replace `z'_ct`i' = "/"			if `z'_code`i' == "50"
			replace `z'_ct`i' = "("			if `z'_code`i' == "51"
			replace `z'_ct`i' = ")"			if `z'_code`i' == "52"
			replace `z'_ct`i' = "%"			if `z'_code`i' == "53"
			replace `z'_ct`i' = "<"			if `z'_code`i' == "54"
			replace `z'_ct`i' = ">"			if `z'_code`i' == "55"
			replace `z'_ct`i' = ":"			if `z'_code`i' == "56"
		}

		
		**COMBINER 2**
		*combining into split vars
		gen `z'_decode = ""
		forval i = 1/`N'{
			local j = (`N'-`i'+1)
			replace `z'_decode = `z'_decode + `z'_ct`j'
		}

		*drop excess vars
		unab name_done : `z' 
		local pos = strpos("`name_done'","_num")
		local name_done = substr("`name_done'",1,`pos')
		gen `name_done'd = `z'_decode
		drop `z'_decode `z'_comb* `z'_code* `z'_ct*
		
	}
	
	**COMBINER 3**
	*combine split vars into final string vars
	local pos = strpos("`w'","_c")
	local w = substr("`w'",1,`pos')
	gen `w'done = ""
	unab vars : `w'c*_d
	local N = `: word count `vars''
	
	forval i = 1/`N'{
		replace `w'done = `w'done+`w'c`i'_d
	}
	drop `vars'
	
}

drop *_c*_num

*** DECODER ENDS ***

** RENAME **
*if variables were renamed in the encoder, rename them back here
*rename newvarname1 varname1
*rename newvarname2 varname2



** SAVE DATA **
*save "dat_decoded", replace






