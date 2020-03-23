//
//  ViewController.swift
//  Clothingland
//
//  Created by Luis Segoviano on 23/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        //
        
        HttpManager.getRequest(segment: "/stores", context: self) {
            [weak self] (responseData, errorMessage) -> () in
            //guard let strongSelf = self else { return }
            if (errorMessage?.isEmpty)! {
                
                let result = responseData as? [Dictionary<String, Any>]
                
                print(" result ", result)
                
            }
            else {
                Alerts.showSimpleAlert(message: errorMessage,
                                       context: self!, success: nil)
            }
        } // HttpManager
        
    }

}
