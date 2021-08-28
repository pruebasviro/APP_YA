const { Router } = require('express');
const jwt = require('jsonwebtoken');
const router = Router();
const Test = require('./userModelTest');
const User = require('./model')
const Uno = require('./unoModel');
const Dos = require('./dosModel');
const Tres = require('./tresModel');
const Cuatro = require('./cuatroModel');
const Cinco = require('./cincoModel');
const Seis = require('./seisModel');
const GenerateToken = require("./generateToken")
const Notification = require('./cron');
const config = require('./config');

var users = []

GenerateToken.getAccessToken()
    .then((tokenn) => console.log("This token expires in 1 hour: " + tokenn))
    .catch((err) => console.log("Error: ", err))
//Registro
    router.post('/signup', async(req, res) => {
      try {
          // Receiving Data
          let resultado;
          const { username, email, password, nme, lastname, place, years, imei } = req.body;
          //Busca el email en la colección de users
          const valida = await User.findOne({ email: req.body.email })
          if (!valida) {
              
              // Creating a new User
              const user = new User({
                  nme,
                  lastname,
                  place,
                  years,
                  username,
                  email,
                  password,
                  imei
              });
              //Encripta contraseña
              user.password = await user.encryptPassword(password);
              //Guarda en base de datos
              await user.save();
              // Create a Token
              const token = jwt.sign({ id: user.id }, config.secret, {
                  expiresIn: 60 * 60 * 24 // expires in 24 hours
              });
              //Regresa un 400 para indicar que el email no existe y el cliente pueda dirigir a la siguiente pantalla
              res.status(404).send("The email doesn't exists")
          }
          else{
            //El email sí existe
              console.log("USUARIO ENCONTRADO: ", valida);
              res.status(200).json(valida);
          }
      } catch (e) {
          console.log("problema",e)
          res.status(500).send('There was a problem registering your user');
      }
  });
  
  
  
  
  router.post('/signin', async(req, res) => {
      try {
        //Busca el email en user
          const user = await User.findOne({ email: req.body.email })
          if (!user) {
            //Si el email no existe
              return res.status(404).send("The email doesn't exists")
          }
          //Valida la contraseña recibida con la contraseña guardada en user
          const validPassword = await user.validatePassword(req.body.password, user.password);
          //Valida que el imei recibido sea el mismo que el imei en user
          const validImei = await User.findOne({ imei: req.body.imei});
          //Si no son el mismo, no permite la autenticacion
          if (!validPassword && !validImei) {
              return res.status(401).send({ auth: false, token: null });
          }
          //Si si, genera un token que no es el de firebase y regresa un 200 para indicar que se autenticó
          const token = jwt.sign({ id: user._id }, config.secret, {
              expiresIn: '24h'
          });
          console.log('imei registrado:', req.body.imei,' imei ingresado:',user.imei, 'validimei',validImei,'pass:', validPassword);
          res.status(200).json({ auth: true, token });
      } catch (e) {
          console.log(e)
          res.status(500).send('There was a problem signin');
      }
  });
  
/*Este código contiene el endpoint que activará el mecanismo de notificaciones
  programadas con cron jobs. */
router.post('/result', async(req, res) => {
  //Para hacer el mecanismo de gestión se necesita tener una colección para cada tema. Clasifico esos temas a través de las siguientes regex 
        const regEx1 = new RegExp('Tema[0-9]*0$|Tema[0-9]*6$','g')//Para los temas que terminen en 0 y en 6
        const regEx2 = new RegExp('Tema[0-9]*1$|Tema[0-9]*7$','g')//Para los temas que terminen en 1 y en 7
        const regEx3 = new RegExp('Tema[0-9]*2$|Tema[0-9]*8$','g')//Para los temas que terminen en 2 y en 8
        const regEx4 = new RegExp('Tema[0-9]*3$|Tema[0-9]*9$','g')//Para los temas que terminen en 3 y en 9
        const regEx5 = new RegExp('Tema[0-9]*4$','g')//Para los temas que terminen en 4 
        const regEx6 = new RegExp('Tema[0-9]*5$','g')//Para los temas que terminen en 5 
            // Creating a new User
    try{
        const { usr, temas, token} = req.body; 
        var tipo = 'notificacion';
        var array = Notification.dividirCadena(temas,", ")
        //Hace un for para recorrer todos los temas que llegaron y clasificarlos en su respectiva colección de acuerdo con la regex 
        for (i=0;i<array.length;i++){
          if(regEx1.test(array[i])){
            console.log('sí coincide 1')
            //Guarda el tema actual en la variable tema
            var tema = array[i]
            const user = new Uno({
              usr,
              tema,
              token,
              tipo
            });
            //Guarda en base de datos
            await user.save();
          }
          else if(regEx2.test(array[i])){
            var tema = array[i]
            console.log('sí coincide 2')
            const user = new Dos({
              usr,
              tema,
              token,
              tipo
            });
            await user.save();
          }
          else if(regEx3.test(array[i])){
            var tema = array[i]
            console.log('sí coincide 3')
            const user = new Tres({
              usr,
              tema,
              token,
              tipo
            });
            await user.save();
          }
          else if(regEx4.test(array[i])){
            var tema = array[i]
            console.log('sí coincide 4')
            const user = new Cuatro({
              usr,
              tema,
              token,
              tipo
            });
            await user.save();
          }
          else if(regEx5.test(array[i])){
            var tema = array[i]
            console.log('sí coincide 5')
            const user = new Cinco({
              usr,
              tema,
              token,
              tipo
            });
            await user.save();
          }
          else if(regEx6.test(array[i])){
            var tema = array[i]
            console.log('sí coincide 6')
            const user = new Seis({
              usr,
              tema,
              token,
              tipo
            });
            await user.save();
          }
          else {
            console.log("Algo falla, ninguno coincide")
          }
        }
        //Activa sistema de notificaciones
          await Notification.iniciarNotificacion()
          console.log('me iniciarion');
          res.status(200).json(usr);
      }
      catch (e) {
        console.log("problema",e)
        res.status(500).send('There was a problem registering your user');
    }
});

module.exports = router;