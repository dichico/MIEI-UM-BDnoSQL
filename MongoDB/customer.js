const mongoose = require('mongoose')

var customerSchema = new mongoose.Schema({
    _id: Number,
    First_Name: String,
    Last_Name: String,
    Email: String,
    Address: String,
    City: String,
    District: String,
    Country: String,
    Postal_Code: String,
    Phone: Number,
    Last_Update: Date(), 
    Rentals: [
        {
            _id: Number,
            Rental_Date: Date(),
            Return_Date: Date(),
            Film_Title: String,
            Film_Id: Number,
            Payments: [
                {
                    Id: Number,
                    Amount: Float,
                    Date: Date() 
                }
            ],
            Staff_Id: Number
        }
    ]
})

customerSchema.virtual('customer_id').get(function() {
    return this._id;
});

module.exports = mongoose.model('customer', customerSchema)
