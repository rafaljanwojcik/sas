libname dane 'D:\pulpit\SAS regresja';

/* tabela ze zmiennymi */
proc contents data=dane.ess8at;
run;

/* zachowanie wybranych zmiennych */
data austria_raw;
	set dane.ess8at;
	keep netustm trstprl Imwbcnt freehms sclmeet sclact health gndr emplrel hinctnta pdjobev iphlppl ipsuces maritalb hincfel wkhtot agea rlgblg pplfair wrkctra polintr chldhhe;
run;

/* sprawdzenie brakow danych */
proc means data=austria_raw nmiss;
run;

/* tabela czêstoœci wartoœci zmiennych */
proc freq data=austria_raw
	order=internal;
	tables netustm trstprl Imwbcnt freehms sclmeet sclact health gndr emplrel hinctnta pdjobev iphlppl ipsuces maritalb hincfel wkhtot agea rlgblg pplfair wrkctra polintr chldhhe /
		plots=freqplot;
run;

/* usuniêcie brakuj¹cych wartoœci 
6, 66, 666 - pytanie nie aplikowalne do danego ankietowanego
7, 77, 777 - ankietowany odmówi³ udzielenia odpowiedzi
8, 88, 888 - "nie wiem"
9, 99, 999 - brak odpowiedzi - wynika z przeoczenia ankietowanego lub systemu 
wiêcej na https://www.europeansocialsurvey.org/docs/round4/survey/ESS4_data_protocol_e01_2.pdf */
data austria (rename=(
	netustm=uzycie_internetu_w_min 
	trstprl=zaufanie_do_rzadu
	Imwbcnt=wplyw_imigrantow
	freehms=geje_i_lesbijki
	sclmeet=czestotliwosc_spotkan
	sclact=udzial_aktywn_spoleczne
	health=zdrowie
	gndr=plec
	emplrel=stosunek_pracy
	hinctnta=przychod_domowy
	pdjobev=czy_kiedykolwiek_pracowales
	iphlppl=pomaganie_innym
	ipsuces=znaczenie_sukcesu
	maritalb=stan_malzenski
	hincfel=opinia_o_dochodzie_domu
	wkhtot=czas_pracy
	agea=wiek
	rlgblg=przynaleznosc_religijna
	pplfair=wykorzystywanie_przez_ludzi
	wrkctra=umowa_o_prace_flaga
	polintr=zainteresowanie_polityka
	chldhhe=mial_dzieci_w_domu_flaga
	));
	set austria_raw;

	if netustm in (6666,9999) 
		or trstprl in (77,88)
		or Imwbcnt in (77,88)
		or sclmeet in (77,88)
		or hinctnta in (77,88)
		or freehms in (7,8)
		or sclact in (7,8)
		or maritalb in (77,88)
		or wkhtot in (666,777,888)
		or agea = 999
		or pdjobev = 6 
		or iphlppl in (7,8)
		or emplrel = 7 
		or ipsuces = 7
		or rlgblg in (7,8)
		or pplfair = 88
		or wrkctra in (6,7,8)
		or polintr in (7,8)
		or chldhhe in (6,7,8) then
		delete;
run;

/* tabela czêstoœci wartoœci zmiennych */
proc freq data=austria
	order=internal;
	tables netustm trstprl Imwbcnt freehms sclmeet sclact health gndr emplrel hinctnta pdjobev iphlppl ipsuces maritalb hincfel wkhtot agea rlgblg pplfair wrkctra polintr chldhhe /
		plots=freqplot;
run;