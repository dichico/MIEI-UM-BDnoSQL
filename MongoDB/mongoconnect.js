var MongoClient = require('mongodb').MongoClient
var url = "mongodb://localhost:27017/Sakila"
const fs = require('fs')

MongoClient.connect(url, function(err, db) {
    /*
  if (err) throw err;
  var dbo = db.db("Sakila");
  var myobj = { name: "AAA"};
  dbo.collection("customers").insertOne(myobj, function(err, res) {
    if (err) throw err;
    console.log("1 document inserted");
    db.close();
  });
  */
let rawdataCust = fs.readFileSync('customers.json');
let jsoncontent = JSON.parse(rawdataCust);

jsoncontent.forEach(element => {
  let customer_id = (element.customer_id)
  let first_name = (element.first_name)
  let last_name = (element.last_name)
  let email = (element.email)
  let address = (element.address)
  let city = (element.city)
  let district = (element.district)
  let country = (element.country)
  let postal_code = (element.postal_code)
  let phone = (element.phone)
  let last_update = (element.last_update)
  console.log(customer_id +"..."+ first_name)

  console.log("-------------------------RENTAL-----------------------\n")

  let rentals = (element.rentals)
  var rental = rentals.split(",")
  
  rental.forEach(element => {
      let rental1 = element.split("*")
      console.log(rental1[0])
      console.log(rental1[1])
      console.log(rental1[2])
      console.log(rental1[3])
      console.log(rental1[4])

  })

  console.log("-------------------------PAYMENTS-----------------------\n")

  let payments = (element.payments)
  var payment = payments.split(",")

  payment.forEach(element => {
    let payment1 = element.split("*")
    console.log(payment1[0])
  })


})


console.log("*********************FILMES***********************\n")



let rawdataFi = fs.readFileSync('films.json');
let contentfilm = JSON.parse(rawdataFi);

contentfilm.forEach(element => {
let film_id = (element.film_id)
console.log(film_id)

})


console.log("*********************STORES***********************\n")



let rawdataSt = fs.readFileSync('Store.json');
let contentstore = JSON.parse(rawdataSt);

contentstore.forEach(element => {
let first_name = (element.first_name)
console.log(first_name)

})


/*


let customer_id = (jsoncontent.customer_id)
let first_name = (jsoncontent.first_name)
let last_name = (jsoncontent.last_name)
let email = (jsoncontent.email)
let address = (jsoncontent.address)
let city = (jsoncontent.city)
let district = (jsoncontent.district)
let country = (jsoncontent.country)
let postal_code = (jsoncontent.postal_code)
let phone = (jsoncontent.phone)
let last_update = (jsoncontent.last_update)


//-----------------------------Rentals-----------------------------//
let rentals = (jsoncontent.rentals)
var rental = rentals.split(",")

rental.forEach(element => {
    let rental1 = element.split("*")
    console.log(rental1[0])
})
//-----------------------------Rentals-----------------------------//

//-----------------------------Payments-----------------------------//

let payments = (jsoncontent.payments)
var payment = payments.split(",")

payment.forEach(element => {
  let payment1 = element.split("*")
  console.log(payment1[0])
})

//-----------------------------Payments-----------------------------//

let rawdataFi = fs.readFileSync('films.json');
let contentfilm = JSON.parse(rawdataFi);

let film_id = (contentfilm.film_id)

console.log(film_id)
*/

});