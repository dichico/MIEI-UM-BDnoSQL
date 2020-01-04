var MongoClient = require('mongodb').MongoClient
var url = "mongodb://localhost:27017/Sakila"
const fs = require('fs')

MongoClient.connect(url, function(err, db) {
  
  if (err) throw err;
  var dbo = db.db("Sakila");
    
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
  let staff_id = (element.staff_id)
  console.log(customer_id +"..."+ first_name +  " - " + staff_id)

  var myo = { "_id": customer_id , "First name" : first_name, "Last Name": last_name, "Email": email,
   "Address": address, "City": city , "District": district,  "Country": country,
    "Postal Code": postal_code, "Phone": phone, "Last Update": last_update, Rentals: [], "Staff Id": staff_id
  };
  dbo.collection("customers").insertOne(myo, function(err, res) {
    if (err) throw err;
    console.log("Customer inserido");
    db.close();
  });

})


//-------------------------RENTAL-----------------------//

jsoncontent.forEach(element => {
  let customer_id = (element.customer_id)
  
  let rentals = (element.rentals)
  var rental = rentals.split(",")
  for(var j = 0; j < rental.length; j++ ){
    let rental1 = rental[j].split("*")

    dbo.collection("customers").update( {"_id" : customer_id}, {$push: {Rentals: {$each: [
      {"_id": rental1[0] , "Rental date": rental1[1], "Return date": rental1[2] , "Film title": rental1[3], 
       "Film id": rental1[4], Payment : []
      }]}}}, function(err, res) {
      if (err) throw err;
      console.log("Rental inserido");
      db.close();
    });
  }
  })

console.log("-------------------------PAYMENTS-----------------------\n")
/*
let payments = (element.payments)
var payment = payments.split(",")

payment.forEach(element => {
  let payment1 = element.split("*")
  console.log(payment1[0])
  console.log(payment1[1])
  console.log(payment1[2])
  
})
*/


console.log("*********************FILMES***********************\n")



let rawdataFi = fs.readFileSync('films.json');
let contentfilm = JSON.parse(rawdataFi);

contentfilm.forEach(element => {
let film_id = (element.film_id)
let film_title = (element.title)
let film_desc = (element.description)
let release_year = (element.release_year)
let language = (element.Language)
let rental_dur = (element.rental_duration)
let rental_rate = (element.rental_rate)
let rating = (element.rating)
let length = (element.length)
let replac_cost = (element.replacement_cost)
let special_feat = (element.special_features)
let category = (element.Category)

var myob = { "_id": film_id , "Title" : film_title,
   "Description": film_desc, "Release year" : release_year, "Language": language,  "Rental Duration": rental_dur,
    "Rental Rate": rental_rate, "Rating": rating, "Length": length, "Replacement Cost": replac_cost, 
    "Special Features": special_feat, "Category": category , Actors: []
  };
  dbo.collection("films").insertOne(myob, function(err, res) {
    if (err) throw err;
    console.log("Filme inserido");
    db.close();
  });



})

contentfilm.forEach(element => {
  let film_id = (element.film_id)
  
  let actors = (element.actors)
  var actor = actors.split(",")
  for(var j = 0; j < actor.length; j++ ){
    let actor1 = actor[j].split("*")

    dbo.collection("films").update( {"_id" : film_id}, {$push: {Actors: {$each: [{"id": actor1[0] , "First Name": actor1[1], "Last Name": actor1[2]}]}}}, function(err, res) {
      if (err) throw err;
      console.log("Actor inserido");
      db.close();
    });
  }
  })

console.log("*********************STORES***********************\n")



  
//--------------------------INSERÇAO DA STORE--------------------------//

  
let rawdataSt = fs.readFileSync('Store.json');
let contentstore = JSON.parse(rawdataSt);

contentstore.forEach(element => {
  let first_name = (element.first_name)
  let last_name = (element.last_name)
  let manager_staff_id = (element.manager_staff_id)
  let address = (element.address)
  let city = (element.city)
  let country = (element.country)
  let postal_code = (element.postal_code)
  let phone = (element.phone)


  var myobj = { "Manager First Name": first_name , "Manager Last Name" : last_name,
   "Manager Id": manager_staff_id, "Address" : address, "City": city,  "Country": country,
    "Postal Code": postal_code, "Phone": phone, Inventory: []
  };
  dbo.collection("stores").insertOne(myobj, function(err, res) {
    if (err) throw err;
    console.log("1 document inserted");
    db.close();
  });

})

//--------------------------INSERÇAO DO INVENTORY--------------------------//
  contentstore.forEach(element => {
  let first_name = (element.first_name)
  let last_name = (element.last_name)
  
  let inventorys = (element.inventory)
  var inventory = inventorys.split(",")
  for(var j = 0; j < inventory.length; j++ ){
    let inventory1 = inventory[j].split("*")

    dbo.collection("stores").update( {"Manager First Name" : first_name}, {$push: {Inventory: {$each: [{"id": inventory1[0] , "Film Id": inventory1[1], "Film Title": inventory1[2]}]}}}, function(err, res) {
      if (err) throw err;
      console.log("1 document inserted");
      db.close();
    });
  }
  })


});