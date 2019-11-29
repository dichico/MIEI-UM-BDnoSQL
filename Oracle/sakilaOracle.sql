-- Parte do Customer Data
-- Estrutura e criação da tabela country.
CREATE TABLE country (
    country_id SMALLINT NOT NULL,
    country VARCHAR(50) NOT NULL,
    last_update DATE,
    CONSTRAINT country_PK PRIMARY KEY (country_id)
);

-- Criação do "auto-increment" do country através da sequência e do seu trigger.
CREATE SEQUENCE country_sq
START WITH 110;

CREATE OR REPLACE TRIGGER country_bi_trigger
BEFORE INSERT ON country FOR EACH ROW
BEGIN
    IF (:NEW.country_id IS NULL) THEN
        SELECT country_sq.nextval INTO :NEW.country_id
        FROM DUAL;
    END IF;
    -- aproveitar o trigger para adicionar o timestamp em modo ORACLE
    :NEW.last_update:=current_date;
END;

-- Criação do trigger para atualização do "timestamp" caso exista update.
CREATE OR REPLACE TRIGGER country_bu_trigger
BEFORE UPDATE ON country FOR EACH ROW
BEGIN
  :NEW.last_update:=current_date;
END;

-- Estrutura e criação da tabela city.
CREATE TABLE city (
  city_id int NOT NULL,
  city VARCHAR(50) NOT NULL,
  country_id SMALLINT NOT NULL,
  last_update DATE NOT NULL,
  CONSTRAINT city_PK PRIMARY KEY (city_id),
  CONSTRAINT city_country_FK FOREIGN KEY (country_id) REFERENCES country (country_id)
);

-- Criação do "auto-increment" do city através da sequência e do seu trigger.
CREATE SEQUENCE city_sq
START WITH 601;

CREATE OR REPLACE TRIGGER city_bi_trigger
BEFORE INSERT ON city FOR EACH ROW
BEGIN
    IF (:NEW.city_id IS NULL) THEN
        SELECT city_sq.nextval INTO :NEW.city_id
        FROM DUAL;
    END IF;
    -- aproveitar o trigger para adicionar o timestamp em modo ORACLE
    :NEW.last_update:=current_date;
END;

-- Criação do trigger para atualização do "timestamp" caso exista update.
CREATE OR REPLACE TRIGGER city_bu_trigger
BEFORE UPDATE ON city FOR EACH ROW
BEGIN
  :NEW.last_update:=current_date;
END;

-- Estrutura e criação da tabela address.
CREATE TABLE address (
    address_id int NOT NULL,
    address VARCHAR(50) NOT NULL,
    address2 VARCHAR(50) DEFAULT NULL,
    district VARCHAR(20) NOT NULL,
    city_id INT NOT NULL,
    postal_code VARCHAR(10) DEFAULT NULL,
    phone VARCHAR(20) NOT NULL,
    last_update DATE NOT NULL,
    CONSTRAINT address_PK PRIMARY KEY (address_id),
    CONSTRAINT address_city_FK FOREIGN KEY (city_id) REFERENCES city (city_id)
);

-- Criação do "auto-increment" do address através da sequência e do seu trigger.
CREATE SEQUENCE address_sq
START WITH 606;

CREATE OR REPLACE TRIGGER address_bi_trigger
BEFORE INSERT ON address FOR EACH ROW
BEGIN
    IF (:NEW.address_id IS NULL) THEN
        SELECT address_sq.nextval INTO :NEW.address_id
        FROM DUAL;
    END IF;
    -- criar o timestamp
    :NEW.last_update:=current_date;
END;

-- Criação do trigger para atualização do "timestamp" caso exista update.
CREATE OR REPLACE TRIGGER address_bu_trigger
BEFORE UPDATE ON address FOR EACH ROW
BEGIN
  :NEW.last_update:=current_date;
END;

-- Estrutura da tabela customer.
CREATE TABLE customer (
    customer_id INT NOT NULL,
    store_id INT NOT NULL,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    email VARCHAR(50) DEFAULT NULL,
    address_id INT NOT NULL,
    active CHAR(1) DEFAULT 'Y' NOT NULL,
    create_date DATE NOT NULL,
    last_update DATE NOT NULL,
    CONSTRAINT customer_PK PRIMARY KEY  (customer_id),
    CONSTRAINT customer_address_FK FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- Criação do índice pelo último nome do customer.
CREATE INDEX last_name_I ON customer(last_name);

-- Criação do "auto-increment" do customer através da sequência e do seu trigger.
CREATE SEQUENCE customer_sq
START WITH 600;

CREATE OR REPLACE TRIGGER customer_bi_trigger
BEFORE INSERT ON customer FOR EACH ROW
BEGIN
    IF (:NEW.customer_id IS NULL) THEN
        SELECT customer_sequence.nextval INTO :NEW.customer_id
        FROM DUAL;
    END IF;
    -- criação dos timestamps.
    :NEW.last_update:=current_date;
    :NEW.create_date:=current_date;
END;

-- Criação do trigger para atualização do "timestamp" caso exista update.
CREATE OR REPLACE TRIGGER customer_bu_trigger
BEFORE UPDATE ON customer FOR EACH ROW
BEGIN
    :NEW.last_update:=current_date;
END;


-------
-- Parte do Inventory
-- Estrutura para a tabela actor.
CREATE TABLE actor (
    actor_id numeric NOT NULL,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    last_update DATE NOT NULL,
    CONSTRAINT actor_PK PRIMARY KEY (actor_id)
);

-- Criação do index adicional pelo último nome do actor.
CREATE INDEX last_name_I ON actor(last_name);

-- Criação do "auto-increment" do actor através da sequência e do seu trigger.
CREATE SEQUENCE actor_sq
START WITH 201;

CREATE OR REPLACE TRIGGER actor_bi_trigger
BEFORE INSERT ON actor FOR EACH ROW
BEGIN
    IF (:NEW.actor_id IS NULL) THEN
        SELECT actor_sq.nextval INTO :NEW.actor_id
        FROM DUAL;
    END IF;
    -- aproveitar o trigger para adicionar o timestamp em modo ORACLE
    :NEW.last_update:=current_date;
END;

-- Criação do trigger para atualizar o timestamp caso exista um update.
CREATE OR REPLACE TRIGGER actor_bu_trigger
BEFORE UPDATE ON actor FOR EACH ROW
BEGIN
  :NEW.last_update:=current_date;
END;

-- Estrutura para a tabela language
CREATE TABLE language (
    language_id SMALLINT NOT NULL,
    name CHAR(20) NOT NULL,
    last_update DATE NOT NULL,
    CONSTRAINT language_PK PRIMARY KEY (language_id)
);

CREATE SEQUENCE language_sq
START WITH 7;

-- Criação do "auto-increment" do language através da sequência e do seu trigger.
CREATE OR REPLACE TRIGGER language_bi_trigger
BEFORE INSERT ON language FOR EACH ROW
BEGIN
    IF (:NEW.language_id IS NULL) THEN
    SELECT language_sq.nextval INTO :NEW.language_id
    FROM DUAL;
    END IF;
    -- aproveitar o trigger para adicionar o timestamp em modo ORACLE
    :NEW.last_update:=current_date;
END;

-- Criação do trigger para atualizar o timestamp caso exista um update.
CREATE OR REPLACE TRIGGER language_bu_trigger
BEFORE UPDATE ON language FOR EACH ROW
BEGIN
    :NEW.last_update:=current_date;
END;

-- Estrutura da tabela category
CREATE TABLE category (
    category_id SMALLINT NOT NULL,
    name VARCHAR(25) NOT NULL,
    last_update DATE NOT NULL,
    CONSTRAINT category_PK PRIMARY KEY (category_id)
);

-- Criação do "auto-increment" do category através da sequência e do seu trigger.
CREATE SEQUENCE category_sq
START WITH 17;

CREATE OR REPLACE TRIGGER category_bi_trigger
BEFORE INSERT ON category FOR EACH ROW
BEGIN
    IF (:NEW.category_id IS NULL) THEN
        SELECT category_sq.nextval INTO :NEW.category_id
        FROM DUAL;
    END IF;
    -- aproveitar o trigger para adicionar o timestamp em modo ORACLE
    :NEW.last_update:=current_date;
END;

-- Criação do trigger para atualizar o timestamp caso exista um update.
CREATE OR REPLACE TRIGGER category_bu_trigger
BEFORE UPDATE ON category FOR EACH ROW
BEGIN
    :NEW.last_update:=current_date;
END;

-- Estrutura da tabela film.
CREATE TABLE film (
    film_id int NOT NULL,
    title VARCHAR(255) NOT NULL,
    description CLOB DEFAULT NULL,
    release_year VARCHAR(4) DEFAULT NULL,
    language_id SMALLINT NOT NULL,
    original_language_id SMALLINT DEFAULT NULL,
    rental_duration SMALLINT  DEFAULT 3 NOT NULL,
    rental_rate DECIMAL(4,2) DEFAULT 4.99 NOT NULL,
    length SMALLINT DEFAULT NULL,
    replacement_cost DECIMAL(5,2) DEFAULT 19.99 NOT NULL,
    rating VARCHAR(10) DEFAULT 'G',
    special_features VARCHAR(100) DEFAULT NULL,
    last_update DATE NOT NULL,
    CONSTRAINT film_PK PRIMARY KEY  (film_id),
    CONSTRAINT film_language_FK FOREIGN KEY (language_id) REFERENCES language (language_id),
    CONSTRAINT film_language_original_FK FOREIGN KEY (original_language_id) REFERENCES language (language_id),
    -- criação de checks em ORACLE para os ENUMs e SETs do MySQL
    CONSTRAINT special_features_CHK CHECK(special_features IS NULL OR
      special_features like '%Trailers%' or
      special_features like '%Commentaries%' or
      special_features like '%Deleted Scenes%' or
      special_features like '%Behind the Scenes%'),
    CONSTRAINT special_rating_CHK CHECK (rating in ('G', 'PG', 'PG-13', 'R', 'NC-17'))
);

-- Criação dum índice adicional para os títulos dos filmes.
CREATE INDEX title_I ON film(title);

-- Criação do "auto-increment" do category através da sequência e do seu trigger.
CREATE SEQUENCE film_sq
START WITH 1001;

CREATE OR REPLACE TRIGGER film_bi_trigger
BEFORE INSERT ON film FOR EACH ROW
BEGIN
 IF (:NEW.film_id IS NULL) THEN
   SELECT film_sq.nextval INTO :NEW.film_id
    FROM DUAL;
  END IF;
  :NEW.last_update:=current_date;
END;

-- Criação do trigger para atualizar o timestamp caso exista um update.
CREATE OR REPLACE TRIGGER film_bu_trigger
BEFORE UPDATE ON film FOR EACH ROW
BEGIN
  :NEW.last_update:=current_date;
END;

-- Estrutura da tabela N:N da film_actor
CREATE TABLE film_actor (
    actor_id INT NOT NULL,
    film_id  INT NOT NULL,
    last_update DATE NOT NULL,
    CONSTRAINT film_actor_PK PRIMARY KEY (actor_id,film_id),
    CONSTRAINT film_actor_actor_FK FOREIGN KEY (actor_id) REFERENCES actor (actor_id),
    CONSTRAINT film_actor_film_FK FOREIGN KEY (film_id) REFERENCES film (film_id)
);

-- Criação do trigger para atualizar o timestamp caso exista um update ou insert inicial.
CREATE OR REPLACE TRIGGER film_actor_biu_trigger
BEFORE INSERT OR UPDATE ON film_actor FOR EACH ROW
BEGIN
    :NEW.last_update:=current_date;
END;

CREATE TABLE film_category (
    film_id INT NOT NULL,
    category_id SMALLINT NOT NULL,
    last_update DATE NOT NULL,
    CONSTRAINT film_category_PK PRIMARY KEY (film_id, category_id),
    CONSTRAINT film_category_film_FK FOREIGN KEY (film_id) REFERENCES film (film_id),
    CONSTRAINT film_category_category_FK FOREIGN KEY (category_id) REFERENCES category (category_id)
);

-- Criação do trigger para atualizar o timestamp caso exista um update ou insert inicial.
CREATE OR REPLACE TRIGGER film_category_biu_trigger
BEFORE INSERT OR UPDATE ON film_category FOR EACH ROW
BEGIN
    :NEW.last_update:=current_date;
END;

CREATE TABLE film_text (
  film_id SMALLINT NOT NULL,
  title VARCHAR(255) NOT NULL,
  description CLOB,
  CONSTRAINT pk_film_text PRIMARY KEY (film_id)
);

-- Estrutura da tabela inventory
CREATE TABLE inventory (
    inventory_id INT NOT NULL,
    film_id INT NOT NULL,
    store_id INT NOT NULL,
    last_update DATE NOT NULL,
    CONSTRAINT inventory_PK PRIMARY KEY  (inventory_id),
    CONSTRAINT inventory_film_FK FOREIGN KEY (film_id) REFERENCES film (film_id)
);

-- Criação do "auto-increment" do category através da sequência e do seu trigger.
CREATE SEQUENCE inventory_sq;

CREATE OR REPLACE TRIGGER inventory_bi_trigger
BEFORE INSERT ON inventory FOR EACH ROW
BEGIN
    IF (:NEW.inventory_id IS NULL) THEN
        SELECT inventory_sq.nextval INTO :NEW.inventory_id
        FROM DUAL;
        END IF;
    :NEW.last_update:=current_date;
END;

-- Criação do trigger para atualizar o timestamp caso exista um update.
CREATE OR REPLACE TRIGGER inventory_bu_trigger
BEFORE UPDATE ON inventory FOR EACH ROW
BEGIN
  :NEW.last_update:=current_date;
END;

-- Estrutura da tabela staff
CREATE TABLE staff (
  staff_id SMALLINT NOT NULL,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  address_id INT NOT NULL,
  picture BLOB DEFAULT NULL,
  email VARCHAR(50) DEFAULT NULL,
  store_id INT NOT NULL,
  active SMALLINT DEFAULT 1 NOT NULL,
  username VARCHAR(16) NOT NULL,
  password VARCHAR(40) DEFAULT NULL,
  last_update DATE NOT NULL,
  CONSTRAINT staff_PK PRIMARY KEY  (staff_id),
  CONSTRAINT staff_address_FK FOREIGN KEY (address_id) REFERENCES address (address_id)
);

-- Criação do "auto-increment" do category através da sequência e do seu trigger.
CREATE SEQUENCE staff_sq;

CREATE OR REPLACE TRIGGER staff_bi_trigger
BEFORE INSERT ON staff FOR EACH ROW
BEGIN
 IF (:NEW.staff_id IS NULL) THEN
   SELECT staff_sq.nextval INTO :NEW.staff_id
    FROM DUAL;
  END IF;
  :NEW.last_update:=current_date;
END;

-- Criação do trigger para atualizar o timestamp caso exista um update ou insert inicial.
CREATE OR REPLACE TRIGGER staff_bu_trigger
BEFORE UPDATE ON staff FOR EACH ROW
BEGIN
  :NEW.last_update:=current_date;
END;

