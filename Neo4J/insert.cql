//Customer
LOAD CSV WITH HEADERS FROM 'file:///customers.csv' AS row
CREATE (c:Customer {idCustomer: row.idCustomer}) 
SET c.FirstName = row.FirstName, 
	c.LastName = row.LastName, 
    c.email = row.Email, 
    c.LastUpdate = row.LastUpdate 
RETURN c;

//Store 
LOAD CSV WITH HEADERS FROM 'file:///stores.csv' AS row
CREATE (s:Store {idStore: row.idStore})
RETURN s;


//Film
LOAD CSV WITH HEADERS FROM 'file:///films.csv' AS row
CREATE (film:Film {idFilm: row.film_id})
SET film.Title = row.Title,
	film.Description = row.Description,
    film.ReleaseYear = row.ReleaseYear, 
    film.RentalDuration = row.RentalDuration,
    film.Language = row.Language,
    film.RentalRate = row.RentalRate, 
    film.Length = row.Length,
    film.ReplacementCost = row.ReplacementCost,
    film.Rating = row.Rating, 
    film.SpecialFeatures = row.SpecialFeatures, 
    film.Category = row.Category
RETURN film;

//City
LOAD CSV WITH HEADERS FROM 'file:///city.csv' AS row
CREATE (c:City {idCity: row.idCity}) 
SET c.City = row.City
RETURN c;


//Address 
LOAD CSV WITH HEADERS FROM 'file:///address.csv' AS row
CREATE (a:Address {idAddress: row.idAddress}) 
SET a.Address = row.Address, 
	a.Address2 = row.Address2, 
    a.District = row.District, 
    a.idCity = row.idCity, 
    a.PostalCode = row.PostalCode, 
    a.Phone = row.Phone
RETURN a;


//PAYMENT
LOAD CSV WITH HEADERS FROM 'file:///payment.csv' AS row
CREATE (p:Payment {idPayment: row.idPayment}) 
SET p.Amount = row.Amount, 
	p.PaymentDate = row.PaymentDate
RETURN p;

//RENTAL
LOAD CSV WITH HEADERS FROM 'file:///rental.csv' AS row
CREATE (r:Rental {idRental: row.idRental}) 
SET r.RentalDate = row.RentalDate, 
	r.ReturnDate = row.ReturnDate
RETURN r;

//Country 
LOAD CSV WITH HEADERS FROM 'file:///country.csv' AS row
CREATE (c:Country {idCountry: row.idCountry}) 
SET c.Country = row.Country
RETURN c;

//CATEGORY
LOAD CSV WITH HEADERS FROM 'file:///category.csv' AS row
CREATE (c:Category {idCategory: row.idCategory}) 
SET c.Name = row.Name 
RETURN c;

//Language
LOAD CSV WITH HEADERS FROM 'file:///language.csv' AS row
CREATE (l:Language {idLanguage: row.idLanguage}) 
SET l.Name = row.Name 
RETURN l;

//Actor 
LOAD CSV WITH HEADERS FROM 'file:///actor.csv' AS row
CREATE (a:Actor {idActor: row.idActor}) 
SET a.FirstName= row.FirstName, 
	a.LastName = row.LastName
RETURN a;

//Inventory 
LOAD CSV WITH HEADERS FROM 'file:///inventory.csv' AS row
CREATE (i:Inventory {idInventory: row.idInventory}) 
RETURN i;


//Staff
LOAD CSV WITH HEADERS FROM 'file:///staff.csv' AS row
CREATE (s:Staff {idStaff: row.idStaff}) 
SET s.FirstName = row.FirstName, 
	s.LastName = row.last_name, 
    s.Email = row.email, 
    s.idAddress = row.idAddress, 
    s.idStore = row.idStore, 
    s.Active = row.Active, 
    s.Username = row.Username, 
    s.Password = row.Password
RETURN s;


//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>RELATIONS<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//
//CITY -> COUNTRY
LOAD CSV WITH HEADERS FROM 'file:///city.csv' AS row
match (c:City {idCity: row.idCity})
match (ctr:Country {idCountry: row.idCountry})

create (c)-[:OF]->(ctr)
RETURN c,ctr;

//ADDRESS -> CITY
LOAD CSV WITH HEADERS FROM 'file:///address.csv' AS row
match (a:Address {idAddress: row.idAddress})
match (c:City {idCity: row.idCity})

create (a)-[:OF]->(c)
RETURN a,c;

//FILM - ACTOR 
LOAD CSV WITH HEADERS FROM 'file:///film_actor.csv' AS row
match (f:Film {idFilm: row.idFilm})
match (a:Actor {idActor: row.idActor})

        // ou create (f)-[:ACTED_BY]->(a) ???
create (a)-[:ACTED_IN]->(f)
RETURN a,f;

//FILM -> CATEGORY
LOAD CSV WITH HEADERS FROM 'file:///film_category.csv' AS row
match (f:Film {idFilm: row.idFilm})
match (c:Category {idCategory: row.idCategory})

create (f)-[:TYPE]->(c)
RETURN f,c;




//>>>>>>>>>>>>>>>>>FILM-CATEGORY>>>>>>>>>

SELECT 
    film.film_id as idFilm, 
    category.category_id AS idCategory
  FROM film
  
  
  INNER JOIN film_category ON film.film_id = film_category.film_id
  INNER JOIN category ON film_category.category_id = category.category_id

  LIMIT 200


//>>>>>>>>>>>>>>>FILM-ACTOR>>>>>>>>>>>>>>>

SELECT 
    film.film_id as idFilm,
    actor.actor_id as idActor
  FROM film
  
  INNER JOIN film_actor ON film.film_id = film_actor.film_id
  INNER JOIN actor ON film_actor.actor_id = actor.actor_id

  LIMIT 200


//-----------------CITY-------------------
SELECT city_id as idCity, city as City, country_id as idCountry from city


//----------------STAFF-------------------
SELECT staff_id as idStaff, first_name as FirstName, last_name as LastName, address_id as idAddress, email as Email, store_id as idStore,
	active as Active, username as Username, password as Password
 from staff


//-------------INVENTORY------------------
SELECT inventory_id as idInventory  from inventory


//--------------ACTOR---------------------
SELECT actor_id as idActor, first_name as FirstName, last_name as LastName from actor

//-------------LANGUAGE-------------------
SELECT language_id as idLanguage, language.name as Name from language

//-------------CATEGORY-------------------
SELECT category_id as idCategory, category.name as Name from category

//-------------COUNTRY--------------------
SELECT country_id as idCountry, country as Country from country

//-------------RENTAL----------------------

SELECT rental_id as idRental, rental_date as RentalDate, return_date as ReturnDate from rental


//-------------Payment---------------------
SELECT 
    payment_id AS idPayment, 
    amount as Amount, 
    payment_date as PaymentDate 
    from payment


//------------------ADDRESSS---------------
SELECT 
    address_id AS idAddress ,
     address.address as Address, 
     address.address2 as Address2, 
     district AS District, 
     postal_code AS PostalCode, 
     phone AS Phone, 
     city.city_id AS idCity 
     from address

inner join city on address.city_id = city.city_id

//-----------------STORE------------------------

SELECT 
	store.store_id AS idStore,
    staff.first_name AS FirstName, 
    staff.last_name AS LastName, 
    manager_staff_id AS idManagerStaff, 
    address AS Address, 
    city AS City, 
    country AS Country, 
    phone AS Phone,
    group_concat(distinct film.film_id, '//', film.title, '//', film.rental_rate) AS Inventory
  FROM  store

  INNER JOIN staff on store.manager_staff_id = staff.staff_id
  INNER JOIN address on staff.address_id = address.address_id
  INNER JOIN city on address.city_id = city.city_id
  INNER JOIN country on city.country_id = country.country_id
  INNER JOIN inventory on store.store_id = inventory.store_id
  INNER JOIN film on inventory.film_id = film.film_id

  GROUP BY store.store_id