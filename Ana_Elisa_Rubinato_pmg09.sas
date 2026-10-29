/*******************************************************
* PROGRAMA: 09
* AUTOR: Ana Elisa Rubinato Cavalheiro
* Instituição: FATEC Votorantim -SP
********************************************************/

/* Crie a Library DataIesb usando estes parâmetros para conexão */
libname DataIesb postgres 
    server='bigdata.dataiesb.com'
    port=5432 
    user=data_iesb 
    password=iesb 
    database=iesb 
    schema=public;
Run;

/* Executando a Proc Contents para o arquivo Importado. */
proc contents data = DATAIESB.ED_ENEM_2024_RESULTADOS  varnum;
run;
proc contents data = DATAIESB.ED_ENEM_2024_PARTICIPANTES varnum;
run;

/* NOVO DATASET: ENEM_RESULTADOS_SP */
DATA DADOS_01.ENEM_RESULTADOS_SP ;
    SET DATAIESB.ED_ENEM_2024_RESULTADOS;
    WHERE SG_UF_PROVA = "SP";
RUN;

/* NOVO DATASET: ENEM_PARTICIPANTES_SP */
DATA DADOS_01.ENEM_PARTICIPANTES_SP;
    SET DATAIESB.ED_ENEM_2024_PARTICIPANTES;
    WHERE SG_UF_PROVA = "SP";
RUN;

/* ANÁLISE ESTATÍSTICA - MÉDIA DAS NOTAS */
TITLE "Distribuição da Nota Média das 5 Provas - SP";
PROC UNIVARIATE DATA=DADOS_01.ENEM_RESULTADOS_SP;
    VAR nota_media_5_notas;
    HISTOGRAM / NORMAL KERNEL;
    FOOTNOTE "Fonte: Inep/MEC";
RUN;
TITLE; 
FOOTNOTE;

/* ANÁLISE ESTATÍSTICA - NOTA DE CIÊNCIAS HUMANAS */
TITLE "Distribuição da Nota de Ciências Humanas - SP";
PROC UNIVARIATE DATA=DADOS_01.ENEM_RESULTADOS_SP;
    VAR nota_ch_ciencias_humanas;
    HISTOGRAM / NORMAL KERNEL;
    FOOTNOTE "Fonte: Inep/MEC";
RUN;
TITLE; 
FOOTNOTE;

