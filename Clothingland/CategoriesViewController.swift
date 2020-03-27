//
//  CategoriesViewController.swift
//  Clothingland
//
//  Created by Luis Segoviano on 24/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    var storeID: Int?
    
    lazy var collectionViewCategories: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumLineSpacing = 5
        collectionViewLayout.minimumInteritemSpacing = 5
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var categoriesCollection: [Category] = []
    
    lazy var tableViewCategories: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    var categoriesTable: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true // Navigation bar large titles
        navigationItem.title = "Categorías"
        self.view.backgroundColor = .white
        self.view.addSubview(collectionViewCategories)
        self.view.addSubview(tableViewCategories)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: collectionViewCategories)
        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: tableViewCategories)
        self.view.addConstraintsWithFormat(format: "V:|-[v0(50)]-[v1]|",
                                           views: collectionViewCategories, tableViewCategories)
        getCategories()
    }
    
    func getCategories() {
        if let store_id = storeID {
            HttpManager.getRequest(segment: "/stores/\(store_id)/categories", context: self) {
                [weak self] (responseData, errorMessage) -> () in
                if (errorMessage?.isEmpty)! {
                    if let result = responseData as? [Dictionary<String, Any>] {
                        
                        for c in result {
                            let newCategory = Category(categoriesArray: c)
                            self!.categoriesCollection.append(newCategory)
                        }
                        
                        DispatchQueue.main.async {
                            self?.collectionViewCategories.reloadData()
                            
                            // Autoselection of collection and table for categories.
                            if let firstElement = self!.categoriesCollection.first {
                                let initialIndex = IndexPath(row: 0, section: 0)
                                self?.collectionViewCategories.selectItem(at: initialIndex, animated: true, scrollPosition: .centeredVertically)
                                
                                self?.categoriesTable = firstElement.children
                                self?.tableViewCategories.reloadData()
                            }
                            
                        }// DispatchQueue
                    }
                }
                else {
                    Alerts.showSimpleAlert(message: errorMessage,
                                           context: self!, success: nil)
                }
            } // HttpManager
        }
    } // getCategories
    
}

// MARK: Extension for manage the collectionView for categories

extension CategoriesViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let category = categoriesCollection[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.releaseView()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.init(name: label.font.familyName, size: 12)
        label.text = category.name
        cell.addSubview(label)
        label.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        cell.layer.cornerRadius = 15.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            let category = categoriesCollection[indexPath.row]
            self.categoriesTable = category.children
            self.tableViewCategories.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if cell.isSelected {
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/3, height: 50)
    }
    
}


// MARK: Extension for manage the tableView for categories

extension CategoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categoriesTable[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = category.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(" indexPath ", indexPath)
        let category = categoriesTable[indexPath.row]
        let vc = ProductsViewController()
        vc.storeID = storeID
        vc.categoryID = category.categoryId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

