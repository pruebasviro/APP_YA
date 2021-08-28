const { Schema, model } = require('mongoose');


const TestSchema = new Schema({
    usr: String,
    tema: String,
    token: String,
    tipo: String
});
module.exports = model('cuatro', TestSchema)