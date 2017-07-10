//
//  ProductInformation.swift
//  QRCode
//
//  Created by Ebubekir Ogden on 5/26/17.
//  Copyright © 2017 Ebubekir. All rights reserved.
//

import UIKit

class ProductInformation: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var sugarValue: UILabel!
    @IBOutlet weak var glutenFree: UILabel!
    @IBOutlet weak var proteinValue: UILabel!
    @IBOutlet weak var carbohydrateValue: UILabel!
    @IBOutlet weak var caloriesValue: UILabel!
    
    @IBOutlet weak var expireDate: UILabel!
    @IBOutlet weak var piece: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sugarValue.text = NewProduct.sharedInstance._ingredients["Sugars"]
        glutenFree.text = NewProduct.sharedInstance._ingredients["Gluten-Free"]
        proteinValue.text = NewProduct.sharedInstance._ingredients["Protein"]
        carbohydrateValue.text = NewProduct.sharedInstance._ingredients["Carbohydrate"]
        caloriesValue.text = NewProduct.sharedInstance._ingredients["Calories"]
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        
        if let date = dateFormatter.date(from: NewProduct.sharedInstance._expireDate){
            dateFormatter.dateFormat = "MM/dd/yyyy"
            expireDate.text = dateFormatter.string(from: date)
            
        }
        
        piece.text = String(NewProduct.sharedInstance._piece)
        price.text = NewProduct.sharedInstance._price
        
        
        switch NewProduct.sharedInstance._productName {
        case "Milky Way":
            productImage.image = UIImage(named: "milkyway")
            break;
        case "Lays":
            productImage.image = UIImage(named: "lays")
            break;
        case "Snickers":
            productImage.image = UIImage(named: "snickers")
            break;
        case "Coke":
            productImage.image = UIImage(named: "coke")
            break;
        case "M&M":
            productImage.image = UIImage(named: "m&m")
            break;
        default:
            break;
        }
        
    }

    @IBAction func buyClick(_ sender: Any) {
        
        let alertBuy = UIAlertController(title: "Product Detail", message: "Price is : " + NewProduct.sharedInstance._price  + " \n\n\n Product Name : " + NewProduct.sharedInstance._productName +  "", preferredStyle: .alert)
        
        let alert = UIAlertController(title: "Successful", message: "You have bought : " + NewProduct.sharedInstance._productName + " ", preferredStyle: .alert)
        
        alertBuy.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        alertBuy.addAction(UIAlertAction(title: "Buy", style: .default, handler: { (action: UIAlertAction!) in
            
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }))
        
        
        self.present(alertBuy, animated: true, completion: nil)
        
        
    }
    @IBAction func cancelClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
