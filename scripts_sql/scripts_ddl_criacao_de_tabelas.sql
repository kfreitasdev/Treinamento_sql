---SCRIPTS DDL PARA CRIAÇÃO DE SEQUENCES E TABELAS---
-- Este é um comentário geral para o script.
CREATE SEQUENCE customer_customer_id_seq
-- Cria uma nova SEQUENCE para gerar valores numéricos exclusivos.
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE customer (
-- Inicia a definição de uma nova tabela.
    customer_id SERIAL PRIMARY KEY,
-- Define esta coluna como chave primária da tabela.
    store_id smallint NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text,
    address_id smallint NOT NULL,
    activebool boolean DEFAULT true NOT NULL,
    create_date date DEFAULT ('now'::text)::date NOT NULL,
    last_update timestamp with time zone DEFAULT now(),
    active integer
);

CREATE SEQUENCE actor_actor_id_seq
-- Cria uma nova SEQUENCE para gerar valores numéricos exclusivos.
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE actor (
-- Inicia a definição de uma nova tabela.
    actor_id integer DEFAULT nextval('actor_actor_id_seq'::regclass) NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE category_category_id_seq
-- Cria uma nova SEQUENCE para gerar valores numéricos exclusivos.
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE category (
-- Inicia a definição de uma nova tabela.
    category_id integer DEFAULT nextval('category_category_id_seq'::regclass) NOT NULL,
    name text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE film_film_id_seq
-- Cria uma nova SEQUENCE para gerar valores numéricos exclusivos.
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE film (
-- Inicia a definição de uma nova tabela.
    film_id integer DEFAULT nextval('film_film_id_seq'::regclass) NOT NULL,
    title text NOT NULL,
    description text,
    release_year text,
    language_id smallint NOT NULL,
    original_language_id smallint,
    rental_duration smallint DEFAULT 3 NOT NULL,
    rental_rate numeric(4,2) DEFAULT 4.99 NOT NULL,
    length smallint,
    replacement_cost numeric(5,2) DEFAULT 19.99 NOT NULL,
    rating VARCHAR(5) DEFAULT 'G',
    last_update timestamp with time zone DEFAULT now() NOT NULL,
    special_features text[],
    fulltext tsvector NOT NULL
);

CREATE TABLE film_actor (
-- Inicia a definição de uma nova tabela.
    actor_id smallint NOT NULL,
    film_id smallint NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE film_category (
-- Inicia a definição de uma nova tabela.
    film_id smallint NOT NULL,
    category_id smallint NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE address_address_id_seq
-- Cria uma nova SEQUENCE para gerar valores numéricos exclusivos.
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE address (
-- Inicia a definição de uma nova tabela.
    address_id integer DEFAULT nextval('address_address_id_seq'::regclass) NOT NULL,
    address text NOT NULL,
    address2 text,
    district text NOT NULL,
    city_id smallint NOT NULL,
    postal_code text,
    phone text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE city_city_id_seq
-- Cria uma nova SEQUENCE para gerar valores numéricos exclusivos.
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE city (
-- Inicia a definição de uma nova tabela.
    city_id integer DEFAULT nextval('city_city_id_seq'::regclass) NOT NULL,
    city text NOT NULL,
    country_id smallint NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE country_country_id_seq
-- Cria uma nova SEQUENCE para gerar valores numéricos exclusivos.
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE country (
-- Inicia a definição de uma nova tabela.
    country_id integer DEFAULT nextval('country_country_id_seq'::regclass) NOT NULL,
    country text NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE inventory_inventory_id_seq
-- Cria uma nova SEQUENCE para gerar valores numéricos exclusivos.
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE inventory (
-- Inicia a definição de uma nova tabela.
    inventory_id integer DEFAULT nextval('inventory_inventory_id_seq'::regclass) NOT NULL,
    film_id smallint NOT NULL,
    store_id smallint NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE language_language_id_seq
-- Cria uma nova SEQUENCE para gerar valores numéricos exclusivos.
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE language (
-- Inicia a definição de uma nova tabela.
    language_id integer DEFAULT nextval('language_language_id_seq'::regclass) NOT NULL,
    name character(20) NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE payment_payment_id_seq
-- Cria uma nova SEQUENCE para gerar valores numéricos exclusivos.
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE payment (
-- Inicia a definição de uma nova tabela.
    payment_id integer DEFAULT nextval('payment_payment_id_seq'::regclass) NOT NULL,
    customer_id smallint NOT NULL,
    staff_id smallint NOT NULL,
    rental_id integer NOT NULL,
    amount numeric(5,2) NOT NULL,
    payment_date timestamp with time zone NOT NULL
) PARTITION BY RANGE(payment_date);

/*CREATE TABLE payment_p2017_01 PARTITION OF payment
-- Inicia a definição de uma nova tabela.
    FOR VALUES FROM ('2017-01-01 00:00:00+3:00') TO ('2017-02-01 00:00:00+3:00');*/

CREATE SEQUENCE rental_rental_id_seq
-- Cria uma nova SEQUENCE para gerar valores numéricos exclusivos.
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE rental (
-- Inicia a definição de uma nova tabela.
    rental_id integer DEFAULT nextval('rental_rental_id_seq'::regclass) NOT NULL,
    rental_date timestamp with time zone NOT NULL,
    inventory_id integer NOT NULL,
    customer_id smallint NOT NULL,
    return_date timestamp with time zone,
    staff_id smallint NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE staff_staff_id_seq
-- Cria uma nova SEQUENCE para gerar valores numéricos exclusivos.
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE staff (
-- Inicia a definição de uma nova tabela.
    staff_id integer DEFAULT nextval('staff_staff_id_seq'::regclass) NOT NULL,
    first_name text NOT NULL,
    last_name text NOT NULL,
    address_id smallint NOT NULL,
    email text,
    store_id smallint NOT NULL,
    active boolean DEFAULT true NOT NULL,
    username text NOT NULL,
    password text,
    last_update timestamp with time zone DEFAULT now() NOT NULL,
    picture bytea
);

CREATE SEQUENCE store_store_id_seq
-- Cria uma nova SEQUENCE para gerar valores numéricos exclusivos.
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE store (
-- Inicia a definição de uma nova tabela.
    store_id integer DEFAULT nextval('store_store_id_seq'::regclass) NOT NULL,
    manager_staff_id smallint NOT NULL,
    address_id smallint NOT NULL,
    last_update timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE ONLY actor
    ADD CONSTRAINT actor_pkey PRIMARY KEY (actor_id);

ALTER TABLE ONLY address
    ADD CONSTRAINT address_pkey PRIMARY KEY (address_id);

ALTER TABLE ONLY category
    ADD CONSTRAINT category_pkey PRIMARY KEY (category_id);

ALTER TABLE ONLY city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id);

ALTER TABLE ONLY country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_id);

ALTER TABLE ONLY film_actor
    ADD CONSTRAINT film_actor_pkey PRIMARY KEY (actor_id, film_id);

ALTER TABLE ONLY film_category
    ADD CONSTRAINT film_category_pkey PRIMARY KEY (film_id, category_id);

ALTER TABLE ONLY film
    ADD CONSTRAINT film_pkey PRIMARY KEY (film_id);

ALTER TABLE ONLY inventory
    ADD CONSTRAINT inventory_pkey PRIMARY KEY (inventory_id);

ALTER TABLE ONLY language
    ADD CONSTRAINT language_pkey PRIMARY KEY (language_id);

ALTER TABLE ONLY rental
    ADD CONSTRAINT rental_pkey PRIMARY KEY (rental_id);

ALTER TABLE ONLY staff
    ADD CONSTRAINT staff_pkey PRIMARY KEY (staff_id);

ALTER TABLE ONLY store
    ADD CONSTRAINT store_pkey PRIMARY KEY (store_id);

CREATE INDEX film_fulltext_idx ON film USING gist (fulltext);

CREATE INDEX idx_actor_last_name ON actor USING btree (last_name);

CREATE INDEX idx_fk_address_id ON customer USING btree (address_id);

CREATE INDEX idx_fk_city_id ON address USING btree (city_id);

CREATE INDEX idx_fk_country_id ON city USING btree (country_id);

CREATE INDEX idx_fk_customer_id ON payment USING btree (customer_id);

CREATE INDEX idx_fk_film_id ON film_actor USING btree (film_id);

CREATE INDEX idx_fk_inventory_id ON rental USING btree (inventory_id);

CREATE INDEX idx_fk_language_id ON film USING btree (language_id);

CREATE INDEX idx_fk_original_language_id ON film USING btree (original_language_id);

CREATE INDEX idx_fk_staff_id ON payment USING btree (staff_id);

CREATE INDEX idx_fk_store_id ON customer USING btree (store_id);

CREATE INDEX idx_last_name ON customer USING btree (last_name);

CREATE INDEX idx_store_id_film_id ON inventory USING btree (store_id, film_id);

CREATE INDEX idx_title ON film USING btree (title);

CREATE UNIQUE INDEX idx_unq_manager_staff_id ON store USING btree (manager_staff_id);

CREATE UNIQUE INDEX idx_unq_rental_rental_date_inventory_id_customer_id ON rental USING btree (rental_date, inventory_id, customer_id);

ALTER TABLE ONLY address
    ADD CONSTRAINT address_city_id_fkey FOREIGN KEY (city_id) REFERENCES city(city_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY city
    ADD CONSTRAINT city_country_id_fkey FOREIGN KEY (country_id) REFERENCES country(country_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_address_id_fkey FOREIGN KEY (address_id) REFERENCES address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY customer
    ADD CONSTRAINT customer_store_id_fkey FOREIGN KEY (store_id) REFERENCES store(store_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY film_actor
    ADD CONSTRAINT film_actor_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES actor(actor_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY film_actor
    ADD CONSTRAINT film_actor_film_id_fkey FOREIGN KEY (film_id) REFERENCES film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY film_category
    ADD CONSTRAINT film_category_category_id_fkey FOREIGN KEY (category_id) REFERENCES category(category_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY film_category
    ADD CONSTRAINT film_category_film_id_fkey FOREIGN KEY (film_id) REFERENCES film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY film
    ADD CONSTRAINT film_language_id_fkey FOREIGN KEY (language_id) REFERENCES language(language_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY film
    ADD CONSTRAINT film_original_language_id_fkey FOREIGN KEY (original_language_id) REFERENCES language(language_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY inventory
    ADD CONSTRAINT inventory_film_id_fkey FOREIGN KEY (film_id) REFERENCES film(film_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY inventory
    ADD CONSTRAINT inventory_store_id_fkey FOREIGN KEY (store_id) REFERENCES store(store_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY rental
    ADD CONSTRAINT rental_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY rental
    ADD CONSTRAINT rental_inventory_id_fkey FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY rental
    ADD CONSTRAINT rental_staff_id_fkey FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY staff
    ADD CONSTRAINT staff_address_id_fkey FOREIGN KEY (address_id) REFERENCES address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE ONLY staff
    ADD CONSTRAINT staff_store_id_fkey FOREIGN KEY (store_id) REFERENCES store(store_id);

ALTER TABLE ONLY store
    ADD CONSTRAINT store_address_id_fkey FOREIGN KEY (address_id) REFERENCES address(address_id) ON UPDATE CASCADE ON DELETE RESTRICT;

/*ALTER TABLE payment_p2017_01
    ADD FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
    ADD FOREIGN KEY(staff_id) REFERENCES staff(staff_id),
    ADD FOREIGN KEY(rental_id) REFERENCES rental(rental_id);*/