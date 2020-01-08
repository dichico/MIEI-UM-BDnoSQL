var MongoClient = require("mongodb").MongoClient;
var url = "mongodb://localhost:27017/SAKILA";

const fs = require("fs")

MongoClient.connect(url, function(err, db) {
  
  if (err) throw err;
  var dbo = db.db("SAKILA");
    
  console.log("Data Costumers.\n")

  let dataCostumers = fs.readFileSync('customers.json');
  let dataJSONCostumers = JSON.parse(dataCostumers);

  dataJSONCostumers.forEach(element => {
    let idCostumer = (element.idCostumer)
    let FirstName = (element.FirstName)
    let LastName = (element.LastName)
    let Email = (element.Email)
    let Address = (element.Address)
    let City = (element.City)
    let District = (element.District)
    let Country = (element.Country)
    let PostalCode = (element.PostalCode)
    let Phone = (element.Phone)
    let LastUpdate = (element.LastUpdate)
    let idStaff = (element.idStaff)

    var dadosCostumers = { 
      "ID Costumer": idCostumer , 
      "First Name" : FirstName, 
      "Last Name": LastName, 
      "Email": Email,
      "Address": Address, 
      "City": City , 
      "District": District,  
      "Country": Country,
      "Postal Code": PostalCode, 
      "Phone": Phone, 
      "Last Update": LastUpdate, 
      "Rentals": [], 
      "ID Staff": idStaff
    };

    dbo.collection("customers").insertOne(dadosCostumers, function(err, res) {
      if (err) throw err;
      console.log("Customer Inserido.");
      db.close();
    });

  })

  dataJSONCostumers.forEach(element => {
    let idCostumer = (element.idCostumer)
    
    let rentals = (element.Rentals)
    var rental = rentals.split(",")

    for(var i = 0; i < rental.length; i++) {

      let infosRental = rental[i].split("//");

      dbo.collection("customers").updateOne({"ID Costumer": idCostumer}, {$push : {Rentals: {$each : [{
        "ID Rental": infosRental[0] , 
        "Rental Date": infosRental[1], 
        "Return Date": infosRental[2], 
        "Film Title": infosRental[3], 
        "ID Film": infosRental[4], 
        "Payments": []
      }]}}}, function(err, res) {
        if (err) throw err;
        console.log("Rental Inserido.");
        db.close();
      });

    }

/*     for(var j = 0; j < rental.length; j++ ){
      let rental1 = rental[j].split("//")

      console.log("RENTAL 0 - " + rental1[0])
      console.log("RENTAL 1 - " + rental1[1])
      console.log("RENTAL 2 - " + rental1[2] + "\n")

  
      let payments = (element.Payments)
      var payment = payments.split(",")

      console.log("PAGAMENTO 0 - " + payment[0])
      console.log("PAGAMENTO 1 - " + payment[1])

      for(var j = 0; j < payment.length; j++ ){
        let payment1 = payment[j].split("//")
        dbo.collection("customers").updateOne({"ID Costumer": customer_id}, {$push: {Rentals: {$each: [
          {"Rental id": rental1[0] , "Rental date": rental1[1], "Return date": rental1[2] , "Film title": rental1[3], 
          "Film id": rental1[4], Payments : [{"id": payment1[0], "Amount": payment1[1], "Date":payment1[2]}]
          }]}}}, function(err, res) {
          if (err) throw err;
          //console.log("Rental inserido");
          db.close();
        });
      }
    } */
  })

  console.log("Data Films.\n")

  let dataFilms = fs.readFileSync('films.json');
  let dataJSONFilms = JSON.parse(dataFilms);

  dataJSONFilms.forEach(element => {
    let idFilm = (element.film_id)
    let Title = (element.Title)
    let Description = (element.Description)
    let ReleaseYear = (element.ReleaseYear)
    let Language = (element.Language)
    let RentalDuration = (element.RentalDuration)
    let RentalRate = (element.RentalRate)
    let Rating = (element.Rating)
    let Length = (element.Length)
    let ReplacementCost = (element.ReplacementCost)
    let SpecialFeatures = (element.SpecialFeatures)
    let Category = (element.Category)

    var dadosFilms = { 
      "ID Film": idFilm, 
      "Title": Title,
      "Description": Description,
      "Release year": ReleaseYear,
      "Language": Language,
      "Rental Duration": RentalDuration,
      "Rental Rate": RentalRate,
      "Rating": Rating,
      "Length": Length,
      "Replacement Cost": ReplacementCost, 
      "Special Features": SpecialFeatures,
      "Category": Category,
      "Actors": []
    };

    dbo.collection("films").insertOne(dadosFilms, function(err, res) {
      if (err) throw err;
      console.log("Filme Inserido.");
      db.close();
    });

  })

  dataJSONFilms.forEach(element => {
    let idFilm = (element.film_id);
    
    let actors = (element.Actors);
    var actor = actors.split(",");

    for(var i = 0; i < actor.length; i++) {

      let infosActor = actor[i].split("//");

      dbo.collection("films").update({"ID Film" : idFilm}, {$push: {Actors: {$each: [{
        "ID Actor": infosActor[0],
        "First Name": infosActor[1],
        "Last Name": infosActor[2]
      }]}}}, function(err, res) {
        if (err) throw err;
        console.log("Actor Inserido.");
        db.close();
      });

    }
  })

  console.log("Dados Stores.\n")

  let dataStores = fs.readFileSync('stores.json');
  let dataJSONStores = JSON.parse(dataStores);

  dataJSONStores.forEach(element => {
    let FirstName = (element.FirstName)
    let LastName = (element.LastName)
    let idManagerStaff = (element.idManagerStaff)
    let Address = (element.Address)
    let City = (element.City)
    let Country = (element.Country)
    let PostalCode = (element.PostalCode)
    let Phone = (element.Phone)

    var dadosStores = { 
      "Manager First Name": FirstName,
      "Manager Last Name": LastName,
      "ID Manager": idManagerStaff, 
      "Address": Address, 
      "City": City,  
      "Country": Country,
      "Phone": Phone, 
      "Inventory": []
    };
    dbo.collection("stores").insertOne(dadosStores, function(err, res) {
      if (err) throw err;
      console.log("Store Inserida.");
      db.close();
    });

  })

  dataJSONStores.forEach(element => {
    let FirstName = (element.FirstName);
    let LastName = (element.LastName);
    
    let inventorys = (element.Inventory);
    var inventory = inventorys.split(",");

    for(var j = 0; j < inventory.length; j++) {

      let infosInventory = inventory[j].split("//");

      dbo.collection("stores").updateOne({"Manager First Name": FirstName}, {$push: {Inventory: {$each: [{
        "ID Film": infosInventory[0],
        "Title": infosInventory[1], 
        "Rental Rate": infosInventory[2]
      }]}}}, function(err, res) {
        if (err) throw err;
        console.log("Inventory Inserido.");
        db.close();
      });

    }
  })
  
});