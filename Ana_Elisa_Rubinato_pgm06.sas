/*******************************************************
* PROGRAMA: 06
* AUTOR: Ana Elisa Rubinato Cavalheiro
* Instituição: FATEC Votorantim -SP
********************************************************/

/* ==================================================================== */
/* ETAPA 1: CRIAÇÃO DO DATASET FILTRADO                                 */
/* ==================================================================== */
data dados_04.enem_2024_filtrado;
    set DADOS_04.ENEM_2024_AMOSTRA_PERFEITA;
    where SG_UF_PROVA = "SP" and NOTA_CH_CIENCIAS_HUMANAS > 600;

    /* Formatar notas */
    format
        nota_mt_matematica             8.0
        NOTA_CN_CIENCIAS_DA_NATUREZA   8.0
        nota_ch_ciencias_humanas       8.0
        NOTA_LC_LINGUAGENS_E_CODIGOS   8.0
        nota_redacao                   8.0
        nota_media_5_notas             8.1;

    /* Calcular Nota_Media_Exatas */
    Nota_Media_Exatas = (nota_mt_matematica + nota_cn_ciencias_da_natureza)/2;

    /* Selecionar apenas as variáveis relevantes */
    keep
        sg_uf_prova
        NOTA_LC_LINGUAGENS_E_CODIGOS
        nota_mt_matematica
        NOTA_CN_CIENCIAS_DA_NATUREZA
        nota_ch_ciencias_humanas
        nota_redacao
        nota_media_5_notas
        Nota_Media_Exatas;
       /*  tp_sexo - Não tem essa variável no Data Set */
       /*  tp_cor_raca - Não tem essa variável no Data Set */
run;

/* Mostra as 20 primeiras linhas do seu dataset */
proc print data=dados_04.enem_2024_filtrado (obs=20);
    title "Visualizando as 20 Primeiras Linhas de enem_2024_filtrado";
run;
title; 

/* ==================================================================== */
/* ETAPA 2: ANÁLISE DE FREQUÊNCIA                                       */
/* ==================================================================== */
/* Como não tem Sexo e Cor_raca no dataset resolvi fazer de duas notas*/

proc format;
    /* Formato para a nota de Ciências Humanas */
    value fmt_humanas
        600 <- 700 = '601 a 700'
        700 <- 800 = '701 a 800'
        800 <- high = 'Acima de 800';

    /* Formato para a média de Exatas */
    value fmt_exatas
        low - 500  = 'Abaixo de 500'
        500 <- 600 = '501 a 600'
        600 <- 700 = '601 a 700'
        700 <- 800 = '701 a 800'
        800 <- high = 'Acima de 800';
run;

/* Gera as tabelas de frequência (simples e cruzada) */
title "Análise de Frequência das Notas";

proc freq data=dados_04.enem_2024_filtrado;
    format
        nota_ch_ciencias_humanas    fmt_humanas.
        Nota_Media_Exatas           fmt_exatas.;

    tables nota_ch_ciencias_humanas Nota_Media_Exatas nota_ch_ciencias_humanas*Nota_Media_Exatas;
run;
title; 

/* ==================================================================== */
/* ETAPA 3: HISTOGRAMAS DAS NOTAS                                       */
/* ==================================================================== */

title "Histograma - nota_media_5_notas";
proc univariate data=dados_04.enem_2024_filtrado;
    var nota_media_5_notas;
    histogram / normal kernel;
run;

title "Histograma - Nota_Media_Exatas";
proc univariate data=dados_04.enem_2024_filtrado;
    var Nota_Media_Exatas;
    histogram / normal kernel;
run;

title "Histograma - nota_ch_ciencias_humanas";
proc univariate data=dados_04.enem_2024_filtrado;
    var nota_ch_ciencias_humanas;
    histogram / normal kernel;
run;

title; 