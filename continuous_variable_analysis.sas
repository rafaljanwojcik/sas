/* statystyki opisowe */
proc means data=austria mean std min max q1 median q3 skewness kurtosis maxdec=3;
	var AGEA;
run;

/* histogram */
proc univariate 
	data=austria;
	var AGEA;
	histogram / normal;
run;

/* wykres pude³kowy */
proc sgplot data=austria;
	vbox AGEA;
run;
