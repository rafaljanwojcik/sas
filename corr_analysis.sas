libname dane "sciezka do danych";

data temp;
set dane.ess8at;
keep pplhlp pplfair polintr wkhtot agea happy;
run;

data temp;
set work.temp;
if agea=999 
or happy in (99,88,77)
or pplfair in (77, 88, 99)
or pplhlp in (77, 88, 99)
or polintr in (77, 88, 99)
or wkhtot in (666, 777, 888, 999)
then delete;
run;

 
proc corr data=work.temp out=work.temp_report ; 
var happy agea wkhtot polintr pplfair pplhlp;
run;

proc report 
data = work.temp_report; 
title 'Macierz korelacji Pearsona'; 
define _name_ / display '' style=[font_weight=bold];
define happy / display 'celu' format = 5.2;
define agea / display 'wiek' format = 5.2; 
define wkhtot / display 'godziy_pracy' format = 5.2;
define polintr / display 'poglady_polityczne' format = 5.2; 
define pplfair / display 'ludzie_uczciwi' format = 5.2; 
define pplhlp / display 'ludzie_pomagaja' format = 5.2; 
run; 
/*VIF - Variance Inflation Factor*/
proc reg data=work.temp;
title 'Variance inflation factor';
model wkhtot= agea polintr pplfair pplhlp/vif;
model agea = polintr pplfair pplhlp/vif;
model polintr = pplfair pplhlp/vif;
model pplhlp = pplfair/vif;
run;
