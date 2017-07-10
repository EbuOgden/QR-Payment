import express from 'express'
import logger from 'morgan';
import bodyParser from 'body-parser';
import server from 'http';
import http from 'http';
import compression from 'compression';
import path from 'path';

import { productController } from './controllers/ProductController';
import { homeController } from './controllers/HomeController';
import { setHeader, bodyLengthCheck  } from './controllers/MiddlewareFunctions';

const app = express();
const nodeServer = server.createServer(app);
app.set('view engine', 'pug');

app.use(express.static(__dirname + '/public'));

app.set('port', process.env.PORT || 3000);

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended : false}));
app.use(compression());

app.use(setHeader);

app.get('/', homeController.index);
app.post('/productRequest', productController.productRequest);

app.get('/productRequest/:id', productController.newSell);

nodeServer.listen(app.get('port'), () => {
  console.log("App is listening on port : %d", app.get('port'));
})
