const mongoose = require('mongoose')

var filmSchema = new mongoose.Schema({
        _id: String,
        Title: String,
        Description: String,
        Release_Year: Date(),
        Original_Language: String,
        Language: String,
        Rental_Duration: Number,
        Rental_Rate: Number,
        Rating: String,
        Length: Number,
        Replacement_Cost: Number,
        Special_Features: String,
        Category: String,
        Actors:[
            {
                id: String,
                First_Name: String,
                Last_Name: String
            }
        ]

})

module.exports = mongoose.model('film', filmSchema)
