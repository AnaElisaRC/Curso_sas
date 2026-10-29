/*******************************************************
* PROGRAMA: 10 - VERSÃO CORRIGIDA
* AUTOR: Ana Elisa Rubinato Cavalheiro
* Instituição: FATEC Votorantim -SP
********************************************************/

/* CONFIGURAÇÃO INICIAL (A PARTE MAIS IMPORTANTE) */
%let outpath = '/workspaces/myfolder/Projeto Final/Resultados';

/*  ENTRADA de dados */
libname Dados_01 '/workspaces/myfolder/Dados';
run;

/* Conexão com o banco de dados externo */
libname DataIESB postgres
    server='bigdata.dataiesb.com'
    port=5432
    user=data_iesb
    password=iesb
    database=iesb
    schema=public
    access=readonly;
run;

/* EXPORTAÇÃO DAS ANÁLISES */

TITLE "Análise da Nota Média das 5 Provas - ENEM 2024 (SP)";
FOOTNOTE "Fonte: Inep/MEC";

/* a) Exportando a análise para PDF */
ODS PDF FILE="&outpath./Analise_Enem_SP.pdf";
PROC UNIVARIATE DATA=DADOS_01.ENEM_RESULTADOS_SP;
    VAR nota_media_5_notas;
    HISTOGRAM / NORMAL KERNEL;
RUN;
ODS PDF CLOSE;

/* Exportando a análise para POWER POINT */
ODS POWERPOINT FILE="&outpath./Apresentacao_Enem_SP.pptx";
PROC UNIVARIATE DATA=DADOS_01.ENEM_RESULTADOS_SP;
    VAR nota_media_5_notas;
    HISTOGRAM / NORMAL KERNEL;
RUN;
ODS POWERPOINT CLOSE;

/* Exportando a análise para WORD (via RTF) */
ODS RTF FILE="&outpath./Relatorio_Enem_SP.rtf";
PROC UNIVARIATE DATA=DADOS_01.ENEM_RESULTADOS_SP;
    VAR nota_media_5_notas;
    HISTOGRAM / NORMAL KERNEL;
RUN;
ODS RTF CLOSE;

/* Exportando 100 observações para EXCEL (usando PROC EXPORT) */
PROC EXPORT DATA=DADOS_01.ENEM_RESULTADOS_SP(OBS=100)
    OUTFILE="&outpath./Amostra_Enem_SP_100.xlsx"
    DBMS=XLSX
    REPLACE;
    SHEET="Resultados SP";
RUN;

/* Exportando 100 observações para CSV (usando PROC PRINT) */
ODS CSV FILE="&outpath./Amostra_Enem_SP_100.csv";
PROC PRINT DATA=DADOS_01.ENEM_RESULTADOS_SP(OBS=100) NOOBS;
RUN;
ODS CSV CLOSE;

