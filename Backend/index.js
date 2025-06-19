const express = require('express');
const path = require('path');
require('dotenv').config();

// Express
const app = express();

// Node Server
const server = require('http').createServer(app);
module.exports.io = require('socket.io')(server);

require('./sockets/socket');

const port = process.env.PORT || 3000;

const publicPath = path.resolve(__dirname, 'public');

app.use(express.static(publicPath));

server.listen(port, (err) => {
    if (err) throw new Error(err);
    console.log(`Servidor corriendo en puerto ${port}`);  
})