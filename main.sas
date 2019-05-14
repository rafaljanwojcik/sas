libname dane 'D:\pulpit\SAS regresja';

/* tabela ze zmiennymi */
proc contents data=dane.ess8at;
run;

/* zachowanie wybranych zmiennych */
data austria_raw;
	set dane.ess8at;
	keep AGEA TPORGWK;
run;

/* sprawdzenie brakow danych */
proc means data=austria_raw nmiss;
run;

/* tabela cz�sto�ci warto�ci zmiennych */
proc freq data=austria_raw
	order=internal;
	tables AGEA TPORGWK /
		plots=freqplot;
run;

/* usuni�cie brakuj�cych warto�ci 
6, 66, 666 - pytanie nie aplikowalne do danego ankietowanego
7, 77, 777 - ankietowany odm�wi� udzielenia odpowiedzi
8, 88, 888 - "nie wiem"
9, 99, 999 - brak odpowiedzi - wynika z przeoczenia ankietowanego lub systemu 
wi�cej na https://www.europeansocialsurvey.org/docs/round4/survey/ESS4_data_protocol_e01_2.pdf */
data austria;
	set austria_raw;

	if AGEA = 999 or TPORGWK in (66,77,88) then
		delete;
run;

/* ponowne sprawdzenie */
/* tabela cz�sto�ci warto�ci zmiennych */
proc freq data=austria
	order=internal;
	tables AGEA TPORGWK /
		plots=freqplot;
run;


