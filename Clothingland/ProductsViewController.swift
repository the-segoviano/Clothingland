//
//  ProductsViewController.swift
//  Clothingland
//
//  Created by Luis Segoviano on 24/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    var storeID: Int?
    
    var categoryID: String?
    
    var products: [Product] = []
    
    lazy var tableViewProducts: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true // Navigation bar large titles
        navigationItem.title = "Products"
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableViewProducts)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableViewProducts)
        self.view.addConstraintsWithFormat(format: "V:|-[v0]|", views: tableViewProducts)
        
        getProducts()
        
    }
    
    func getProducts() {
        if let store_id = storeID, let category_id = categoryID {
            HttpManager.getRequest(segment: "/stores/\(store_id)/products/search?category_id=\(category_id)", context: self) {
                [weak self] (responseData, errorMessage) -> () in
                if (errorMessage?.isEmpty)! {
                    if let result = responseData as? Dictionary<String, Any> {
                        
                        if let products = result["results"] as? [Dictionary<String, Any>] {
                            for p in products {
                                let newProduct = Product(productObjectDict: p)
                                self?.products.append(newProduct)
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self?.tableViewProducts.reloadData()
                        }// DispatchQueue
                    }
                }
                else {
                    Alerts.showSimpleAlert(message: errorMessage,
                                           context: self!, success: nil)
                }
            } // HttpManager
            
        }
            
        
    } // getProducts
    
    
}


extension ProductsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = product.name
        return cell
    }
    
}
