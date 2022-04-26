/* CAPITULO 3 - Categorização, Codificação, Binarização de variáveis com SQL

Tipos de dados
	Tipos de dados armazenados no PC
		Numéricos - Operações matemáticas fazem sentido. (calcular media)
		Categóricos - representa classes ou categorias.

	Fonte dos dados
		Primários
		Secundários

	Linguagem de programação
		Primitivos
		Não Primitivos

	Estruturados
	Não Estruturados
	Semi estruturados

O que é categorização - É converter uma variável para o tipo categórico a fim de obter um novo tipo de informação.
O que é codificação (encoding) - É transformar uma variável para uma representação numérica, sem perder a essência da informação.
	Para realizar atividades matemáticas q não consigo pq estão em texto.
	Ex.: fusca - branco - 1
		passat - branco - 1

	Label Encoding - normalmente usamos quando a variável categórica tem até 5 categorias.
	One-hot-encoding - Usado para criar variáveis dummy (representações numéricas para cada categoria de uma variável categórica) e normalmente usamos quando a variável categórica tem mais de 5 categorias.
	se é branco eu coloco 1 senão eu coloco 0 - variável (cor_label_branco)
	se é vermelhor eu coloco 1 senão eu coloco 0 - variável (cor_label_vermelho)
	Somente modificam a forma que eu estou mostrando a categoria. Posso fazer em python tb.

O que é binarização - é converter uma variável para sua representação binária sem perder a essência da informação.
	desenvolveu diabtes - 1. não 0.
	Representar a variável de uma forma diferente. Para aplicar modelos de machine learning, por exemplo.

	>>> SQL Para Data Science 
	Definindo o Problema
	Usando SQL Para Limpeza e Transformação de Dados de Câncer de Mama 

	Neste capítulo aplicaremos uma série de transformações a variáveis de um conjunto de dados de pacientes que desenvolveram câncer de mama.
	O  objetivo é  limpar  e  transformar  os  dados  através  de  categorização,  codificação  e binarização  e  então  gerar  um  novo  dataset que  poderá  ser  usado  mais  a  
	frente  por  outros profissionais da equipe de Ciência de Dados.
	
Continua no My SQl

Criando a tabela

CREATE TABLE `cap03`.`TB_DADOS` (
  `classe` VARCHAR(100) NULL,
  `idade` VARCHAR(45) NULL,
  `menopausa` VARCHAR(45) NULL,
  `tamanho_tumor` VARCHAR(45) NULL,
  `inv_nodes` VARCHAR(45) NULL,
  `node_caps` VARCHAR(3) NULL,
  `deg_malig` INT NULL,
  `seio` VARCHAR(5) NULL,
  `quadrante` VARCHAR(10) NULL,
  `irradiando` VARCHAR(3) NULL);

Carreguei a tabela com os dados CSV

https://www.w3schools.com/sql/sql_case.asp

SELECT * FROM cap03.tb_dados;
/* https://www.w3schools.com/sql/sql_case.asp
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;

DEPARA
Caso, quando a condiçao1 for verdadeira então o resultado1
ao final posso colocar o ELSE
e finalizo com o END;

aplico o case para cada coluna.

Exemplo 1 */

SELECT COUNT(*) FROM cap03.tb_dados

# Binarização da variável classe
SELECT DISTINCT classe FROM cap03.tb_dados

SELECT
	CASE
		WHEN classe = 'no-recurrense-events' THEN 0
		WHEN classe = 'recurrence-events' THEN 1
	END as class
FROM cap03.tb_dados;

# Binarização da variável irradiando

SELECT DISTINCT irradiando FROM cap03.tb_dados

SELECT
	CASE
		WHEN irradiando = 'no' THEN 0
		WHEN irradiando = 'yes' THEN 1
	END as irradiando
FROM cap03.tb_dados;

# Binarizaçao da variavel node_caps - tem valores nulos

SELECT DISTINCT node_caps FROM cap03.tb_dados

SELECT
	CASE
		WHEN node_caps = 'no' THEN 0
		WHEN node_caps = 'yes' THEN 1
	END as node_caps
FROM cap03.tb_dados;

SELECT * FROM cap03.tb_dados;
/* https://www.w3schools.com/sql/sql_case.asp
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;

DEPARA
Caso, quando a condiçao1 for verdadeira então o resultado1
ao final posso colocar o ELSE
e finalizo com o END;

aplico o case para cada coluna.

Exemplo 1 */

SELECT COUNT(*) FROM cap03.tb_dados

# Binarização da variável classe
SELECT DISTINCT classe FROM cap03.tb_dados

SELECT
	CASE
		WHEN classe = 'no-recurrense-events' THEN 0
		WHEN classe = 'recurrence-events' THEN 1
	END as class
FROM cap03.tb_dados;

# Binarização da variável irradiando

SELECT DISTINCT irradiando FROM cap03.tb_dados

SELECT
	CASE
		WHEN irradiando = 'no' THEN 0
		WHEN irradiando = 'yes' THEN 1
	END as irradiando
FROM cap03.tb_dados;

# Binarizaçao da variavel node_caps - tem valores nulos

SELECT DISTINCT node_caps FROM cap03.tb_dados

SELECT
	CASE
		WHEN node_caps = 'no' THEN 0
		WHEN node_caps = 'yes' THEN 1
	END as node_caps
FROM cap03.tb_dados;

# Verificando e tratando valores ausentes

# Para ajustar a variavel node_caps iremos agora codificar a variavel e nao mais binarizar - poderia remover ou mudar a tecnica
SELECT
	CASE
		WHEN node_caps = 'no' THEN 0
		WHEN node_caps = 'yes' THEN 1
        ELSE 2
	END as node_caps
FROM cap03.tb_dados;


# Categorizacao da variavel seio (E/D)

# 1) Checar os valores distintos:

SELECT DISTINCT seio FROM cap03.tb_dados

# Aplicando a categorizaçao - continua sendo categorica, mas estou representando com novas categorias. Pode ser pq quero levar pra um grafico...

SELECT
	CASE
		WHEN seio = 'left' THEN 'E'
		WHEN seio = 'right' THEN 'D'
	END as seio
FROM cap03.tb_dados;

# Categorizacao da variavel tamanho_tumor (6 categorias)

SELECT DISTINCT tamanho_tumor FROM cap03.tb_dados
order by tamanho_tumor

# Fiz assim
SELECT
	CASE
		WHEN tamanho_tumor = '0-4' AND '5-9' THEN '1'
		WHEN tamanho_tumor = '10-14' AND '15-19' THEN '2'
        WHEN tamanho_tumor = '20-24' AND '25-29' THEN '3'
        WHEN tamanho_tumor = '30-34' AND '35-39' THEN '4'
        WHEN tamanho_tumor = '40-44' AND '45-49' THEN '5'
        WHEN tamanho_tumor = '50-54' THEN '6'
	END as tamanho_tumor
FROM cap03.tb_dados;

# correcao

SELECT DISTINCT tamanho_tumor FROM cap03.tb_dados
ORDER BY tamanho_tumor

SELECT
	CASE
		WHEN tamanho_tumor = '0-4' OR tamanho_tumor '5-9' THEN 'Muito Pequeno'
        WHEN tamanho_tumor = '10-14' OR tamanho_tumor '15-19' THEN 'Pequeno'
        WHEN tamanho_tumor = '20-24' OR tamanho_tumor '25-29' THEN 'Medio'
        WHEN tamanho_tumor = '30-34' OR tamanho_tumor '35-39' THEN 'Grande'
        WHEN tamanho_tumor = '40-44' OR tamanho_tumor '45-49' THEN 'Muito Grande'
		WHEN tamanho_tumor = '50-54' OR tamanho_tumor '55-59' THEN 'Tratamento Urgente'     
	END as tamanho_tumor
FROM cap03.tb_dados;

SELECT 
	CASE 
		WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN 'Muito Pequeno'
        WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN 'Pequeno'
        WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN 'Medio'
        WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN 'Grande'
        WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN 'Muito Grande'
        WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN 'Tratamento Urgente'
	END as tamanho_tumor

# Label enconding da variavel quadrante (1,2,3,4,5)
	# O valor ausente aparece como 0

SELECT DISTINCT quadrante FROM cap03.tb_dados
ORDER BY quadrante

SELECT 
	CASE 
		WHEN quadrante = 'left_low' THEN 1 
        WHEN quadrante = 'right_up' THEN 2 
        WHEN quadrante = 'left_up' THEN 3
        WHEN quadrante = 'right_low' THEN 4
        WHEN quadrante = 'central' THEN 5
        ELSE 0
	END as quadrante
FROM cap03.TB_DADOS;

# Query com todas as transformações

SELECT 
	CASE 
		WHEN classe = 'no-recurrence-events' THEN 0 
        WHEN classe = 'recurrence-events' THEN 1
	END as classe,
	idade,
	menopausa,
	CASE 
		WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN 'Muito Pequeno'
        WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN 'Pequeno'
        WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN 'Medio'
        WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN 'Grande'
        WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN 'Muito Grande'
        WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN 'Tratamento Urgente'
	END as tamanho_tumor,
	inv_nodes,
	CASE 
		WHEN node_caps = 'no' THEN 0 
        WHEN node_caps = 'yes' THEN 1
        ELSE 2
	END as node_caps,
	deg_malig,
	CASE 
		WHEN seio = 'left' THEN 'E' 
        WHEN seio = 'right' THEN 'D'
	END as seio,
	CASE 
		WHEN quadrante = 'left_low' THEN 1 
        WHEN quadrante = 'right_up' THEN 2 
        WHEN quadrante = 'left_up' THEN 3
        WHEN quadrante = 'right_low' THEN 4
        WHEN quadrante = 'central' THEN 5
        ELSE 0
	END as quadrante,
	CASE 
		WHEN irradiando = 'no' THEN 0 
        WHEN irradiando = 'yes' THEN 1
	END as irradiando
FROM cap03.TB_DADOS;

# Cria uma nova tabela
CREATE TABLE cap03.TB_DADOS2
AS
SELECT 
	CASE 
		WHEN classe = 'no-recurrence-events' THEN 0 
        WHEN classe = 'recurrence-events' THEN 1
	END as classe,
	idade,
	menopausa,
	CASE 
		WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN 'Muito Pequeno'
        WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN 'Pequeno'
        WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN 'Medio'
        WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN 'Grande'
        WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN 'Muito Grande'
        WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN 'Tratamento Urgente'
	END as tamanho_tumor,
	inv_nodes,
	CASE 
		WHEN node_caps = 'no' THEN 0 
        WHEN node_caps = 'yes' THEN 1
        ELSE 2
	END as node_caps,
	deg_malig,
	CASE 
		WHEN seio = 'left' THEN 'E' 
        WHEN seio = 'right' THEN 'D'
	END as seio,
	CASE 
		WHEN quadrante = 'left_low' THEN 1 
        WHEN quadrante = 'right_up' THEN 2 
        WHEN quadrante = 'left_up' THEN 3
        WHEN quadrante = 'right_low' THEN 4
        WHEN quadrante = 'central' THEN 5
        ELSE 0
	END as quadrante,
	CASE 
		WHEN irradiando = 'no' THEN 0 
        WHEN irradiando = 'yes' THEN 1
	END as irradiando
FROM cap03.TB_DADOS;

# Conferindo se n perdemos dados

SELECT COUNT(*) cap03.tb_dados2;
SELECT COUNT(*) cap03.tb_dados;

# Exercicios

# 1-Aplique label encoding à variável menopausa.

SELECT DISTINCT menopausa FROM cap03.tb_dados2

CREATE TABLE cap03.TB_DADOS3
AS
SELECT
classe,
idade,
CASE
	WHEN menopausa = 'premeno' THEN 1
	WHEN menopausa = 'ge40' THEN 2
	WHEN menopausa = 'lt40' THEN 3
END as menopausa,
tamanho_tumor,
inv_nodes,
node_caps,
deg_malig,
seio,
quadrante,
irradiando
FROM cap03.TB_DADOS2;


# 2 [Desafio] Crie uma nova coluna chamada posicao_tumor concatenando as colunas inv_nodes e quadrante. (eng. de atributos)

CREATE TABLE cap03.TB_DADOS4
AS
SELECT
classe,
idade,
menopausa,
tamanho_tumor,
CONCAT(inv_nodes, '-', quadrante) AS posicao_tumor,
node_caps,
deg_malig,
seio,
irradiando
FROM cap03.TB_DADOS3;

# Outra forma

CREATE TABLE cap03.TB_DADOS4
AS
SELECT
classe,
idade,
menopausa,
tamanho_tumor,
CONCAT(inv_nodes, '-', quadrante) AS posicao_tumor,
node_caps,
deg_malig,
seio,
irradiando
FROM cap03.TB_DADOS3;


# [Desafio] Aplique One-Hot-Encoding à coluna deg_malig

SELECT DISTINCT deg_malig FROM cap03.tb_dados4

SELECT DISTINCT deg_malig FROM cap03.tb_dados4


CREATE TABLE cap03.TB_DADOS5
AS
SELECT
classe,
idade,
menopausa,
tamanho_tumor,
posicao_tumor,
node_caps,
CASE WHEN deg_malig = 1 THEN 1 ELSE 0 END AS deg_malig_1,
CASE WHEN deg_malig = 2 THEN 1 ELSE 0 END AS deg_malig_2,
CASE WHEN deg_malig = 3 THEN 1 ELSE 0 END AS deg_malig_3,
seio,
irradiando
FROM cap03.TB_DADOS4;

# Crie um novo datasetcom todas as variáveis após as transformações anteriores.

# Capítulo 4
	# Junção de tabelas
		# Tabelas com catergorias repetidas ocupam espaço desnecessariamente. O que fazer?
        # Normalização de dados
			# Criar uma tabela auxiliar. Com id.
            # Relacionar a tabela - crio na primeira tabela um id_categoria
            # Não há mais a repetição da palavra. Tempo de carga será menor. 
            
	# Tipos de Junções
		# As junções em SQL representam a teoria dos conjuntos.
        # INNER JOIN: Retorna registros que possuem valores correspondentes em ambas as tabelas.
        # LEFT OUTER JOIN: Retorna todos os registros da tabela da esquerda e os registros correspondentes da tabela da direita.
        # RIGHT OUTER JOIN: Retorna todos os registros da tabela da direita e os registros correpondentes da tabela da esquerda.
        # FULL OUTER JOIN: Retorna todos os registros quando há uma correspondência na tabela da esquerda ou da direita.
        # CROSS JOIN: Retorna a associação de todos os registros de ambas as tabelas.
        # SELF JOIN: Recurssividade. Retorna os registros da associação de uma tabela com ela mesma.
        



        
    


