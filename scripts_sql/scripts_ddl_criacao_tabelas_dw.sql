--SCRIPTS PARA CRIAÇÃO DO DATA WAREHOUSE COM COMANDOS SQL--

--PRIMEIRA ETAPA: Criação da sequence para a Surrogate Key

CREATE SEQUENCE dw.dim_ator_id_seq
INCREMENT BY 1
NO MINVALUE 
NO MAXVALUE 
START 1
;
--SELECT nextval('dw.dim_ator_id_seq')
;
-- SEGUNDA ETAPA: Criação das Tabelas Dimensão
CREATE TABLE dw.dim_ator (
	sk_ator integer PRIMARY KEY NOT NULL DEFAULT nextval('dw.dim_ator_id_seq'),
	nk_ator integer,
	nm_ator varchar(255),
	dt_carga date
	)
;
CREATE SEQUENCE dw.dim_filme_id_seq
INCREMENT BY 1
NO MINVALUE 
NO MAXVALUE 
START 1
;
--SELECT nextval('dw.dim_filme_id_seq')
;
CREATE TABLE dw.dim_filme (
	sk_filme integer PRIMARY KEY NOT NULL DEFAULT nextval('dw.dim_filme_id_seq'),
	nk_filme integer NOT NULL,
	dsc_titulo varchar(255),
	ano_lancamento varchar(20),
	num_duracao  integer,
	dsc_classificacao_filme varchar(20),
	dsc_idioma varchar(100),
	dsc_categoria_filme varchar(20),
	dt_carga date
);

CREATE SEQUENCE dw.dim_loja_id_seq
INCREMENT BY 1
NO MINVALUE 
NO MAXVALUE 
START 1
;
--SELECT nextval('dw.dim_loja_id_seq')
;
CREATE TABLE dw.dim_loja (
	sk_loja integer PRIMARY KEY NOT NULL DEFAULT nextval('dw.dim_loja_id_seq'),
	nk_loja integer NOT NULL,
	dsc_endereco_loja varchar(255),
	nm_cidade varchar(255),
	nm_pais varchar(50),
	nm_gerente varchar(50),
	dt_carga date
)
;
CREATE SEQUENCE dw.dim_cliente_id_seq
INCREMENT BY 1
NO MINVALUE 
NO MAXVALUE 
START 1
;
--SELECT nextval('dw.dim_cliente_id_seq')
;
CREATE TABLE dw.dim_cliente (
	sk_cliente integer PRIMARY KEY NOT NULL DEFAULT nextval('dw.dim_cliente_id_seq'),
	nk_cliente integer NOT NULL,
	nm_cliente varchar(100),
	dsc_endereco varchar(255),
	nm_cidade varchar(255),
	nm_pais varchar(50),
	dt_carga date
)
;
CREATE SEQUENCE dw.dim_tempo_id_seq
INCREMENT BY 1
NO MINVALUE 
NO MAXVALUE 
START 1
;
--SELECT nextval('dw.dim_tempo_id_seq')
;
CREATE TABLE dw.dim_tempo (
    sk_tempo integer PRIMARY KEY NOT NULL DEFAULT nextval('dw.dim_tempo_id_seq'),
    dt_referencia DATE NOT NULL,
    dia INT NOT NULL,
    mes INT NOT NULL,
    ano INT NOT NULL,
    nome_dia VARCHAR(10) NOT NULL,
    nome_mes VARCHAR(15) NOT NULL,
    trimestre INT NOT NULL,
    eh_fim_de_semana BOOLEAN NOT NULL
)
;
CREATE TABLE dw.ft_aluguel_filmes (
	dt_locacao date,
	dt_devolucao date,
	sk_cliente integer,
	sk_loja integer,
	sk_filme integer,
	sk_ator integer,
	dsc_status_locacao varchar(50),
	qtd_dias_locacao integer,
	qtd_locacoes integer,
	vlr_total_locacoes numeric(23,2)
)
;

-----ADICIONANDO CONSTRAINT E CRIANDO AS RESTRIÇÕES DE CHAVE ESTRANGEIRA--------

ALTER TABLE dw.ft_aluguel_filmes ADD CONSTRAINT dim_filme_ft_aluguel_filmes_fk 
FOREIGN KEY (sk_filme) 
REFERENCES dw.dim_filme (sk_filme)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE dw.ft_aluguel_filmes ADD CONSTRAINT dim_loja_ft_aluguel_filmes_fk
FOREIGN KEY (sk_loja)
REFERENCES dw.dim_loja (sk_loja)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE dw.ft_aluguel_filmes ADD CONSTRAINT dim_cliente_ft_aluguel_filmes_fk
FOREIGN KEY (sk_cliente)
REFERENCES dw.dim_cliente (sk_cliente)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE dw.ft_aluguel_filmes ADD CONSTRAINT dim_ator_ft_aluguel_filmes_fk
FOREIGN KEY (sk_ator)
REFERENCES dw.dim_ator (sk_ator)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;










































	



































	
	