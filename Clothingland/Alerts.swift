//
//  Alerts.swift
//  Clothingland
//
//  Created by Luis Segoviano on 23/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import UIKit

struct Alerts {
    
    typealias callbackAlert = ((UIAlertAction) -> Void)?
    
    static func showSimpleAlert(message: String!, context: UIViewController, success: callbackAlert ) {
        let alertController = UIAlertController(title: "",
                                                message: message,
                                                preferredStyle: UIAlertController.Style.alert)
        let dismissAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: success)
        alertController.addAction(dismissAction)
        DispatchQueue.main.async { context.present(alertController, animated: true, completion: nil) }
    }
    
    private static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
}
