--TRUNCAR DINAMICAMENTE TODAS AS TABELAS DE UM SCHEMA--
-- Inicia um bloco de código DO
DO $$ 
-- Declara uma variável r para manter os registros retornados pela consulta
DECLARE 
   r RECORD;
-- Inicia o bloco de código principal
BEGIN 
   -- Inicia um loop FOR que itera sobre os resultados da consulta
   FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') 
   LOOP
      -- Executa o comando TRUNCATE na tabela atual usando execução dinâmica de SQL
      EXECUTE 'TRUNCATE TABLE ' || quote_ident(r.tablename) || ' CASCADE;';
   -- Finaliza o loop FOR
   END LOOP;
-- Finaliza o bloco de código principal
END 
-- Finaliza o bloco de código DO
$$;

--Explicações detalhadas:

DO $$

--Inicia um bloco de código DO, que permite executar um bloco anônimo de código PL/pgSQL.
DECLARE:

--Inicia uma declaração de variáveis. Neste caso, apenas uma variável r do tipo RECORD é declarada para manter cada linha retornada pela consulta.
r RECORD;:

--Declara a variável r como um tipo de RECORD, que pode manter uma linha de resultados de uma consulta.
BEGIN:

--Inicia o bloco de código principal.
FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public'):

--Inicia um loop FOR que itera sobre os resultados da consulta que seleciona os nomes das tabelas no esquema public.
LOOP:

--Inicia o corpo do loop.
EXECUTE 'TRUNCATE TABLE ' || quote_ident(r.tablename) || ' CASCADE;':

--Usa o comando EXECUTE para executar dinamicamente o comando TRUNCATE na tabela atual. A função quote_ident é usada para escapar corretamente o nome da tabela, e CASCADE é usado para truncar também todas as tabelas referenciadas.
END LOOP;:

--Finaliza o corpo do loop.
END:
--Finaliza o bloco de código principal.
$$;:
--Finaliza o bloco de código DO, indicando o fim do bloco de código PL/pgSQL.

---DROPAR DINAMICAMENTE TODAS AS TABELAS E SEQUENCES DE UM SCHEMA---
DO $$ 
DECLARE 
   r RECORD;
BEGIN 
   -- Dropar tabelas
   FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') 
   LOOP
      EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(r.tablename) || ' CASCADE;';
   END LOOP;
   
   -- Dropar sequences
   FOR r IN (SELECT sequence_name FROM information_schema.sequences WHERE sequence_schema = 'public') 
   LOOP
      EXECUTE 'DROP SEQUENCE IF EXISTS ' || quote_ident(r.sequence_name) || ';';
   END LOOP;
END $$;

























































