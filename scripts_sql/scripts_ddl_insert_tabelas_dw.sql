--Realizar a Carga das Dimensões com base nas Tabelas da Staging

insert into dw.dim_ator
select 
nextval('dw.dim_ator_id_seq') as sk_ator,
actor_id,
first_name || ' ' || last_name as nm_ator,
current_date as dt_carga
from staging.actor 

-- Realizar a Validação da Carga

select * from dw.dim_ator
;

insert into dw.dim_cliente
select 
nextval('dw.dim_cliente_id_seq') as sk_cliente,
customer_id,
cus.first_name || ' ' || cus.last_name as nm_cliente,
upper(a.address) as endereco,
upper(ci.city) as city,
upper(co.country) as country,
current_date as dt_carga
from staging.customer cus
join staging.address a on a.address_id = cus.address_id
join staging.city ci on ci.city_id = a.city_id
join staging.country co on co.country_id = ci.country_id 
;
-- Realizar a Validação da Carga

select * from dw.dim_cliente

;

insert into dw.dim_filme
select
nextval('dw.dim_filme_id_seq'),
f.film_id,
f.title,
f.release_year,
f.rental_duration,
f.rating,
upper(la."name") as idioma,
upper(cat."name"),
current_date as dt_carga
from staging.film f
join staging.film_category fc on fc.film_id = f.film_id 
join staging."language" la on la.language_id = f.language_id
join staging.category cat on cat.category_id = fc.category_id
;

select * from dw.dim_filme

;
insert into dw.dim_loja 
select
nextval('dw.dim_loja_id_seq') as sk_loja,
s.store_id,
upper(a.address) as address,
upper(ci.city) as city,
upper(co.country) as country,
upper(st.first_name) || ' ' || upper(st.last_name) as gerente,
current_date as dt_carga
from staging.store s
join staging.address a on a.address_id = s.address_id 
join staging.city ci on ci.city_id = a.city_id
join staging.country co on co.country_id = ci.country_id 
join staging.staff st on st.store_id = s.store_id 
;

select * from dw.dim_loja
;

INSERT INTO dw.ft_aluguel_filmes
SELECT 
    dt1.dt_referencia AS dt_locacao,
    dt2.dt_referencia AS dt_devolucao,
    dim_cliente.sk_cliente,
    dim_loja.sk_loja,
    dim_filme.sk_filme,
    dim_ator.sk_ator,
        CASE
	    WHEN (dt2.dt_referencia - dt1.dt_referencia) <=3 THEN 'DEVOLVIDO NO PRAZO'
    	WHEN (dt2.dt_referencia - dt1.dt_referencia) > 3 THEN 'DEVOLVIDO COM ATRASO'
    	WHEN (dt2.dt_referencia - dt1.dt_referencia) = 0 THEN 'ENTRAR EM CONTATO COM O CLIENTE'
    	ELSE 'ENTRAR EM CONTATO COM O CLIENTE'
    END AS dsc_status_locacao,
    (dt2.dt_referencia - dt1.dt_referencia) AS qtd_dias_locacao,
    COUNT(rental.rental_id) AS qtd_locacoes,
    SUM(payment.amount) AS vlr_total_locacoes
FROM 
    staging.rental 
JOIN staging.customer ON rental.customer_id = customer.customer_id
JOIN staging.inventory ON rental.inventory_id = inventory.inventory_id
JOIN staging.store ON inventory.store_id = store.store_id
JOIN staging.film ON inventory.film_id = film.film_id
JOIN staging.film_actor ON film.film_id = film_actor.film_id
JOIN staging.actor ON film_actor.actor_id = actor.actor_id
JOIN staging.payment ON rental.rental_id = payment.rental_id
JOIN dw.dim_tempo dt1 ON dt1.dt_referencia = rental.rental_date::date
JOIN dw.dim_tempo dt2 ON dt2.dt_referencia = rental.return_date::date
JOIN dw.dim_cliente ON customer.customer_id = dim_cliente.nk_cliente
JOIN dw.dim_loja ON dim_loja.nk_loja = store.store_id
JOIN dw.dim_filme ON dim_filme.nk_filme = film.film_id
JOIN dw.dim_ator ON dim_ator.nk_ator = actor.actor_id
GROUP BY 1,2,3,4,5,6;



























