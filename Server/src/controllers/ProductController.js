
import async from 'async';
import QRCode from 'qrcode';

import { databaseProductRequestSelectQueries, databaseProductRequestInsertQueries } from '../models/ProductRequestQueries';

import { cassandraClient, cassandraUUID  } from '../models/DatabaseConnection';

import { errorConsole, responseWithStatusandMessage, statusEnum } from '../helpers'; // 3 Parameters -> Place, Id, Error

export const productController = {
  productRequest: (req, res) => {

        const body = req.body;

        const machineId = body.machineId;
        const productId = body.productId;
        const piece = body.piece;

        async.waterfall([
          function getCurrentData(callback){
              cassandraClient.execute(databaseProductRequestSelectQueries.requestProduct, [machineId, productId], {prepare: true}, (err, result) => {
                  if(err){
                      errorConsole("Product Existent Control", "No Id", err);

                      responseWithStatusandMessage(res, statusEnum.FAIL, "Error Has Occured");
                  }
                  else{

                      if(result.length != 0){
                          callback(null, result.rows[0]);
                      }
                      else{
                          errorConsole("After Product Existent Control", "No Id", err);

                          responseWithStatusandMessage(res, statusEnum.FAIL, "Error Has Occured");
                      }

                  }
              })
          },
          function sendNewData(getCurrentDataCallback, callback){
              const uuid = cassandraUUID.random();

              const newSale = {
                  price: getCurrentDataCallback.price * piece,
                  expireDate: getCurrentDataCallback.expiredate,
                  productName: getCurrentDataCallback.productname,
                  ingredients: getCurrentDataCallback.ingredients,
                  piece: piece,
                  time: new Date()
              }

              cassandraClient.execute(databaseProductRequestInsertQueries.newSaleInsert, [uuid, machineId, productId, newSale.price, newSale.expireDate, newSale.productName, newSale.ingredients, newSale.piece, newSale.time], {prepare: true}, (err, result) => {
                  if(err){
                      errorConsole("New Sale Insert", "Id is : '" + uuid + "'", err);

                      responseWithStatusandMessage(res, statusEnum.FAIL, "Error Has Occured");
                  }
                  else{

                      callback(null, uuid);
                      console.log("New Sale Created : ", uuid);
                  }
              })

          },

          function createQRCode(getNewDataCallback, callback){

              QRCode.toDataURL('http://1.1.1.1:3000/productRequest/' + getNewDataCallback, function (err, url) {
                callback(null, url);
              })

          }
        ], (err, waterfallResult) => {
            if(err){
              errorConsole("waterfallResult", "No Id", err);

              responseWithStatusandMessage(res, statusEnum.FAIL, "Error Has Occured");
            }
            else{
                responseWithStatusandMessage(res, statusEnum.SUCCESS, waterfallResult);
            }
        })
  },

  newSell: (req, res) =>{

      const saleId = req.params.id;

      cassandraClient.execute(databaseProductRequestSelectQueries.newSaleSelect, [saleId], {prepare: true}, (err, result) => {
          if(err){
              errorConsole("New Sell Product Get", "No Id", err);

              responseWithStatusandMessage(res, statusEnum.FAIL, "Error Has Occured");
          }
          else{

              const resultNew = result.first();


              const soldProduct = {
                  productId: resultNew.productid,
                  expireDate: resultNew.expiredate,
                  ingredients: resultNew.ingredients,
                  piece: resultNew.piece,
                  price: resultNew.price.toFixed(2),
                  productName: resultNew.productname,
                  time: resultNew.time
              }

              responseWithStatusandMessage(res, statusEnum.SUCCESS, soldProduct);
          }
      })
  }
}
