const { Schema, model } = require('mongoose');

const notificacioneSchema = new Schema({
    nombre: String,
    titulo: String,
    mensaje: String,
    url: String,
});
module.exports = model('notificaciones', notificacioneSchema)