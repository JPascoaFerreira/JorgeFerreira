

set more off
clear all 
cd "C:\Users\jpjor\Desktop\cd4"

unzipfile "C:\Users\jpjor\Downloads\gaul0_asap.zip" , replace

spshape2dta Europe_NUTS_0_Demographics_and_Boundaries.shp, saving(test01)  replace

use test01.dta , clear

spset, modify shpfile(test01_shp) 

grmap 

preserve
import excel "C:\Users\jpjor\Downloads\rail_pa_total_page_spreadsheet.xlsx", sheet("Sheet 1 (2)") firstrow clear
save "C:\Users\jpjor\Downloads\rail_pa_total_page_spreadsheet.dta" , replace
import excel "C:\Users\jpjor\Downloads\ilc_lvho02_page_spreadsheet.xlsx", sheet("Sheet 1 (2)") firstrow clear
save "C:\Users\jpjor\Downloads\ilc_lvho02_page_spreadsheet.dta" , replace
use "C:\Users\jpjor\Downloads\ilc_lvho02_page_spreadsheet.dta" , clear
rename B Share_Owners
merge 1:1 TIME using "C:\Users\jpjor\Downloads\rail_pa_total_page_spreadsheet.dta"
drop _merge
rename B RailPassengers_Millions
gen NUTS = "AA"
	replace NUTS = "BE" if TIME =="Belgium"
	replace NUTS = "BG" if TIME =="Bulgaria"
	replace NUTS = "CZ" if TIME =="Czechia"
	replace NUTS = "DK" if TIME =="Denmark"
	replace NUTS = "DE" if TIME =="Germany"
	replace NUTS = "EE" if TIME =="Estonia"
	replace NUTS = "IE" if TIME =="Ireland"
	replace NUTS = "EL" if TIME =="Greece"
	replace NUTS = "ES" if TIME =="Spain"
	replace NUTS = "FR" if TIME =="France"
	replace NUTS = "HR" if TIME =="Croatia"
	replace NUTS = "IT" if TIME =="Italy"
	replace NUTS = "CY" if TIME =="Cyprus"
	replace NUTS = "LV" if TIME =="Latvia"
	replace NUTS = "LT" if TIME =="Lithuania"
	replace NUTS = "LU" if TIME =="Luxembourg"
	replace NUTS = "HU" if TIME =="Hungary"
	replace NUTS = "MT" if TIME =="Malta"
	replace NUTS = "NL" if TIME =="Netherlands"
	replace NUTS = "AT" if TIME =="Austria"
	replace NUTS = "PL" if TIME =="Poland"
	replace NUTS = "PT" if TIME =="Portugal"
	replace NUTS = "RO" if TIME =="Romania"
	replace NUTS = "SI" if TIME =="Slovenia"
	replace NUTS = "SK" if TIME =="Slovakia"
	replace NUTS = "FI" if TIME =="Finland"
	replace NUTS = "SE" if TIME =="Sweden"
	replace NUTS = "IS" if TIME =="Iceland"
	replace NUTS = "LI" if TIME =="Liechtenstein"
	replace NUTS = "NO" if TIME =="Norway"
	replace NUTS = "HR" if TIME =="Switzerland"
	replace NUTS = "UK" if TIME =="United Kingdom"
	replace NUTS = "BA" if TIME =="Bosnia and Herzegovina"
	replace NUTS = "ME" if TIME =="Montenegro"
	replace NUTS = "MK" if TIME =="North Macedonia"
	replace NUTS = "AL" if TIME =="Albania"
	replace NUTS = "RS" if TIME =="Serbia"
	replace NUTS = "TR" if TIME =="Türkiye"
	replace NUTS = "XK" if TIME =="Kosovo*"
save "C:\Users\jpjor\Downloads\20240913_EU.dta", replace
restore

merge 1:m NUTS using "C:\Users\jpjor\Downloads\20240913_EU.dta"
*drop if _merge!=3
drop _merge

drop if _ID==.
sort _ID
drop in 22

spset, modify shpfile(test01_shp)

grmap RailPassengers_Millions, clnumber(10) title(RailPassengers_Millions_2014) subtitle() fc(Blues2) name(RailPassengers_Millions_2014, replace) legenda(off)

grmap Share_Owners, clnumber(10) title(Share_Owners_2023) subtitle() fc(Greens2) name(Share_Owners_2023, replace) legenda(off)

graph combine RailPassengers_Millions_2014 Share_Owners_2023 

graph save "Graph" "C:\Users\jpjor\Downloads\20240913_RailPassengerVsHomeOwner.gph"
graph export "C:\Users\jpjor\Downloads\20240913_RailPassengerVsHomeOwner.jpg", as(jpg) name("Graph") quality(100)

