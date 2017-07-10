export const databaseProductRequestInsertQueries = {
  newSaleInsert : "INSERT INTO saledProducts(saleId, machineID, productID, price, expireDate, productName, ingredients, piece, time) VALUES(?, ?, ?, ? ,?, ?, ?, ?, ?)"
}


export const databaseProductRequestSelectQueries = {
    requestProduct : "SELECT * FROM products WHERE machineId = ? and productId = ?",

    newSaleSelect: "SELECT * FROM saledProducts WHERE saleId = ?"
}
