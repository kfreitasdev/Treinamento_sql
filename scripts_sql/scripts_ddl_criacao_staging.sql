------CRIAÇÃO DA STAGING - MANUALMENTE -------

CREATE TABLE staging.actor AS SELECT * FROM oltp.actor  ---- CRIAÇÃO MANUAL... SERIA NECESSÁRIO UM COMANDO PARA CADA TABELA...
;

------CRIAÇÃO DA STAGING AREA USANDO LOOPING-------

DO $$ -- Inicia um bloco de código DO
DECLARE -- Declara uma variável r para manter os registros retornados pela consulta
    tabela RECORD;
BEGIN
    -- Informar o schema de origem das Tabelas
    FOR tabela IN (SELECT table_name FROM information_schema.tables WHERE table_schema = 'oltp') 
    LOOP
        EXECUTE 'CREATE TABLE staging.' || tabela.table_name || ' AS SELECT * FROM oltp.' || tabela.table_name;
    END LOOP; -- Finaliza o bloco de código principal
END $$; -- Finaliza o bloco de código DO

