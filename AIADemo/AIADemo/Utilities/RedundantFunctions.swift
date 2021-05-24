//
//  RedundantFunctions.swift
//  AIADemo
//
//  Created by Harsha VARDHAN on 24/05/2021.
//

import UIKit

class RedundantFunctions: NSObject {

    func showDoubleActionAlert(_ title: String, message: String?, firstTitle:String, secondTitle:String?, onfirstClick:@escaping (() -> Void), onSecondClick:(() -> Void)?, onViewController:UIViewController) {
        DispatchQueue.main.async(execute: {() -> Void in
            
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: firstTitle, style: .default, handler: { (nil) in
                onfirstClick()
            }))
            
            if secondTitle != nil && onSecondClick != nil {
                alert.addAction(UIAlertAction.init(title: secondTitle!, style: .default, handler: { (nil) in
                    onSecondClick!()
                }))
            }
            onViewController.present(alert, animated: true, completion: nil)
        })
    }
    
    func showStaticAlert(_ title: String, message: String, onViewController:UIViewController) {
        
        DispatchQueue.main.async(execute: {() -> Void in
            
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: STRINGS.OK, style: .default, handler: nil))
            onViewController.present(alert, animated: true, completion: nil)
        })
    }
}
