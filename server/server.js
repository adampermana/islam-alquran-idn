const express = require('express');
const routes = require('./routes/routes');
const cors = require('cors');
const session = require('express-session');

const port = process.env.port || 3000;
const server = express();

server.set('trust proxy', 1);

server.use(cors());
server.use(express.json());
server.use(session({
  secret: 'secret-key',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false }
}));

server.use('/', routes);

server.listen(port, () => {
  console.log('server running at port:', port);
});