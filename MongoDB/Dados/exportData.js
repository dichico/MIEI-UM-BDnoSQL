var mysql = require("mysql");
var fs = require("fs");

// Dados da Conexão em si.
var connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "root",
  database: "sakila"
});

// Query para retirar a Informações dos Costumers (Clientes).
const queryCostumers = `   
  SELECT  
    customer.customer_id AS idCostumer, 
    customer.first_name AS FirstName, 
    customer.last_name As LastName,
    customer.email AS Email, 
    address AS Address, 
    city AS City, 
    district AS District, 
    country AS Country, 
    postal_code AS PostalCode, 
    phone AS Phone, 
    customer.last_update AS LastUpdate, 
    group_concat(distinct rental.rental_id, '//', rental_date, '//', return_date, '//', film.title, '//', film.film_id) AS Rentals,
    group_concat(distinct payment.rental_id, '//', payment_id, '//', amount, '//', payment_date) AS Payments, 
    staff.staff_id AS idStaff
  FROM customer

  INNER JOIN address ON customer.address_id = address.address_id
  INNER JOIN city ON address.city_id = city.city_id
  INNER JOIN country ON city.country_id = country.country_id
  INNER JOIN rental ON customer.customer_id = rental.customer_id
  INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
  INNER JOIN film ON inventory.film_id = film.film_id
  INNER JOIN payment ON customer.customer_id = payment.customer_id
  INNER JOIN store ON customer.store_id = store.store_id
  INNER JOIN staff ON store.store_id = staff.store_id

  GROUP BY customer.customer_id
  LIMIT 200
`;

// Query para retirar a informação dos Films (Filmes).
const queryFilms = `
  SELECT 
    film.film_id, 
    title AS Title, 
    description AS Description, 
    release_year AS ReleaseYear, 
    language.name AS Language, 
    rental_duration AS RentalDuration, 
    rental_rate AS RentalRate, 
    rating AS Rating,
    length AS Length, 
    replacement_cost AS ReplacementCost, 
    special_features AS SpecialFeatures, 
    category.name AS Category, 
    group_concat(distinct actor.actor_id,'//', actor.first_name, '//', actor.last_name) AS Actors 
  FROM film
  
  INNER JOIN film_actor ON film.film_id = film_actor.film_id
  INNER JOIN actor ON film_actor.actor_id = actor.actor_id
  INNER JOIN language ON film.language_id = language.language_id
  INNER JOIN film_category ON film.film_id = film_category.film_id
  INNER JOIN category ON film_category.category_id = category.category_id

  GROUP BY film_id
  LIMIT 200
`;

// Query para retirar a informação das Stores (lojas).
const queryStores = `
  SELECT 
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
`;

// Conexão e escrita dos dados no ficheiro JSON.
connection.connect(function(err) {
  
  if (err) throw err;
  
  connection.query(queryCostumers, function (err, result, fields) {
    
    if (err) throw err;
    //console.log(result);

    fs.writeFile("customers.json", JSON.stringify(result), function (err) {
        if (err) throw err;
        console.log("Ficheiros JSON dos Clientes salvo.");
      });
  });

  connection.query(queryFilms, function (err, result, fields) {
    
    if (err) throw err;
    //console.log(result);

    fs.writeFile("films.json", JSON.stringify(result), function (err) {
        if (err) throw err;
        console.log("Ficheiros JSON dos Filmes salvo.");
      });
  });

  connection.query(queryStores, function (err, result, fields) {
    
    if (err) throw err;
    //console.log(result);

    fs.writeFile("stores.json", JSON.stringify(result), function (err) {
        if (err) throw err;
        console.log("Ficheiros JSON das Lojas salvo.");
      });
  });

  connection.end();
});