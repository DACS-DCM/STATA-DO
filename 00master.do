* ProjectName
* Developed by: AuthorName
* DateCreated 20230214
* DateLastModified 20230215

* if you use linux search and replace \ with /

* Set Stata version
version 17.0

clear 
log close _all
set more off 

* Set current path
cd "\HomeDirectory\ProjectName\Code"

* Set global paths
global out = "..\Output\"
global log = "..\Log\"
global tmp = "..\TempData\"
global raw = "..\..\Rawdatacopy\"

set seed 42
set sortseed 42 

local mydate = string(d(`c(current_date)'),"%dCYND")
global tmpdate = `mydate'
log using "$log\session${tmpdate}.log" , text append 


******* call do-files for the project *******
* Generate date of inclusion, exposure variable, date of event\censoring and outcome variable
log using "${log}\exposure_and_outcome", replace smcl name(exposure_and_outcome)
do exposure_and_outcome.do
log close exposure_and_outcome

* Run crude analysis
* Argument 1: longest follow-up in years
log using "${log}\crude_analysis", replace smcl name(crude_analysis)
* one year follow-up
do crude_analysis.do 1
* two year follow-up
do crude_analysis.do 2
log close crude_analysis
*********************************************



capture log close 
clear 
exit 
* keep some blank line here:




