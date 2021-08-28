const { Schema, model } = require('mongoose');


const TestSchema = new Schema({
    usr: String,
    username: String,
    temas: String,
    token: String,
    tipo: String
});
module.exports = model('test', TestSchema)