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
    
    lazy var collectionViewProducts: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 1
        collectionViewLayout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true // Navigation bar large titles
        navigationItem.title = "Products"
        self.view.backgroundColor = .white
        /*
        let filtersButton = UIBarButtonItem(image: UIImage(named: "filter"), style: .plain, target: self, action: #selector(applyFilters))
        navigationItem.rightBarButtonItem = filtersButton
        */
        self.view.addSubview(collectionViewProducts)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionViewProducts)
        self.view.addConstraintsWithFormat(format: "V:|-[v0]|", views: collectionViewProducts)
        
        getProducts()
        
    }
    
    /*
    @objc func applyFilters() {
        print("applyFilters")
    }*/
    
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
                            self?.collectionViewProducts.reloadData()
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

extension ProductsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath)
        if let cell = cell as? ProductCell {
            let product = products[indexPath.row]
            cell.releaseView()
            cell.setUpView(product: product)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        let vc = DetailProductViewController()
        vc.product = product
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (collectionView.bounds.width/2) - 1
        return CGSize(width: size, height: size)
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == products.count - 1 ) { //it's your last cell
           //Load more data & reload your collection view
            print(" Load more data & reload your collection view ")
         }
    }*/
        
}
