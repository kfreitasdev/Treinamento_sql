-- Início do bloco DO, que permite a execução de procedimentos anônimos no PostgreSQL.
DO $$ 

-- Declaração de variáveis que serão usadas dentro do bloco.
DECLARE 
    -- Definindo a data inicial do intervalo que queremos popular na dimensão de tempo.
    data_atual DATE := '2005-01-01';
    -- Definindo a data final do intervalo.
    data_final DATE := '2017-12-31';

-- Início do bloco de comandos.
BEGIN
    -- Início do loop WHILE. Este loop irá iterar enquanto a data_atual for menor ou igual à data_final.
    WHILE data_atual <= data_final LOOP
    
        -- Inserindo um novo registro na tabela dw.dim_tempo.
        INSERT INTO dw.dim_tempo (
            dt_referencia, 
            dia, 
            mes, 
            ano, 
            nome_dia, 
            nome_mes, 
            trimestre, 
            eh_fim_de_semana
        ) VALUES (
            -- Atribuindo o valor da data atual.
            data_atual,
            -- Extraindo o dia da data atual.
            EXTRACT(DAY FROM data_atual),
            -- Extraindo o mês da data atual.
            EXTRACT(MONTH FROM data_atual),
            -- Extraindo o ano da data atual.
            EXTRACT(YEAR FROM data_atual),
            -- Obtendo o nome completo do dia da semana em inglês (ou conforme a configuração de localidade).
            TO_CHAR(data_atual, 'Day'),
            -- Obtendo o nome completo do mês em inglês (ou conforme a configuração de localidade).
            TO_CHAR(data_atual, 'Month'),
            -- Determinando o trimestre baseado no mês.
            CASE 
                WHEN EXTRACT(MONTH FROM data_atual) IN (1,2,3) THEN 1
                WHEN EXTRACT(MONTH FROM data_atual) IN (4,5,6) THEN 2
                WHEN EXTRACT(MONTH FROM data_atual) IN (7,8,9) THEN 3
                WHEN EXTRACT(MONTH FROM data_atual) IN (10,11,12) THEN 4
            END,
            -- Determinando se a data é um fim de semana (0 para domingo e 6 para sábado).
            CASE WHEN EXTRACT(DOW FROM data_atual) IN (0, 6) THEN TRUE ELSE FALSE END
        );
        
        -- Incrementando a data atual para avançar para o próximo dia.
        data_atual := data_atual + INTERVAL '1 day';
        
    -- Fim do loop WHILE.
    END LOOP;
    
-- Fim do bloco de comandos.
END $$;



