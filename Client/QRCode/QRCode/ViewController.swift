//
//  ViewController.swift
//  QRCode
//
//  Created by Ebubekir Ogden on 5/24/17.
//  Copyright © 2017 Ebubekir. All rights reserved.
//

import UIKit
import SwiftQRCode
import Alamofire

class ViewController: UIViewController {

    let scanner = QRCode()
    
    @IBOutlet weak var stopScanButton: UIButton!
    
    @IBOutlet weak var startScanButton: UIButton!
    
    @IBOutlet weak var vendingImage: UIImageView!
    
    
       override func viewDidLoad() {
        super.viewDidLoad()
        scanner.scanFrame = view.bounds
        
    }
    
    
    
    @IBAction func clickButton(_ sender: Any) {
        
        vendingImage.isHidden = true
        startScanButton.isHidden = true
        stopScanButton.isHidden = false
        scanner.prepareScan(view) { (stringValue) -> () in
            
            
            self.scanner.stopScan();
            self.scanner.removeAllLayers()
            
            let url = URL(string: stringValue);
            print(url!)
            
            Alamofire.request(url!, method: .get, parameters: nil, encoding: URLEncoding.httpBody).responseJSON(){
                response in
                
                let result = response.result
                
                if let dictionary = result.value as? Dictionary<String, Any>{
                    if let message = dictionary["message"] as? Dictionary<String, Any>{
                        
                        let ingredients = message["ingredients"] as! Dictionary<String, String>
                        let productId = message["productId"] as! String
                        let expireDate = message["expireDate"] as! String
                        let price = message["price"] as! String
                        let piece = message["piece"] as! Int
                        let time = message["time"] as! String
                        let productName = message["productName"] as! String
                        
                        NewProduct.sharedInstance._ingredients = ingredients
                        NewProduct.sharedInstance._price = price
                        NewProduct.sharedInstance._expireDate = expireDate
                        NewProduct.sharedInstance._piece = piece
                        NewProduct.sharedInstance._productName = productName
                        
                        self.performSegue(withIdentifier: "newProductSellPage", sender: nil)
                        
                    }
                }
                
            }
            
            self.vendingImage.isHidden = false
            self.startScanButton.isHidden = false
            self.stopScanButton.isHidden = true
        }
        
        
        scanner.startScan()
    }
    @IBAction func stopButtonClick(_ sender: Any) {
        self.scanner.stopScan();
        self.scanner.removeAllLayers()
        
        self.vendingImage.isHidden = false
        self.startScanButton.isHidden = false
        self.stopScanButton.isHidden = true
    }

}

