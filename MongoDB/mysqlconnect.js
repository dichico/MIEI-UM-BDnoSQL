var mysql = require('mysql');
var fs = require('fs')

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "Uminho27!",
  database: "sakila"
});

const queryC = `   
select customer.customer_id, customer.first_name, customer.last_name, customer.email, address, city, district, country, postal_code, phone, 
customer.last_update, group_concat(distinct rental.rental_id, '*', rental_date, '*', return_date, '*', film.title, '*', film.film_id) AS rentals,
group_concat(distinct payment_id, '*', amount, '*', payment_date) AS payments
from customer
inner join address on customer.address_id = address.address_id
inner join city on address.city_id = city.city_id
inner join country on city.country_id = country.country_id
inner join rental on customer.customer_id = rental.customer_id
inner join inventory on rental.inventory_id = inventory.inventory_id
inner join film on inventory.film_id = film.film_id
inner join payment on customer.customer_id = payment.customer_id
inner join store on customer.store_id = store.store_id
inner join staff on store.store_id = staff.store_id
Group by customer.customer_id
limit 2`;

const queryF = `
  select film.film_id, title, description, release_year, language.name AS Language, rental_duration, rental_rate, rating,
  length, replacement_cost, special_features, category.name AS Category, 
  group_concat(distinct actor.actor_id,'*', actor.first_name, '*', actor.last_name ) AS actors from film
  inner join film_actor on film.film_id = film_actor.film_id
  inner join actor on film_actor.actor_id = actor.actor_id
  inner join language on film.language_id = language.language_id
  inner join film_category on film.film_id = film_category.film_id
  inner join category on film_category.category_id = category.category_id
  GROUP by film_id
  limit 2`;

const queryS = `
  select staff.first_name , staff.last_name, manager_staff_id, address, city, country, postal_code, phone,
  (group_concat(distinct film.film_id, '*', film.title, '*', film.rental_rate)) AS inventory
  from  store 
  inner join staff on store.manager_staff_id = staff.staff_id
  inner join address on store.address_id = address.address_id
  inner join city on address.city_id = city.city_id
  inner join country on city.country_id = country.country_id
  inner join inventory on store.store_id = inventory.store_id
  inner join film on inventory.film_id = film.film_id
  Group by store.store_id`;

con.connect(function(err) {
  
    if (err) throw err;
  con.query(queryC, function (err, result, fields) {
    if (err) throw err;
    console.log(result);

    fs.writeFile('customers.json', JSON.stringify(result), function (err) {
        if (err) throw err;
        console.log('Saved JSON CUSTOMERS!');
      });
  });

  con.query(queryF, function (err, result, fields) {
    if (err) throw err;
    console.log(result);

    fs.writeFile('films.json', JSON.stringify(result), function (err) {
        if (err) throw err;
        console.log('Saved JSON FILMS!');
      });
  });

  con.query(queryS, function (err, result, fields) {
    if (err) throw err;
    console.log(result);

    fs.writeFile('Store.json', JSON.stringify(result), function (err) {
        if (err) throw err;
        console.log('Saved JSON STORE!');
      });
  });

  con.end();
  
});