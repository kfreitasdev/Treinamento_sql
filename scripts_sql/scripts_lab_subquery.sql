--1. Uso de Subquery

-- Cenário: Análise de vendas para identificar clientes que gastaram acima da média.


CREATE TABLE clientes (
id_cliente serial PRIMARY KEY,
nome varchar(100)
)


CREATE TABLE vendas (
id_venda serial PRIMARY KEY,
id_cliente integer,
valor decimal(10,2)
)

INSERT INTO clientes (nome)
SELECT 'Cliente ' || i FROM generate_series(1,1000) AS i

INSERT INTO vendas (id_cliente, valor)
SELECT (i % 1000) + 1, round((random() * 500)::NUMERIC,2)
FROM generate_series(1,5000) AS i


WITH mediavendas AS ( 
SELECT 
id_cliente,
avg(valor) AS media
FROM vendas
GROUP BY 1
)
SELECT 
c.nome,
v.valor
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id_cliente
JOIN mediavendas m ON m.id_cliente = v.id_cliente
WHERE v.valor > m.media


--WHERE v.valor > (SELECT avg(valor) FROM vendas) --- subquery



--Vamos criar um exemplo de uma subquery usada como coluna, onde utilizaremos LIMIT 1 para retornar um registro específico baseado em alguma chave e data. 
--Imagine que temos duas tabelas: uma para pedidos e outra para pagamentos. Queremos mostrar o último pagamento feito para cada pedido.


--1º Tabela de Pedidos

CREATE TABLE pedidos (
    id_pedido SERIAL PRIMARY KEY,
    descricao TEXT,
    data_pedido DATE
);

-- 2º Tabela de Pagamentos

CREATE TABLE pagamentos (
    id_pagamento SERIAL PRIMARY KEY,
    id_pedido INT,
    valor DECIMAL(10,2),
    data_pagamento DATE
);

INSERT INTO pedidos (descricao, data_pedido) VALUES 
('Pedido 1', '2023-01-01'),
('Pedido 2', '2023-01-02'),
('Pedido 3', '2023-01-03');

INSERT INTO pagamentos (id_pedido, valor, data_pagamento) VALUES 
(1, 100.00, '2023-01-02'),
(1, 50.00, '2023-01-03'),
(2, 75.00, '2023-01-04'),
(2, 25.00, '2023-01-05'),
(3, 150.00, '2023-01-06');


-- Exemplo de Subquery com Limit 1

SELECT 
p.id_pedido,
p.descricao,
p.data_pedido,
(SELECT pag.data_pagamento
FROM pagamentos pag
WHERE pag.id_pedido = p.id_pedido
ORDER BY pag.data_pagamento DESC 
LIMIT 1) AS data_ultimo_pagamento
FROM pedidos p

WITH maxdata AS (SELECT 
pag.data_pagamento,
pag.id_pedido,
ROW_NUMBER() OVER (PARTITION BY pag.id_pedido ORDER BY pag.data_pagamento DESC) AS linha
FROM pagamentos pag
)
SELECT * FROM pedidos p
LEFT JOIN maxdata ON maxdata.id_pedido = p.id_pedido
AND maxdata.linha = 1




















