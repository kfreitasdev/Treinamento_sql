--Cenário de Negócios: Armazenamento de Dados de Transações Financeiras
--Neste cenário, uma empresa precisa gerenciar um grande volume de transações financeiras. 
--O particionamento de tabelas pode ser utilizado para otimizar consultas e a manutenção da tabela, dividindo os dados com base em algum critério, como datas.

-- 1- Criação da Tabela Pai (Particionada)

CREATE TABLE transacoes (
    id_transacao SERIAL,
    id_cliente INT,
    valor DECIMAL(10,2),
    data_transacao DATE,
    PRIMARY KEY (id_transacao, data_transacao)
) PARTITION BY RANGE (data_transacao);

-- 2 - Criação das Tabelas Filhas (Partições)
-- Supondo que queremos criar partições para cada mês de um determinado ano:

CREATE TABLE transacoes_2024_01 PARTITION OF transacoes
FOR VALUES FROM ('2024-01-01') TO ('2024-02-01');

CREATE TABLE transacoes_2024_02 PARTITION OF transacoes
FOR VALUES FROM ('2024-02-01') TO ('2024-03-01');


INSERT INTO transacoes (id_cliente, valor, data_transacao) 
SELECT (i % 1000) + 1, ROUND((RANDOM() * 500)::numeric, 2), 
       '2024-02-01'::DATE + (i % 30)
FROM generate_series(1, 10000) AS i;

---------Explicação Operador %----------------


O operador % é conhecido como o operador de módulo ou resto da divisão. 
Ele é utilizado em várias linguagens de programação, incluindo SQL, para obter o resto de uma divisão inteira entre dois números. 
Vamos explorar o funcionamento e as aplicações do operador % em detalhes.

Sintaxe Básica

a % b

a: O dividendo (o número que será dividido).
b: O divisor (o número pelo qual a será dividido).


Exemplo Simples

SELECT 10 % 3; -- Retorna 1

2. Ciclos e Repetições
O operador % é frequentemente usado para criar ciclos ou padrões repetitivos. 
No nosso exemplo, (i % 1000) + 1 é usado para gerar valores cíclicos de id_cliente entre 1 e 1000.

SELECT (i % 1000) + 1 AS id_cliente
FROM generate_series(1, 10) AS i;



--------Usando uma Procedure com Loop para Criar Partições-------------	

-- 1º Passo - Definir a Procedure

CREATE OR REPLACE PROCEDURE criar_particoes_transacoes(ano INT)
LANGUAGE plpgsql
AS $$
DECLARE
    mes_inicio DATE;
    mes_fim DATE;
BEGIN
    FOR mes IN 1..12 LOOP
        -- Define as datas de início e fim do mês
        mes_inicio := (ano || '-' || LPAD(mes::text, 2, '0') || '-01')::DATE;
        mes_fim := (mes_inicio + INTERVAL '1 MONTH')::DATE;

        -- Executa a criação da partição para o mês
        EXECUTE FORMAT('CREATE TABLE IF NOT EXISTS transacoes_%s_%s PARTITION OF transacoes FOR VALUES FROM (%L) TO (%L)', ano, LPAD(mes::text, 2, '0'), mes_inicio, mes_fim);
    END LOOP;
END;
$$;

-------Explicação função LPAD--------------------

O que é LPAD?
LPAD é uma função de manipulação de strings em PostgreSQL que "preenche" uma string à esquerda com um caractere especificado até que a string atinja um comprimento desejado. 
O nome LPAD vem de "Left PAD", ou seja, preenchimento à esquerda.

Sintaxe

LPAD(string, length, fill)


string: A string original que você deseja preencher.
length: O comprimento total desejado da string após o preenchimento.
fill: O caractere ou a string que será usada para preencher à esquerda.

1. Preenchimento com Zeros
Um uso comum de LPAD é preencher números com zeros à esquerda para garantir que todos tenham o mesmo comprimento.

SELECT LPAD('5', 3, '0'); -- Retorna '005'

string: '5'
length: 3
fill: '0'
Resultado: '005'

2. Preenchimento com Espaços
Você também pode usar LPAD para preencher uma string com espaços à esquerda.

SELECT LPAD('abc', 6, ' '); -- Retorna '   abc'

string: 'abc'
length: 6
fill: ' '
Resultado: ' abc'

1. Formatação de Datas
Quando você precisa garantir que os componentes de uma data (dia, mês) tenham sempre dois dígitos.

SELECT LPAD(EXTRACT(MONTH FROM CURRENT_DATE)::text, 2, '0'); -- Retorna o mês atual com dois dígitos

2. Formatação de Códigos
Para garantir que códigos ou identificadores tenham um comprimento fixo.

SELECT LPAD('123', 5, '0'); -- Retorna '00123'

-- 2º Executar a Procedure indicando o ano desejado

CALL criar_particoes_transacoes(2024);
