/*******************************************************
* PROGRAMA: 08
* AUTOR: Ana Elisa Rubinato Cavalheiro
* Instituição: FATEC Votorantim -SP
********************************************************/

/* ----------------------------------
   ANÁLISE ESTATÍSTICA - ENEM 2024
   ----------------------------------*/

Title "Análise ED_ENEM_2024_PARTICIPANTES";

/* UF */
PROC FREQ DATA=DATAIESB.ED_ENEM_2024_PARTICIPANTES;
    TABLES NOME_UF_PROVA / PLOTS=(FREQPLOT CUMFREQPLOT);
	TITLE1 "Distribuição Frequência por UF";
	FOOTNOTE1 "Fonte: Inep/MEC";
RUN;

/* FAIXA ETÁRIA */
PROC FREQ DATA=DATAIESB.ED_ENEM_2024_PARTICIPANTES;
    TABLES TP_FAIXA_ETARIA / PLOTS=(FREQPLOT CUMFREQPLOT);
	TITLE1 " Distribuição Frequência por Faixa Etária ";
	FOOTNOTE1 "Fonte: Inep/MEC";
RUN;

/* SEXO */
PROC FREQ DATA=DATAIESB.ED_ENEM_2024_PARTICIPANTES;
    TABLES TP_SEXO / PLOTS=(FREQPLOT CUMFREQPLOT);
	TITLE2 "Distribuição Frequência por Sexo ";
	FOOTNOTE1 "Fonte: Inep/MEC";
RUN;

/* COR E RAÇA */
PROC FREQ DATA=DATAIESB.ED_ENEM_2024_PARTICIPANTES;
   TABLES TP_COR_RACA / PLOTS=(FREQPLOT CUMFREQPLOT);
   TITLE1" Distribuição Frequência por Cor e Raça ";
	FOOTNOTE1 "Fonte: Inep/MEC";
RUN;