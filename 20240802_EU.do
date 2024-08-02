

set more off
clear all 
cd "C:\Users\jpjor\Desktop\cd4"

unzipfile "C:\Users\jpjor\Downloads\Europe_NUTS_0_Demographics_and_Boundaries.zip" , replace

spshape2dta Europe_NUTS_0_Demographics_and_Boundaries.shp, saving(test01)  replace

use test01.dta , clear

*spset, modify shpfile(test01_shp) 

*grmap 


preserve
import excel "C:\Users\jpjor\Downloads\tec00013_page_spreadsheet.xlsx", sheet("Sheet 1 (2)") firstrow clear

*ssc install kountry
*net get kountry

gen NUTS = "AA"
	replace NUTS = "BE" if GEOLabels =="Belgium"
	replace NUTS = "BG" if GEOLabels =="Bulgaria"
	replace NUTS = "CZ" if GEOLabels =="Czechia"
	replace NUTS = "DK" if GEOLabels =="Denmark"
	replace NUTS = "DE" if GEOLabels =="Germany"
	replace NUTS = "EE" if GEOLabels =="Estonia"
	replace NUTS = "IE" if GEOLabels =="Ireland"
	replace NUTS = "EL" if GEOLabels =="Greece"
	replace NUTS = "ES" if GEOLabels =="Spain"
	replace NUTS = "FR" if GEOLabels =="France"
	replace NUTS = "HR" if GEOLabels =="Croatia"
	replace NUTS = "IT" if GEOLabels =="Italy"
	replace NUTS = "CY" if GEOLabels =="Cyprus"
	replace NUTS = "LV" if GEOLabels =="Latvia"
	replace NUTS = "LT" if GEOLabels =="Lithuania"
	replace NUTS = "LU" if GEOLabels =="Luxembourg"
	replace NUTS = "HU" if GEOLabels =="Hungary"
	replace NUTS = "MT" if GEOLabels =="Malta"
	replace NUTS = "NL" if GEOLabels =="Netherlands"
	replace NUTS = "AT" if GEOLabels =="Austria"
	replace NUTS = "PL" if GEOLabels =="Poland"
	replace NUTS = "PT" if GEOLabels =="Portugal"
	replace NUTS = "RO" if GEOLabels =="Romania"
	replace NUTS = "SI" if GEOLabels =="Slovenia"
	replace NUTS = "SK" if GEOLabels =="Slovakia"
	replace NUTS = "FI" if GEOLabels =="Finland"
	replace NUTS = "SE" if GEOLabels =="Sweden"
	replace NUTS = "IS" if GEOLabels =="Iceland"
	replace NUTS = "LI" if GEOLabels =="Liechtenstein"
	replace NUTS = "NO" if GEOLabels =="Norway"
	replace NUTS = "HR" if GEOLabels =="Switzerland"
	replace NUTS = "UK" if GEOLabels =="United Kingdom"
	replace NUTS = "BA" if GEOLabels =="Bosnia and Herzegovina"
	replace NUTS = "ME" if GEOLabels =="Montenegro"
	replace NUTS = "MK" if GEOLabels =="North Macedonia"
	replace NUTS = "AL" if GEOLabels =="Albania"
	replace NUTS = "RS" if GEOLabels =="Serbia"
	replace NUTS = "TR" if GEOLabels =="Türkiye"
	replace NUTS = "XK" if GEOLabels =="Kosovo*"
save "C:\Users\jpjor\Downloads\20240802_EU.dta", replace
restore 

merge 1:m NUTS using "C:\Users\jpjor\Downloads\20240802_EU.dta"
*drop if _merge!=3
drop _merge

generate GDP2012 = real(C2012) 
drop if GDP2012==.
drop if _ID==.

spset, modify shpfile(test01_shp) 
grmap GDP2012 ,  title("Lisbon Civil Parishes")  fc(Blues2) // clm(unique)


