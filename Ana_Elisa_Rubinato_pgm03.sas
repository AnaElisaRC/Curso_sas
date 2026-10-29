/*******************************************************
* PROGRAMA: 03
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
PROC CONTENTS DATA=DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE varnum; 
RUN;

/*==============================================================================*/
/* CÁLCULOS POPULACIONAIS */
/*==============================================================================*/

TITLE1 "Análise Populacional - Censo 2022";

/*  População Total do Brasil */
TITLE2 "População Total do Brasil";
Footnote "Fonte: IBGE";
PROC MEANS DATA=DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE SUM;
   VAR TOTAL;
RUN;

/* População por Região */
TITLE2 "População por Região";
Footnote "Fonte: IBGE";
PROC MEANS DATA=DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE SUM;
   CLASS nome_regiao;
   VAR TOTAL;
RUN;

/* População por Unidade da Federação */
TITLE2 "População por Unidade da Federação";
Footnote "Fonte: IBGE";
PROC MEANS DATA=DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE SUM;
   CLASS nome_uf;
   VAR Total;
RUN;


/* População por Sexo */
TITLE2 "População por Sexo";
Footnote "Fonte: IBGE";
PROC MEANS DATA=DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE SUM;
   CLASS Sexo;
   VAR TOTAL;
RUN;

/*  População por Idade */
TITLE2 "População por Idade";
Footnote "Fonte: IBGE";
PROC MEANS DATA=DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE SUM;
   CLASS Idade;
   VAR TOTAL;
RUN;


/*==============================================================================*/
/*  CRUZAMENTOS MÚLTIPLOS DE DADOS */
/*==============================================================================*/

TITLE1 "Análise Populacional - Censo 2022";

/* População por Unidade da Federação * Sexo */
TITLE2 "População por UF e Sexo";
Footnote "Fonte: IBGE";
PROC MEANS DATA=DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE SUM;
   CLASS nome_uf Sexo;
   VAR TOTAL;
RUN;

/*  População por Unidade da Federação * Sexo * Idade */
TITLE2 "População por UF, Sexo e Idade";
Footnote "Fonte: IBGE";
PROC MEANS DATA=DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE SUM;
   CLASS nome_uf Sexo Idade;
   VAR TOTAL;
RUN;

/*==============================================================================*/
/*  GRÁFICOS 01  */
/*==============================================================================*/

/* Somar a população por UF */
proc sql;
  create table pop_uf as
  select nome_uf, sum(TOTAL) as pop_total
  from DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE
  group by nome_uf;
quit;

/* Gráfico de barras da população por UF */
proc sgplot data=pop_uf;
  vbar nome_uf / response=pop_total datalabel;
  title2 "População Total por Unidade da Federação (Brasil - 2022)";
  Footnote "Fonte: IBGE" ;
  yaxis label="População Total";
  xaxis label="Unidade da Federação";
run;

/*==============================================================================*/
/*  GRÁFICOS 02  */
/*==============================================================================*/
title2 "Mapa do Brasil por Município ";
footnote "Fonte: IBGE";

ods graphics / reset width=6.4in height=4.8in;

proc sgmap plotdata=DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE;
	openstreetmap;
	bubble x=longitude y=latitude size=TOTAL/ group=nome_municipio 
		name="bubblePlot";
	keylegend "bubblePlot" / title='nome_municipio';
run;

ods graphics / reset;

/*==============================================================================*/
/*  GRÁFICOS 02- Melhoria como tem muitos municipios a selecão dos 50 municípios mais populosos */
/*==============================================================================*/

proc sql;
  create table top_municipios as
  select nome_municipio, latitude, longitude, sum(TOTAL) as pop_total
  from DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE
  group by nome_municipio, latitude, longitude
  order by calculated pop_total desc;
quit;

data top_50;
  set top_municipios (obs=50); /* seleciona só os 50 primeiros */
run;

proc sgmap plotdata=top_50;
  openstreetmap;
  bubble x=longitude y=latitude size=pop_total / 
         fillattrs=(color=blue)
         transparency=0.4
         name="pop_bubble"
         datalabel=nome_municipio;
  title2 "Mapa: População dos 50 Municípios mais Populosos ";
  footnote "Fonte: IBGE";
run;
title;

/*==============================================================================*/
/*  Sugestão de 3 relatórios  */
/*================================================================*/

/*Relatório: Top 10 Municípios mais Populosos do Brasil*/

proc sql;
  create table relatorio2 as
  select 
    nome_municipio, 
    nome_uf, 
    sum(TOTAL) as pop_total
  from DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE
  group by nome_municipio, nome_uf
  order by calculated pop_total desc;
quit;

proc print data=relatorio2 (obs=10) label;
  title "Top 10 Municípios Mais Populosos do Brasil";
  footnote "Fonte: IBGE";
  label nome_municipio = "Município"
        nome_uf = "UF"
        pop_total = "População Total";
run;
title;

/*Municípios com população inferior a 10 mil habitantes*/
proc sql;
  create table relatorio8 as
  select nome_municipio, nome_uf, sum(TOTAL) as pop_total
  from DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE
  group by nome_municipio, nome_uf
  having calculated pop_total < 10000
  order by pop_total;
quit;

proc print data=relatorio8 label;
  title "Municípios com População Inferior a 10 mil Habitantes";
  footnote "Fonte: IBGE";
  label nome_municipio = "Município"
        nome_uf = "UF"
        pop_total = "População Total";
run;

/*População média por município em cada UF*/
proc sql;
  create table relatorio6 as
  select nome_uf,
         count(distinct nome_municipio) as qtde_municipios,
         sum(TOTAL) as pop_total,
         calculated pop_total / calculated qtde_municipios as media_populacional format=comma10.0
  from DATAIESB.CENSO_2022_MUNICIPIO_SEXO_IDADE
  group by nome_uf
  order by media_populacional desc;
quit;

proc print data=relatorio6 label;
  title "População Média por Município em Cada UF";
  footnote "Fonte: IBGE";
  label nome_uf = "UF"
        qtde_municipios = "Nº de Municípios"
        pop_total = "População Total"
        media_populacional = "População Média por Município";
run;
