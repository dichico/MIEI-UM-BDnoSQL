# SAKILA Database Queries

## Lista de Queries a ser testada para cada modelo de Base de Dados.

1. Nome e Sobrenome de todos os Atores existentes.

```mysql
SELECT 
	first_name AS FirstName,
    last_name AS LastName
FROM actor
```

```sql
db.getCollection('customers').find(
    {}, 
    {
    	"_id": 0, 
    	"First Name": 1, 
    	"Last Name": 1
    }
);
```

```sql
MATCH (actor:Actor)
RETURN actor.FirstName, actor.LastName
```

2. Lista dos Títulos dos Filme e respetivo Número de Atores que dele fazem parte.

```sql
SELECT 
	film.title AS Title, 
	count(*) AS NumberActors
FROM film

INNER JOIN film_actor ON film.film_id = film_actor.film_id

GROUP BY film.title
ORDER BY NumberActors DESC;
```

```sql
db.getCollection("films").aggregate(
    [
        { 
            "$project" : { 
                "_id" : 0.0, 
                "Title" : 1.0, 
                "NumberActors" : {"$size" : "$Actors"}
            }
        }
    ]
);
```

```sql
MATCH (actor:Actor)-[:ATUA_EM]->(film:Film)
RETURN film.Title AS Title, count(actor) AS NumberActors
```

3. Lista dos Nomes (Primeiro e Último)  dos Atores que aparecem no Filme African Egg.

```mysql
SELECT 
	first_name AS FirstName,
    last_name AS LastName
FROM actor

INNER JOIN film_actor ON film_actor.actor_id = actor.actor_id
INNER JOIN film ON film.film_id = film_actor.film_id

WHERE film.title = "African Egg"
```

```sql
db.getCollection("films").find(
    {"Title" : "AFRICAN EGG"}, 
    { 
        "_id" : 0,
        "Actors.First Name" : 1, 
        "Actors.Last Name" : 1
    }
);
```

```sql
MATCH (actor:Actor)-[:ATUA_EM]->(film:Film)
WHERE film.Title = "AFRICAN EGG"
RETURN actor.FirstName, actor.LastName
```

4. Lista dos Nomes (Primeiro e Último) e Email dos Clientes originais da Argentina. 

```mysql
SELECT 
	customer.first_name AS FirstName, 
    customer.last_name AS LastName, 
    customer.email AS Email
FROM customer

INNER JOIN address ON customer.address_id = address.address_id
INNER JOIN city ON address.city_id = city.city_id
INNER JOIN country ON city.country_id = country.country_id

WHERE country.country = 'Argentina';
```

```sql
db.getCollection("customers").find(
    {"Country" : "Argentina"}, 
    { 
        "First Name" : 1, 
        "Last Name" : 1, 
        "Email" : 1
    }
);
```

```sql
MATCH (customer:Customer)-[:VIVE_EM]->(address:Address)
WHERE address.Country = "Argentina"
RETURN customer.FirstName, customer.LastName, customer.Email
```

Ao fazermos esta querie percebemos que ao colocar no Address logo o Country e a Cidade, simplificamos logo o processo em si, poupando o número de nodos.

5. Lista dos 5 primeiros Géneros/Categorias e sua respetiva Receita Bruta, por ordem descendente.

```mysql
SELECT category.name AS Category, sum(payment.amount) AS TotalVendas
FROM category

INNER JOIN film_category ON category.category_id = film_category.category_id
INNER JOIN film ON film_category.film_id = film.film_id
INNER JOIN inventory ON film.film_id = inventory.film_id
INNER JOIN rental ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment ON rental.rental_id = payment.rental_id

GROUP BY category.name
ORDER BY TotalVendas desc
limit 5;
```

```sql

```

