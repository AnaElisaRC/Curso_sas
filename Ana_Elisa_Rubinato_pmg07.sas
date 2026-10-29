/*******************************************************
* PROGRAMA: 06
* AUTOR: Ana Elisa Rubinato Cavalheiro
* Instituição: FATEC Votorantim -SP
********************************************************/

/* Crie a Library Dados_01 referenciando a pasta Dados. */
Libname Dados_01 " /workspaces/myfolder/Dados";
run;

/* Importe o arquivo “Enem_2024_Amostra_Perfeita.xlsx” usando a library Dados_01. */
proc import datafile= "/workspaces/myfolder/Dados/Enem_2024_Amostra_Perfeita.xlsx"
    out=Dados_01.ENEM_2024_AMOSTRA_PERFEITA
    dbms=xlsx
    replace;
    getnames=yes;
run;

/* Executando a Proc Contents para o arquivo Importado. */
Proc Contents data=DADOS_01.ENEM_2024_AMOSTRA_PERFEITA  varnum;
Run;

/* Crie a Library DataIesb usando estes parâmetros para conexão */
libname DataIesb postgres 
    server='bigdata.dataiesb.com'
    port=5432 
    user=data_iesb 
    password=iesb 
    database=iesb 
    schema=public;
Run;

/* Execute a Proc Contents para as seguintes tabelas do Banco de Dados */
Proc Contents data=DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE varnum;
Run;

Proc Contents data=DATAIESB.ED_ENEM_2024_RESULTADOS varnum;
Run;

Proc Contents data=DATAIESB.ED_ENEM_2024_RESULTADOS_AMOS_PER varnum;
Run;

Proc Contents data=DATAIESB.ED_ENEM_2024_PARTICIPANTES varnum;
Run;