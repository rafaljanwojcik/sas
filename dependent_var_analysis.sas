libname dane 'D:\pulpit\SAS regresja';

/* zachowanie wybranych zmiennych */
data austria_raw;
	set dane.ess8at;
	keep happy;
run;

proc freq data=austria_raw
	order=internal;
	tables happy /
		plots=freqplot;
run;