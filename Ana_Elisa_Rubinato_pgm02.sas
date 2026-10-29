/*******************************************************
* PROGRAMA: 02
* AUTOR: Ana Elisa Rubinato Cavalheiro
* Instituição: FATEC Votorantim -SP
********************************************************/

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

/* Enem*/

TITLE1  " Exame Nacional do Ensino Médio 2024";
FOOTNOTE1 "Criado por INEP / 2024 ";
PROC CONTENTS DATA=Dados_04.Enem_2024_Amostra_Perfeita;
RUN;

/* SUS*/
TITLE1  "Sistema Único de Saúde ";
FOOTNOTE1 "Sistema de Informações Ambulatoriais do SUS (SIA/SUS) ";
PROC CONTENTS DATA=Dados_04.SUS_PROD_AMB_2024_2025;
RUN;

/*Censo*/
TITLE1  "Censo Demográfico ";
FOOTNOTE1 "Gerado: IBGE (Instituto Brasileiro de Geografia e Estatística) ";
PROC CONTENTS DATA= DataIESB.censo_2022_municipio_sexo_idade;
RUN;

/*Enem Participantes */
TITLE1  "Exame Nacional do Ensino Médio 2024 Participantes ";
FOOTNOTE1 "Criado por INEP / 2024  ";
PROC CONTENTS DATA= DataIESB.ed_enem_2024_participantes;
RUN;

/*Enem Resultados */
TITLE1  "Exame Nacional do Ensino Médio 2024 Resultados ";
FOOTNOTE1 "Criado por INEP / 2024  ";
PROC CONTENTS DATA= DataIESB.ed_enem_2024_resultados;
RUN;

/* Municipio */
TITLE1  "Municipios do Brasil ";
FOOTNOTE1 "Gerado: IBGE ";
PROC CONTENTS DATA= DataIESB.municipio;
RUN;

/*Eatado*/
TITLE1  "Unidade de Federação 'Estado' ";
FOOTNOTE1 "Gerado: IBGE ";
PROC CONTENTS DATA= DataIESB.unidade_federacao;
RUN;

/* Região */
TITLE1  " Regiões ";
FOOTNOTE1 "Gerado: IBGE ";
PROC CONTENTS DATA= DataIESB.regiao; 
RUN;

/* Educação Básica */
TITLE1  " Educação Básica ";
FOOTNOTE1 "Gerado: IBGE ";
PROC CONTENTS DATA= DataIESB.educacao_basica;
RUN;

