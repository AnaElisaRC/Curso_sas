/*******************************************************
* PROGRAMA: 01
* AUTOR: Ana Elisa Rubinato Cavalheiro
* Instituição: FATEC Votorantim -SP
********************************************************/

/* 1. Criação da library */
libname Dados_04 '/export/viya/homes/ana.cavalheiro2@fatec.sp.gov.br/SAS Programa Júnior/Dados_04';

/* 2. Importação do arquivo XLSX */
proc import datafile="/export/viya/homes/ana.cavalheiro2@fatec.sp.gov.br/SAS Programa Júnior/Dados_04/Enem_2024_Amostra_Perfeita.xlsx"
    out=Dados_04.Enem_2024_Amostra_Perfeita
    dbms=xlsx
    replace;
    getnames=yes;
run;

/* 3. Especificação do arquivo CSV */
filename arqcsv "/export/viya/homes/ana.cavalheiro2@fatec.sp.gov.br/SAS Programa Júnior/Dados_04/SUS_PROD_AMB_2024_2025.csv"
        encoding="windows-1252";

/* 4. Importação do arquivo CSV */
proc import datafile=arqcsv
    out=Dados_04.SUS_PROD_AMB_2024_2025
    dbms=csv
    replace;
    delimiter=";";
    guessingrows=max;
run;

/* 5. Verifica os rótulos aplicados na tabela do XLSX */
proc contents data=Dados_04.Enem_2024_Amostra_Perfeita;
run;

/* 6. Verifica os rótulos aplicados na tabela do CSV */
proc contents data=Dados_04.SUS_PROD_AMB_2024_2025 varnum;
run;


/* 7. Descrição (labels) nas variáveis */
Data Dados_04.SUS_PROD_AMB_2024_2025;
	Set Dados_04.SUS_PROD_AMB_2024_2025;
	Label
	Ano_Producao_Ambulatorial='Ano do Atendimento Ambulatorial'
	Mes_Producao_Ambulatorial='Mês do Atendimento Ambulatorial'
	Municipio_Codigo_com_dv='Código do Municipio com DV'
	Municipio_Codigo='Código do Municipio'
	Municipio_nome='Nome do Município'
	UF_Codigo='Código da Unidade da Federação'
	UF_Sigla='Sigla da Unidade da Federação'
	UF_Nome='Nome da Unidade da Federação'
	Municipio_Capital='Município é a Capital da Unidade da Federação?'
	Regiao_Codigo='Código da Região'
	Regiao_Nome='Nome da Região'
	QTD_01='01 Quantidade de Ações de promoção e prevenção em saúde'
	QTD_02='02 Quantidade de Procedimentos com finalidade diagnóstica'
	QTD_03='03 Quantidade de Procedimentos clínicos'
	QTD_04='04 Quantidade de Procedimentos cirúrgicos'
	QTD_05='05 Quantidade de Transplantes de órgaos, tecidos e celulas'
	QTD_06='06 Quantidade de Medicamentos'
	QTD_07='07 Quantidade de Órteses, próteses e materiais especiais'
	QTD_08='08 Quantidade de Ações complementares da atenção a saúde'
	QTD_09='09 Quantidade de Procedimentos para ofertas de cuidados integrados'
	QTD_Total='10 Quantidade Total de Procedimentos'
	VL_01='01 Valor das Ações de promoção e prevenção em saúde(R$)'
	VL_02='02 Valor dos Procedimentos com finalidade diagnóstica(R$)'
	VL_03='03 Valor dos Procedimentos clínicos(R$)'
	VL_04='04 Valor dos Procedimentos cirúrgicos(R$)'
	VL_05='05 Valor dos Transplantes de órgaos, tecidos e celulas(R$)'
	VL_06='06 Valor dos Medicamentos(R$)'
	VL_07='07 Valor das Órteses, próteses e materiais especiais(R$)'
	VL_08='08 Valor das Ações complementares da atenção a saúde(R$)'
	VL_09='09 Valor dos Procedimentos para ofertas de cuidados integrados(R$)'
	VL_Total='10 Valor Total de Procedimentos(R$)'
	LATITUDE='Latitude'
	LONGITUDE='Longitude';
Run;

/* 8. Verifica os rótulos aplicados na tabela do CSV */
PROC CONTENTS DATA=Dados_04.SUS_PROD_AMB_2024_2025;
RUN;
