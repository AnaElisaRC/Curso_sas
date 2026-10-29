/*******************************************************
* PROGRAMA: 05
* AUTOR: Ana Elisa Rubinato Cavalheiro
* Instituição: FATEC Votorantim -SP
********************************************************/

* Ativa o sistema de gráficos estatísticos de alta qualidade;
ODS GRAPHICS ON;

/* Criação da Library "DataIESB" */

Libname DataIESB postgres
	server='bigdata.dataiesb.com'
	port=5432
	user=data_iesb
	password=iesb
	database=iesb
	schema=public
	access=readonly;
Run;

/*Conhecendo as caracteristicas das SAS TABLES */
PROC CONTENTS DATA=DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE varnum; 
RUN;

/* Distribuição de Frequencia com Gráficos*/

/* UF */
PROC FREQ DATA=DATAIESB.ED_ENEM_2024_PARTICIPANTES;
    TABLES NOME_UF_PROVA / PLOTS=(FREQPLOT CUMFREQPLOT);
	TITLE1 " Distribuição Frequência por UF ";
	FOOTNOTE1 "Fonte: Inep/MEC";
RUN;

/* FAIXA ETÁRIA */
PROC FREQ DATA=DATAIESB.ED_ENEM_2024_PARTICIPANTES;
    TABLES TP_FAIXA_ETARIA / PLOTS=(FREQPLOT CUMFREQPLOT);
	TITLE1 "Distribuição Frequência por Faixa Etária";
	FOOTNOTE1 "Fonte: Inep/MEC";
RUN;

/* SEXO */
PROC FREQ DATA=DATAIESB.ED_ENEM_2024_PARTICIPANTES;
    TABLES TP_SEXO / PLOTS=(FREQPLOT CUMFREQPLOT);
	TITLE1 "Distribuição Frequência por Sexo ";
	FOOTNOTE1 "Fonte: Inep/MEC";
RUN;

/* COR E RAÇA */
PROC FREQ DATA=DATAIESB.ED_ENEM_2024_PARTICIPANTES;
    TABLES TP_COR_RACA / PLOTS=(FREQPLOT CUMFREQPLOT);
	TITLE1 "Distribuição Frequência por Cor e Raça";
	FOOTNOTE1 "Fonte: Inep/MEC";
RUN;


/* 2- DISTRIBUIÇÃO FREQUÊNCIA CRUZADA */

/* UF E SEXO */
PROC FREQ DATA=DATAIESB.ED_ENEM_2024_PARTICIPANTES;
    TABLES NOME_UF_PROVA * TP_SEXO ;
	TITLE1 "Distribuição Frequência por UF e Sexo ";
	FOOTNOTE1 "Fonte: Inep/MEC";
RUN;

/* SEXO E COR E RAÇA */
PROC FREQ DATA=DATAIESB.ED_ENEM_2024_PARTICIPANTES;
    TABLES TP_SEXO * TP_COR_RACA;
	TITLE1 "Distribuição Frequência por Sexo e Cor/Raça ";
	FOOTNOTE1 "Fonte: Inep/MEC";
RUN;

/* FAIXA ETÁRIA E COR E RAÇA */
PROC FREQ DATA=DATAIESB.ED_ENEM_2024_PARTICIPANTES;
    TABLES TP_FAIXA_ETARIA * TP_COR_RACA;
	TITLE1 "Distribuição Frequência Faixa Etária e Cor/Raça";
	FOOTNOTE1 "Fonte: Inep/MEC";
RUN;