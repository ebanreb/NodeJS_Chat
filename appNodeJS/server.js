#!/bin/env node
var express = require('express')
  , app = express()
  , http = require('http')
  , server = http.createServer(app)
  , io = require('socket.io').listen(server);

//server.listen(6969);
server.listen(process.env.OPENSHIFT_NODEJS_PORT || 8080, process.env.OPENSHIFT_NODEJS_IP);

usersObj = {};
usersCont = {};

io.sockets.on('connection', function (socket) {
    
    // when the client emits 'adduser', this listens and executes
    socket.on('adduser', function(username){
        // store the username in the socket session for this client
        socket.username = username;
        // store the room name in the socket session for this client
        // socket.room = username;
        // send client to room 1
        // socket.join(username);
        
        if ( username in usersObj ){ // if user is in usersObj, save it's new socket.id

            usersObj[username].sockets_ids.push( socket.id );

            // how to send a message to all sockets of a specific user
            // usersObj[data.id].sockets.socket.emit( "hi", { data: "Hi!" } ); this does not work.

        } else { // if user is not in usersObj, make a new object and save it's socket.

            //usersObj[username] = socket.id; // array for all sockets id of this user
            usersObj[username] = {
                "sockets_ids" : [ socket.id ] // array for all sockets id of this user
            }
 
        }

    });
    
    // when the client emits 'sendsolicitud', this listens and executes
    socket.on('sendsolicitud', function (data) {
        // we tell the client to execute 'updatechat' with 2 parameters
        //io.sockets.in(data).emit('updatesolicitudes', socket.username);
        usersObj[data].sockets_ids.forEach(function(id){
            io.sockets.socket(id).emit('updatesolicitudes', socket.username);
        });
        //io.sockets.socket(usersObj[data]).emit('updatesolicitudes', socket.username)
    });

    // when the client emits 'sendsolicitud', this listens and executes
    socket.on('sendmensaje', function (remite, destino, contenido) {
        // we tell the client to execute 'updatechat' with 2 parameters
        //io.sockets.in(data).emit('updatesolicitudes', socket.username);
        usersObj[destino].sockets_ids.forEach(function(id){
            io.sockets.socket(id).emit('updatechat', remite, contenido);
        });
        //io.sockets.socket(usersObj[destino]).emit('updatechat', remite, contenido)
    });
    
    socket.on('siConectado', function(username, listaContactos){
        for(var i in listaContactos){
    
          if ( listaContactos[i].uuid in usersObj ){
             usersObj[username].sockets_ids.forEach(function(id){
                io.sockets.socket(id).emit('ledUpdate', listaContactos[i].uuid, 1);
             });
             usersObj[listaContactos[i].uuid].sockets_ids.forEach(function(id){
                io.sockets.socket(id).emit('ledUpdate', username, 1);
                if ( username in usersCont ){

                   usersCont[username].contacts_ids.push( id );

                } else { 

                    usersCont[username] = {
                        "contacts_ids" : [ id ] 
                    }
         
                }
             });
          }//Fin if

       }//Fin for

    });

    socket.on('siDesconectado', function(username){
        if ( username in usersCont ){
            usersCont[username].contacts_ids.forEach(function(id){
                io.sockets.socket(id).emit('ledUpdate', username, 0);
            });
            delete usersCont[username];
        }else{console.log('no esta');}
        delete usersObj[username];
    });

    socket.on('siBaja', function(username){
        if ( username in usersCont ){
            usersCont[username].contacts_ids.forEach(function(id){
                io.sockets.socket(id).emit('contactsUpdate', username, 0);
            });
            delete usersCont[username];
        }else{console.log('no esta');}
        delete usersObj[username];
    });

    // when the user disconnects.. perform this
    socket.on('disconnect', function(){
        if ( socket.username in usersCont ){
            usersCont[socket.username].contacts_ids.forEach(function(id){
                io.sockets.socket(id).emit('ledUpdate', socket.username, 0);
            });
            delete usersCont[socket.username];
        }else{console.log('no esta');}
        delete usersObj[socket.username];
        //socket.leave(socket.room);
    });

});