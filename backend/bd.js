const mongoose = require('mongoose')
//Aquí se hace la conexión a la base de datos
mongoose.connect('url_bd', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true
}).then(db => console.log('Connection established successfully'))