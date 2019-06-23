PROC IMPORT DATAFILE=REFFILE 
	DBMS=XLSX 
	OUT=WORK.import; 
	GETNAMES=YES; 
RUN; 
 
PROC CONTENTS DATA=WORK.import;
RUN; 
 
 
%web_open_table(WORK.import); 
 
 
 
* Realizando Teste Qui-Quadrado de Fisher entre variáveis solicitadas pela Estudante; 
 
proc freq data=import; 
	table local*Q15 / chisq fisher; 
run; 
 
proc freq data=import; 
	table local*Q14_2 / chisq; 
run; 
 
 *Modificação necessária no banco;
data banco1; 
	set import; 
	if Q14_2 = "OBNS" then delete; 
run; 
 
proc freq data=banco1; 
	table local*Q14_2 ; 
run; 

proc freq data=import; 
	table Q4; 
run; 
		 
*Modificação necessária no banco;
data banco2; 
	set import; 
	if Q4 = "EB"; 
run; 
 
proc freq data=banco2; 
	table Q14_2; 
run; 
 
proc freq data=import; 
	table Q1; 
run; 
 *Modificação necessária no banco;
data banco3; 
	set import; 
	if Q18 = "SAS"; 
run; 
 *Teste Qui-QUadrado de Fisher;
proc freq data=banco3; 
	table Q18_2*Q1 / fisher ; 
run; 
 
 *Modificacção no Banco;
data banco4; 
	set banco3; 
	if Q18_2 = "SFNL" then delete; 
	if Q1 = "A" then Q1_recat = 1; 
	if Q1 = "AC" then Q1_recat = 1; 
	if Q1 = "AB" then Q1_recat = 2; 
	if Q1 = "ABC" then Q1_recat = 2; 
	if Q1 = "BC" then Q1_recat = 3; 
	if Q1 = "B" then Q1_recat = 3; 
run; 
 
proc freq data=banco4; 
	table Q1 Q1_recat / fisher; 
run; 
 
proc freq data=banco4; 
	table Q18_2*Q1_recat / fisher; 
run; 

*Modificação necessária no banco; 
data banco5; 
	set banco3; 
	if Q1 = "A" then Q1_recat = 1; 
	if Q1 = "AC" then Q1_recat = 1; 
	if Q1 = "AB" then Q1_recat = 2; 
	if Q1 = "ABC" then Q1_recat = 2; 
	if Q1 = "BC" then Q1_recat = 3; 
	if Q1 = "B" then Q1_recat = 3; 
run; 
 
 
proc freq data=banco5; 
	table Q3*Q1_recat / fisher; 
run; 
 
proc freq data=banco5; 
	table Q11*Q1_recat / fisher; 
run; 
 
 
 *Modificação necessária no banco;
data banco6; 
	set banco5; 
	if Q14_2 = "OBNS" then delete; 
run; 
 
proc freq data=banco6; 
	table Q14_2*Q1_recat / fisher; 
run; 
 
proc freq data=banco5; 
	table Q15*Q1_recat / fisher; 
run; 
 
 
proc freq data=banco5; 
	table Q17_SOMA; 
run; 
 
 *Análise descritiva de variável quantitativa;
proc means data=banco5 min p25 median p75 max mean stddev qrange; 
	class Q1_recat; 
	var Q17_SOMA; 
run; 
 
proc means data=import min p25 median p75 max mean stddev qrange; 
	class Q9; 
	var Q17_SOMA; 
run; 
 
proc means data=import min p25 median p75 max mean stddev qrange; 
	class Q15; 
	var Q17_SOMA; 
run; 
 
proc glm data=import plots=all; 
	class Q15; 
	model Q17_SOMA = Q15; 
run; 
 
ods noproctitle; 
 
 *Teste de Wilcoxon (não paramétrico) para comparação de médias;
proc npar1way data=import wilcoxon plots(only)=(wilcoxonboxplot); 
	class Q15; 
	var Q17_SOMA; 
run; 
 
proc means data=banco6 min p25 median p75 max mean stddev qrange; 
	class Q14_2; 
	var Q22; 
run; 
 
proc npar1way data=banco6 wilcoxon plots(only)=(wilcoxonboxplot); 
	class Q14_2; 
	var Q22; 
run; 
 
 
ods graphics / reset width=6.4in height=4.8in imagemap; 
 
proc sgplot data=WORK.import; 
	scatter x=Q22 y=Q17_SOMA /; 
	xaxis grid; 
	yaxis grid; 
run; 
 
ods graphics / reset; 
 
 
proc means data=import min p25 median p75 max mean stddev qrange; 
	class Q17_SOMA; 
	var Q22; 
run; 
 
data banco7; 
	set import; 
	if Q18_2 = "SFNL" then delete; 
	if Q18_2 = "SFNSA" then delete; 
run; 
 
proc means data=banco7 min p25 median p75 max mean stddev qrange; 
	class Q18_2; 
	var Q22; 
run; 
 
proc npar1way data=banco7 wilcoxon plots(only)=(wilcoxonboxplot); 
	class Q18_2; 
	var Q22; 
run; 
 
 
proc means data=import min p25 median p75 max mean stddev qrange; 
	class Q19; 
	var Q22; 
run; 
 
 
data banco8; 
	set import; 
	if Q1 = "A" then Q1_recat = 1; 
	if Q1 = "AC" then Q1_recat = 1; 
	if Q1 = "AB" then Q1_recat = 2; 
	if Q1 = "ABC" then Q1_recat = 2; 
	if Q1 = "BC" then Q1_recat = 3; 
	if Q1 = "B" then Q1_recat = 3; 
run; 
 
proc freq data=banco8; 
	table Local*Q1_recat; 
run; 
 
 
proc freq data=banco8; 
	table Municipio*Q1_recat / fisher; 
run; 
 
proc freq data=banco8; 
	table Q21*Q1_recat / fisher; 
run; 
 
 
 
proc means data=banco8 min p25 median p75 max mean stddev qrange; 
	class Q1_recat; 
	var Q22; 
run; 
 
proc npar1way data=banco8 wilcoxon plots(only)=(wilcoxonboxplot); 
	class Q1_recat; 
	var Q22; 
run; 
 
 
proc freq data=import; 
	table Q9*Q10 / fisher; 
run; 
 
 
data banco9; 
	set import; 
	if Q13 = "NC" then delete; 
run; 
 
proc freq data=banco9; 
	table Q9*Q13 / fisher; 
run; 
 
proc freq data=banco1; 
	table Q9*Q14_2 / fisher; 
run; 
 
 
proc freq data=import; 
	table Q9*Q15 / fisher; 
run; 
 
proc freq data=banco7; 
	table Q9*Q18_2 / fisher; 
run; 
 
proc freq data=import; 
	table Q9*Q19 / fisher; 
run; 
 
 
proc freq data=import; 
	table Q15*Q10 / fisher; 
run; 
 
proc freq data=banco1; 
	table Q15*Q14_2 / fisher; 
run; 
 
 
proc freq data=import; 
	table Q15*Q16 / fisher; 
run; 
 
proc freq data=import; 
	table Q15*Q18 / fisher; 
run; 
 
proc freq data=import; 
	table Q15*Q19 / fisher; 
run; 
 
 
proc freq data=banco1; 
	table Q21*Q14_2 / fisher; 
run; 
 
data banco10; 
	set import; 
	if Q18_2 = "SFNL" then delete; 
	if Q18_2 = "SFNSA" then delete; 
run; 
 
proc freq data=banco10; 
	table Q21*Q18_2 / fisher; 
run; 
 
proc freq data=banco10; 
	table Q23*Q18_2 / fisher; 
run; 
 
proc freq data=import; 
	table Q21*Q19 / fisher; 
run; 
 
data banco11; 
	set banco1; 
	if Q13 = "NC" then delete; 
run; 
 
proc freq data=banco11; 
	table Q13*Q14_2 / fisher; 
run; 
 
 
proc freq data=import; 
	table Q23*Q19; 
run; 
 

