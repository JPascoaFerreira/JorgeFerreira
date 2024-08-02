

set more off
clear all 
cd "C:\Users\jpjor\Desktop\cd"

unzipfile Carta_Administrativa_Oficial_Portugal_CAOP2019.zip , replace

spshape2dta Cont_AAD_CAOP2019.shp, saving(test02) replace

use test02.dta

preserve
import excel "C:\Users\jpjor\Downloads\Test_MAPS.xls", sheet("Quadro") firstrow case(upper) clear
*drop HospedesPorHabitante_2022 // Bombeiros_1998
drop if CONCELHO==""
gen Concelho = upper(CONCELHO)
drop CONCELHO
/*
// Find duplicates based on the string variable
duplicates report `Concelho'
// List the duplicates
duplicates list `Concelho'
// If you want to tag duplicates, you can use:
duplicates tag `string_var', generate(dup_tag)
// List the observations tagged as duplicates
list if dup_tag
*/
save "C:\Users\jpjor\Downloads\Test_MAPS.dta", replace
restore
merge m:1 Concelho using "C:\Users\jpjor\Downloads\Test_MAPS.dta"
drop if _merge==2

spset, modify shpfile(test02_shp)

grmap BOMBEIROS_1998, clnumber(99) title(Nr of Firemen by Council in 1998) subtitle() fc(Blues2) name(Bombeiros_1998, replace) legenda(off)

grmap HOSPEDESPORHABITANTE_2022, clnumber(99) title(Avg Nr of Guests per Resident in 2022) subtitle() fc(Greens2) name(HOSPEDESPORHABITANTE_2022, replace) legenda(off)

graph combine Bombeiros_1998 HOSPEDESPORHABITANTE_2022 

graph save "Graph" "C:\Users\jpjor\Downloads\20240726_FiremenVsTourists.gph"
graph export "C:\Users\jpjor\Downloads\20240726_FiremenVsTourists.jpg", as(jpg) name("Graph") quality(100)