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
let rawdata = fs.readFileSync('customers.json');
let jsoncontent = JSON.parse(rawdata);

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


let rentals = (jsoncontent.rentals)
var rental = rentals.split(",")

rental.forEach(element => {
    let rental1 = element.split("*")
    console.log(rental1[0])
})


});