/*******************************************************
* PROGRAMA: 04
* AUTOR: Ana Elisa Rubinato Cavalheiro
* Instituição: FATEC Votorantim -SP
********************************************************/

/* Programa 04: Análise de Distribuição das Notas do ENEM */

Title "Análise de Distribuição das Notas do ENEM";

PROC UNIVARIATE DATA=DADOS_04.ENEM_2024_AMOSTRA_PERFEITA;
	VAR NOTA_MT_MATEMATICA NOTA_MEDIA_5_NOTAS;
Footnote "Fonte: INEP - 2024";
RUN;


/* Análise de Distribuição, Estatistica e Graficos das Notas do ENEM */
PROC UNIVARIATE DATA=DADOS_04.ENEM_2024_AMOSTRA_PERFEITA NORMAL;
	VAR NOTA_MT_MATEMATICA NOTA_MEDIA_5_NOTAS;
	HISTOGRAM / NORMAL KERNEL;
	INSET MEAN STD N MIN MAX / 
		HEADER = 'Estatísticas Principais' 
		POSITION = NE; /* Posição Nordeste (canto superior direito) */
Title2  "Explorar as variáveis Nota de Matemática e Media das 5 notas ";
Footnote "Fonte: INEP - 2024";
RUN;

