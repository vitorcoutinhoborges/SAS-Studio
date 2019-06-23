ods graphics on; 
 
proc glm data=import plots=all; 
	class Group; 
	model BWeight_kg = Group / ss3; 
	lsmeans Group / adjust=bon cl; 
run; 

* avaliação da multicolinearidade entre as variáveis bPL30_114, bPL121_219, bPL_8_0; 
 
proc reg data=import; 
	model BWeight_kg = bPL30_114 bPL121_219 bPL_8_0 / collin vif; 
run; 

*Avaliação de multicolinearidade entre as variáveis bPL017,	bPL1,	bPL6,	bPL12,	bPL24;	

proc reg data=import; 
	model BWeight_kg = bPL017 bPL1 bPL6 bPL12 bPL24/ collin vif; 
run; 
**Retorna multicolinearidade entre 3 variáveis (bPL017,	bPL1,	bPL6);
*sem bpl6;
proc reg data=import; 
	model BWeight_kg = bPL017 bPL1 bPL12 bPL24/ collin vif; 
run; 

*multicolinearidade entre bpl1 e bpl17

*sem bpl1, Avaliação de multicolinearidade entre as variáveis bPL017, bPL6, bPL12,	bPL24;	

proc reg data=import; 
	model BWeight_kg = bPL017 bPL6 bPL12 bPL24/ collin vif; 
run; 
proc corr data=import; 
	var bPL017 bPL6 bPL12 bPL24 ; 
run; 
*Não retorna multicolinearidade, ajustando glm com efeito de grupo.;

proc glm data=import plots=all; 
	class Group bPL017 bPL6 bPL12 bPL24; 
	model BWeight_kg = Group  / ss3; 
	lsmeans Group / adjust=bon cl; 
run;
*****************************************************************

**Avaliando Multicolinearidade para as variáveis IGF11,	IGF124;

proc reg data=import;
	model BWeight_kg = IGF124 IGF11	 / collin vif; 
run; 

proc corr data=import; 
	var IGF124 IGF11 ; 
run; 

*Não apontou multicolinearidade, ajustando glm com efeito de grupo;

proc glm data=import plots=all; 
	class Group; 
	model BWeight_kg = Group IGF124 IGF11 / ss3; 
	lsmeans Group / adjust=bon cl; 
run; 

**Avaliando MultiColinearidade entre as variáveis PSPB1, PSPB6,	PSPB12, PSPB24;
proc reg data=import;
	model BWeight_kg = PSPB1 PSPB6 PSPB12 PSPB24 / collin vif; 
run; 
proc corr data=import; 
	var PSPB1 PSPB6 PSPB12 PSPB24 ; 
run; 
**Apresentou multicolinearidade entre as variáveis PSPB1, PSPB6 E PSPB12.
*testando modelo sem PSPB1;

proc reg data=import;
	model BWeight_kg = PSPB6 PSPB12 PSPB24 / collin vif; 
run; 
**Multicolinearidade entre PSPB6 e PSPB24
*testando modelo sem PSPB6;
proc reg data=import;
	model BWeight_kg = PSPB1 PSPB12 PSPB24 / collin vif; 
run; 
proc corr data=import; 
	var PSPB1 PSPB12 PSPB24 ; 
run; 
*multicolinearidade entre PSPB1 E PSPB24
testando modelo sem PSPB6 e PSPB1;
proc reg data=import;
	model BWeight_kg = PSPB12 PSPB24 / collin vif; 
run; 
proc corr data=import; 
	var PSPB12 PSPB24 ; 
run;
*multicolinearidade entre as variáveis, ajustando um modelo com efeito de grupo para cada.
**PSPB12;

proc glm data=import plots=all; 
	class Group; 
	model BWeight_kg = Group PSPB12/ ss3; 
	lsmeans Group / adjust=bon cl; 
run; 

***PSPB24;

proc glm data=import plots=all; 
	class Group; 
	model BWeight_kg = Group PSPB24/ ss3; 
	lsmeans Group / adjust=bon cl; 
run;
*************************************************************

**Avaliando Multicolinearidade entre as variáveis RecTemp017, RecTemp1, RecTemp6, RecTemp12,
RecTemp24;  
proc reg data=import;
	model BWeight_kg = RecTemp017 RecTemp1 RecTemp12 RecTemp24 / collin vif; 
run; 
proc corr data=import; 
	var RecTemp017 RecTemp1 RecTemp12 RecTemp24 ; 
run;
*Apresentou Multicolinearidade entre RecTemp12 e RecTemp24
* retirando Rectemp12;
proc reg data=import;
	model BWeight_kg = RecTemp017 RecTemp1 RecTemp24 / collin vif; 
run; 
proc corr data=import; 
	var RecTemp017 RecTemp1 RecTemp24 ; 
run;
*nao retornou multicolinearidade, ajustando glm para o modelo;

proc glm data=import plots=all; 
	class Group; 
	model BWeight_kg = Group RecTemp017 RecTemp1 RecTemp24/ ss3; 
	lsmeans Group / adjust=bon cl; 
run;
**************************************************************

**Avaliando Multicolinearidade entre as variáveis HeartRate017,	HeartRate1,	HeartRate6
HeartRate12	HeartRate24;	
proc reg data=import;
model BWeight_kg = HeartRate017 HeartRate1 HeartRate6 HeartRate12 HeartRate24 / collin vif;
run;
proc corr data=import; 
	var HeartRate017 HeartRate1 HeartRate6 HeartRate12 HeartRate24 ; 
run;
*Multicolinearidade entre HeartRate1 HeartRate12  e HeartRate24;
*retirando HearRate12;
proc reg data=import;
model BWeight_kg = HeartRate017 HeartRate1 HeartRate6 HeartRate24 / collin vif;
run;
proc corr data=import; 
	var HeartRate017 HeartRate1 HeartRate6 HeartRate24 ; 
run;
*multicolinearidade entre HearRate 1 e HeartRate24, testando modelo original sem HearRate1;
proc reg data=import;
model BWeight_kg = HeartRate017 HeartRate6 HeartRate12 HeartRate24 / collin vif;
run;
proc corr data=import; 
	var HeartRate017 HeartRate6 HeartRate12 HeartRate24 ; 
run;
*multicolinearidade entre HeartRate12 e HeartRat24, retirando HeartRate1 e HeartRate12;
proc reg data=import;
model BWeight_kg = HeartRate017 HeartRate6 HeartRate24 / collin vif;
run;
proc corr data=import; 
	var HeartRate017 HeartRate6 HeartRate24 ; 
run;
**multicolinearidade entre HeartRate6 e HeartRate24, testando um modelo para cada;
*sem HeartRate6;

proc reg data=import;
model BWeight_kg = HeartRate017 HeartRate24 / collin vif;
run;
proc corr data=import; 
	var HeartRate017  HeartRate24 ; 
run;
*Multicolinearidade entre as variaveis, testando sem HeartRate24;
proc reg data=import;
model BWeight_kg = HeartRate017 HeartRate6 / collin vif;
run;
proc corr data=import; 
	var HeartRate017 HeartRate6; 
run;
*Multicolinearidade entre as variaveis, retirando HeartRate017;
proc reg data=import;
model BWeight_kg = HeartRate6 HeartRate24 / collin vif;
run;
proc corr data=import; 
	var HeartRate6 HeartRate24 ; 
run;
*multicolinearidade entre as variáveis, ajustando um glm para cada;
*HeartRate24;

proc glm data=import plots=all; 
	class Group; 
	model BWeight_kg = Group HeartRate24 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;

*HeartRate6;

proc glm data=import plots=all; 
	class Group; 
	model BWeight_kg = Group HeartRate6 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;

*HeartRate017;

proc glm data=import plots=all; 
	class Group; 
	model BWeight_kg = Group HeartRate017 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;

**************************************************************

**AvaliandoMulticolinearidade entre as variáveis RespRate017	RespRate1	RespRate6
RespRate12	RespRate24;
proc reg data=import;
model BWeight_kg = RespRate017 RespRate1 RespRate6 RespRate12 RespRate24 / collin vif;
run;
proc corr data=import; 
	var RespRate017 RespRate1 RespRate6 RespRate12 RespRate24; 
run;
*Multicolinearidade entre todas as variáveis
*semRespRate017;
proc reg data=import;
model BWeight_kg = RespRate1 RespRate6 RespRate12 RespRate24 / collin vif;
run;
proc corr data=import; 
	var RespRate1 RespRate6 RespRate12 RespRate24; 
run;
*multicolinetaridade entre RespRate6 e RespRate24
*semRespRate1;
proc reg data=import;
model BWeight_kg = RespRate017  RespRate6 RespRate12 RespRate24 / collin vif;
run;
proc corr data=import; 
	var RespRate017  RespRate6 RespRate12 RespRate24; 
run;
*Multicolinearidade entre RespRate6 RespRate12 e RespRate24
*sem RespRate6;

proc reg data=import;
model BWeight_kg = RespRate017 RespRate1 RespRate12 RespRate24 / collin vif;
run;
proc corr data=import; 
	var RespRate017 RespRate1 RespRate12 RespRate24; 
run;
*multicolinearidade entre RespRate017 e RespRate1
*sem RespRate12;
proc reg data=import;
model BWeight_kg = RespRate017 RespRate1 RespRate6 RespRate24 / collin vif;
run;
proc corr data=import; 
	var RespRate017 RespRate1 RespRate6 RespRate24; 
run;
*multicolinearidade entre todas
*sem RespRate017 e RespRate1;
proc reg data=import;
model BWeight_kg = RespRate6 RespRate12 RespRate24 / collin vif;
run;
proc corr data=import; 
	var RespRate017 RespRate1 RespRate6 RespRate12 RespRate24; 
run;
*multicolinearidade entre RespRate6 e RespRate24
*sem RespRate017, RespRate 1 e RespRate6;
proc reg data=import;
model BWeight_kg = RespRate12 RespRate24 / collin vif;
run;
proc corr data=import; 
	var RespRate12 RespRate24; 
run;
*sem multicolinearidade, ajustando glm com efeito de grupo para o modelo;

proc glm data=import plots=all; 
	class Group; 
	model BWeight_kg = Group RespRate12 RespRate24 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;
**************************************************************

**Avaliando Multicolinearidade entre as variáveis Glu017 Glu1 Glu6  Glu12 Glu24;
proc reg data=import;
model BWeight_kg = Glu017 Glu1 Glu6  Glu12 Glu24 / collin vif;
run;
proc corr data=import; 
	var Glu017 Glu1 Glu6  Glu12 Glu24; 
run;
*MultiColinearidade entre Glu6 e Glu12;
*retirando Glu12;
proc reg data=import;
model BWeight_kg = Glu017 Glu1 Glu6 Glu24 / collin vif;
run;
proc corr data=import; 
	var Glu017 Glu1 Glu6 Glu24; 
run;
*sem multicolinearidade, ajustando glm com efeito de grupo para o modelo;

proc glm data=import plots=all; 
	class Group; 
	model BWeight_kg = Group Glu017 Glu1 Glu6 Glu24 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;
**************************************************************

**Avaliando Multicolinearidade entre as variáveis PCV017 PCV1;
proc reg data=import;
model BWeight_kg = PCV017 PCV1 / collin vif;
run;
proc corr data=import; 
	var PCV017 PCV1; 
run;
*Apresentou Multicolinearidade entre as variáveis
*retirando PCV1, ajustando glm com efeito de grupo para PCV017;
proc glm data=import plots=all; 
	class Group ; 
	model BWeight_kg = Group PCV017/ ss3; 
	lsmeans Group / adjust=bon cl; 
run;
*glm's para Glength

Modelo Glength = Group bpl017 bpl6 bpl12 bpl24;

proc glm data=import plots=all; 
	class Group; 
	model Glength = Group bpl017 bpl6 bpl12 bpl24 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;

*Modelo Glength = Group IGF124 IGF11;

proc glm data=import plots=all; 
	class Group; 
	model Glength = Group IGF124 IGF11 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;

*Modelo Glength = Group PSPB12;

proc glm data=import plots=all; 
	class Group; 
	model Glength = Group PSPB12 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;

*Modelo Glength = Group PSPB24;

proc glm data=import plots=all; 
	class Group; 
	model Glength = Group PSPB24 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;

*Modelo Glength = Group RecTemp017 RecTemp1 RecTemp24;

proc glm data=import plots=all; 
	class Group; 
	model Glength = Group RecTemp017 RecTemp1 RecTemp24 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;

*Modelo Glength = Group HeartRate24;

proc glm data=import plots=all; 
	class Group; 
	model Glength = Group HeartRate24 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;
*Modelo Glength = Group HeartRate6;

proc glm data=import plots=all; 
	class Group; 
	model Glength = Group HeartRate6 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;
*Modelo Glength = Group  HeartRate017;

proc glm data=import plots=all; 
	class Group; 
	model Glength = Group  HeartRate017 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;
*Modelo Glength = Group  RespRate12 RespRate24; 

proc glm data=import plots=all; 
	class Group; 
	model Glength = Group RespRate12 RespRate24 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;
*Modelo Glength = Group Glu017 Glu1 Glu6 Glu24;

proc glm data=import plots=all; 
	class Group; 
	model Glength = Group Glu017 Glu1 Glu6 Glu24 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;
*Modelo Glength = Group PCV017;

proc glm data=import plots=all; 
	class Group; 
	model Glength = Group PCV017 / ss3; 
	lsmeans Group / adjust=bon cl; 
run;
*Modelo Glength = Group B1_7 B8_16;

proc glm data=import plots=all; 
	class Group; 
	model Glength = Group B1_7 B8_16/ ss3; 
	lsmeans Group / adjust=bon cl; 
run;
