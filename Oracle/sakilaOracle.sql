-- Parte do Customer Data
-- Estrutura e criação da tabela country.
CREATE TABLE country (
    country_id SMALLINT NOT NULL,
    country VARCHAR(50) NOT NULL,
    last_update DATE,
    CONSTRAINT pk_country PRIMARY KEY (country_id)
);

-- Criação do "auto-increment" do country através da sequência e do seu trigger.
CREATE SEQUENCE country_sq
START WITH 110;

CREATE OR REPLACE TRIGGER country_before_insert
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
CREATE OR REPLACE TRIGGER country_before_update
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
  CONSTRAINT pk_city PRIMARY KEY (city_id),
  CONSTRAINT fk_city_country FOREIGN KEY (country_id) REFERENCES country (country_id)
);

-- Criação do "auto-increment" do city através da sequência e do seu trigger.
CREATE SEQUENCE city_sq
START WITH 601;

CREATE OR REPLACE TRIGGER city_before_insert
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
CREATE OR REPLACE TRIGGER city_before_update
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
    CONSTRAINT pk_address PRIMARY KEY (address_id),
    CONSTRAINT fk_address_city FOREIGN KEY (city_id) REFERENCES city (city_id)
);

-- Criação do "auto-increment" do address através da sequência e do seu trigger.
CREATE SEQUENCE address_sq
START WITH 606;

CREATE OR REPLACE TRIGGER address_before_insert
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
CREATE OR REPLACE TRIGGER address_before_update
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
    CONSTRAINT pk_customer PRIMARY KEY  (customer_id),
    CONSTRAINT fk_customer_address FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- Criação do índice pelo último nome do customer.
CREATE INDEX idx_last_name ON customer(last_name);

-- Criação do "auto-increment" do customer através da sequência e do seu trigger.
CREATE SEQUENCE customer_sequence
START WITH 600;

CREATE OR REPLACE TRIGGER customer_before_insert
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
CREATE OR REPLACE TRIGGER customer_before_update
BEFORE UPDATE ON customer FOR EACH ROW
BEGIN
    :NEW.last_update:=current_date;
END;


-------
-- Parte do Inventory
-- Estrutura para a tabela actor.
CREATE TABLE actor (
    actor_id numeric NOT NULL ,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    last_update DATE NOT NULL,
    CONSTRAINT pk_actor PRIMARY KEY  (actor_id)
);

-- Criação do index adicional pelo último nome do actor.
CREATE INDEX idx_last_name ON actor(last_name);

-- Criação do "auto-increment" do actor através da sequência e do seu trigger.
CREATE SEQUENCE actor_sequence
START WITH 201;

CREATE OR REPLACE TRIGGER actor_before_insert
BEFORE INSERT ON actor FOR EACH ROW
BEGIN
    IF (:NEW.actor_id IS NULL) THEN
        SELECT actor_sequence.nextval INTO :NEW.actor_id
        FROM DUAL;
    END IF;
    -- aproveitar o trigger para adicionar o timestamp em modo ORACLE
    :NEW.last_update:=current_date;
END;

-- Criação do trigger para atualizar o timestamp caso exista um update.
CREATE OR REPLACE TRIGGER actor_before_update
BEFORE UPDATE ON actor FOR EACH ROW
BEGIN
  :NEW.last_update:=current_date;
END;

-- Estrutura para a tabela language
CREATE TABLE language (
    language_id SMALLINT NOT NULL,
    name CHAR(20) NOT NULL,
    last_update DATE NOT NULL,
    CONSTRAINT pk_language PRIMARY KEY (language_id)
);

CREATE SEQUENCE language_sequence
START WITH 7;

-- Criação do "auto-increment" do language através da sequência e do seu trigger.
CREATE OR REPLACE TRIGGER language_before_insert
BEFORE INSERT ON language FOR EACH ROW
BEGIN
    IF (:NEW.language_id IS NULL) THEN
    SELECT language_sequence.nextval INTO :NEW.language_id
    FROM DUAL;
    END IF;
    -- aproveitar o trigger para adicionar o timestamp em modo ORACLE
    :NEW.last_update:=current_date;
END;

-- Criação do trigger para atualizar o timestamp caso exista um update.
CREATE OR REPLACE TRIGGER language_before_update
BEFORE UPDATE ON language FOR EACH ROW
BEGIN
    :NEW.last_update:=current_date;
END;

-- Estrutura da tabela category
CREATE TABLE category (
    category_id SMALLINT NOT NULL,
    name VARCHAR(25) NOT NULL,
    last_update DATE NOT NULL,
    CONSTRAINT pk_category PRIMARY KEY (category_id)
);

CREATE SEQUENCE category_sq;

-- Criação do "auto-increment" do category através da sequência e do seu trigger.
CREATE OR REPLACE TRIGGER category_before_insert
BEFORE INSERT ON category FOR EACH ROW
BEGIN
    IF (:NEW.category_id IS NULL) THEN
        SELECT category_sequence.nextval INTO :NEW.category_id
        FROM DUAL;
    END IF;
    -- aproveitar o trigger para adicionar o timestamp em modo ORACLE
    :NEW.last_update:=current_date;
END;

-- Criação do trigger para atualizar o timestamp caso exista um update.
CREATE OR REPLACE TRIGGER category_before_update
BEFORE UPDATE ON category FOR EACH ROW
BEGIN
    :NEW.last_update:=current_date;
END;

