/*Este código es el mecanismo de activación y gestión de notificaciones. Cada notificación se
  activa de forma periódica y síncrona. La información de la notificación es consultada en la 
  base de datos de acuerdo con el parámetro ingresado*/

  var CronJob = require('cron').CronJob;
  const app = require('./app.js');
  const Notification = require("./notificacion");
  const noti = require('./userModel');
  const temas = require('./userModelTest')
  const temasuno = require('./unoModel')
  const temasdos = require('./dosModel')
  const temastres = require('./tresModel')
  const temascuatro = require('./cuatroModel')
  const temascinco = require('./cincoModel')
  const temasseis = require('./seisModel')
  const PORT = process.env.PORT || 3128;
  require("./bd");
  
  var titulo;
  var n =0;
  var pasa;
  var tok;
  var Tokens;
  var control=false;
  var coma = ", ";
  var i;
  //Esquema de cronjobs
  /*Cronjobs con cron: CronJob('segundos(op) minuto hora día-mes mes día-semana', acción a ejecutar mientras
    esté activo, acción a ejecutar cuando se detenga);
    asterisco/n-> cada n seg/min/hr
    min/seg->0-59
    hr->0-23
    dia-mes->1-31
    mes->1-12
    dia-semana->0-6*/
  var uno = new CronJob(' */1 * * * *',  async ()=>{
    //Consulta en la colección uno el tema en que se equivocó y lo guarda en documentos
    const documentos = await temasuno.find({tipo: 'notificacion'}).sort({$natural:-1}).limit()
    if(documentos){
        for (i =0; i<documentos.length; i++){
            tok = documentos[i]['token']
            //consulta en la colección notificaciones la información de notificación para el tema actual y lo guarda en notificacion
            const notificacion = await noti.findOne({nombre: documentos[i]['tema']}).sort({$natural: -1}).limit(1)
            enviarNotificacion(notificacion,tok)
        }
        control=false;
        uno.stop() 
    }
    else{
        control=false;
        uno.stop()
    }
    //función que realizará el cronjob después de detenerse, para más información, consultar documentación de librería CronJob de node.js 
    //La decisión que hace es un operador ternario con base en el valor de control
},()=>{control?console.log('ya se detuvo'):crons('dos')});

  var dos = new CronJob(' */2 * * * *',  async ()=>{
    const documentos = await temasdos.find({tipo: 'notificacion'}).sort({$natural:-1}).limit()
    if(documentos){
        for (i =0; i<documentos.length; i++){
            tok = documentos[i]['token']
            const notificacion = await noti.findOne({nombre: documentos[i]['tema']}).sort({$natural: -1}).limit(1)
            enviarNotificacion(notificacion,tok)
        }
        control=false;
        dos.stop()
    }
    else{
        control=false;
        dos.stop()
    }
  },()=>{control?console.log('ya se detuvo'):crons('tres')});

  var tres = new CronJob(' */3 * * * *',  async ()=>{
    const documentos = await temastres.find({tipo: 'notificacion'}).sort({$natural:-1}).limit()
    if(documentos){
        for (i =0; i<documentos.length; i++){
            tok = documentos[i]['token']
            const notificacion = await noti.findOne({nombre: documentos[i]['tema']}).sort({$natural: -1}).limit(1)
            enviarNotificacion(notificacion,tok)
        }
        control=false;
        tres.stop()
    }
    else{
        control=false;
        tres.stop()
    }

  },()=>{control?console.log('ya se detuvo'):crons('cuatro')});

  var cuatro = new CronJob(' */4 * * * *',  async ()=>{
    const documentos = await temascuatro.find({tipo: 'notificacion'}).sort({$natural:-1}).limit()
    if(documentos){
        for (i =0; i<documentos.length; i++){
            tok = documentos[i]['token']
            const notificacion = await noti.findOne({nombre: documentos[i]['tema']}).sort({$natural: -1}).limit(1)
            enviarNotificacion(notificacion,tok)
        }
        control=false;
        cuatro.stop()
    }
    else{
        control=false;
        cuatro.stop()
    }
  },()=>{control?console.log('ya se detuvo'):crons('cinco')});

  var cinco = new CronJob(' */5 * * * *',  async ()=>{
    const documentos = await temascinco.find({tipo: 'notificacion'}).sort({$natural:-1}).limit()
    if(documentos){
        for (i =0; i<documentos.length; i++){
            tok = documentos[i]['token']
            const notificacion = await noti.findOne({nombre: documentos[i]['tema']}).sort({$natural: -1}).limit(1)
            enviarNotificacion(notificacion,tok)
        }
        control=false;
        cinco.stop()
    }
    else{
        control=false;
        cinco.stop()
    }
  },()=>{control?console.log('ya se detuvo'):crons('seis')});

  var seis = new CronJob(' */6 * * * *',  async ()=>{
    const documentos = await temasseis.find({tipo: 'notificacion'}).sort({$natural:-1}).limit()
    if(documentos){
        for (i =0; i<documentos.length; i++){
            tok = documentos[i]['token']
            const notificacion = await noti.findOne({nombre: documentos[i]['temas']}).sort({$natural: -1}).limit(1)
            enviarNotificacion(notificacion,tok)
        }
        control=false;
        seis.stop()
    }
    else{
        control=false;
        seis.stop()
    }
      
  },()=>{control?console.log('ya se detuvo'):crons('uno')});
  
  
  /*Esta función es la que activa todo el mecanismo de notificaciones. Recibe el token de usuario y un
    valor booleano para determinar si se volvió a llamar o sigue ejecutandose en el estado actual*/
  async function iniciarNotificacion(){
        control=true
        todo()
        uno.start();
  }
  exports.iniciarNotificacion =  iniciarNotificacion;

//Método que inicia el cron que se le pasa por parámetro
async function crons(parametro){
    //Si es false significa que no están activas las cron
        switch(parametro){
            case 'uno':
                //El método start inicia el cronjob de la variable uno
                uno.start();
                break;
            case 'dos':
                dos.start();
                break;
            case 'tres':
                tres.start();
                break;
            case 'cuatro':
                cuatro.start();
                break;
            case 'cinco':
                cinco.start();
                break;
            case 'seis':
                seis.start();
                break;
        }
    
}

//Este método detiene todas las cron activas al mismo tiempo
function todo(){
    uno.stop();
    dos.stop();
    tres.stop();
    cuatro.stop();
    cinco.stop();
}
  
  async function enviarNotificacion (titulo, token)  {
      control=false;
      //Construye el formato en el que recibe el FCM y pone cada elemento de titulo en su campo correspondiente
      const data = {
          tokenId: token,                
          titulo: titulo['titulo'],
          mensaje: titulo['mensaje'],
          imagen: titulo['url']
      }
      //Método para hacer la conexión a Firebase Cloud Message y enviar la notificación al dispositivo
      Notification.sendPushToOneUser(data);
              
  }
  
  //Método para convertir un String en un array
  function dividirCadena(cadenaADividir,separador) {
      //Borra los caracteres [ y ]
      var regex1 = cadenaADividir.replace(/\[/g, '');
      var regex = regex1.replace(/\]/g, '');
      /*El método split separa los n caracteres del String para convertirlos en elementos de un Array.
        Los separa con base en separador, que es un caracter o cadena que se debe encontrar dentro del 
        string, que en este caso es ', '*/
      var arrayDeCadenas = regex.split(separador);
      return arrayDeCadenas;
  }
  exports.dividirCadena = dividirCadena;
  app.listen(PORT);   
  