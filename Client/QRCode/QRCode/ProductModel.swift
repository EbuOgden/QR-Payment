//
//  ProductModel.swift
//  QRCode
//
//  Created by Ebubekir Ogden on 5/26/17.
//  Copyright © 2017 Ebubekir. All rights reserved.
//

import Foundation

class NewProduct{
    static var sharedInstance = NewProduct()
    private init() {}
    
    var _ingredients: Dictionary<String, String> = [:]
    var _productId: String = ""
    var _expireDate: String = ""
    var _piece: Int = 0
    var _price: String = ""
    var _time: String = ""
    var _productName: String = ""
    
}
