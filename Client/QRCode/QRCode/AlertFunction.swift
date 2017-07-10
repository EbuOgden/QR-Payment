//
//  AlertFunction.swift
//  QRCode
//
//  Created by Ebubekir Ogden on 5/26/17.
//  Copyright © 2017 Ebubekir. All rights reserved.
//

import UIKit

extension UIViewController{
    func doAlert(title: String, message: String, buttonText: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action: UIAlertAction!) in
            print("Canceled")
        }))
        
        alert.addAction(UIAlertAction(title: "Buy", style: .default, handler: { (action: UIAlertAction!) in
            
            print("Bought!")
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
}
