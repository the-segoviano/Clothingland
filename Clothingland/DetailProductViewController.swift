//
//  DetailProductViewController.swift
//  Clothingland
//
//  Created by Luis Segoviano on 25/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import UIKit

class DetailProductViewController: UITableViewController {
    
    var product: Product?
    
    let sections = ["images", "name", "price" ,"description", "sizes"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true // Navigation bar large titles
        self.tableView.separatorStyle = .none
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.register(ImagesProductsCell.self, forCellReuseIdentifier: "ImagesProductsCell")
        //self.tableView.register(SizesProductsCell.self, forCellReuseIdentifier: "SizesProductsCell")
        if let product = product {
            navigationItem.title = product.name
        }
        self.view.backgroundColor = .white
        
        self.hideKeyboardWhenTappedAround()
        
        let shareItem = UIBarButtonItem(barButtonSystemItem: .action, target: self,
                                      action: #selector(self.share))
        self.navigationItem.rightBarButtonItem = shareItem
        
    }
    
    let textFieldSizes = BaseTextField()
    
    lazy var pickerViewSizes: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.showsSelectionIndicator = true
        pickerView.setValue(UIColor.white, forKey: "backgroundColor")
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    @objc func hidePickerViews() {
        self.view.endEditing(true)
    }
    
    @objc func share() {
        if let product = self.product {
            let objectsToShare = [product.name, product.url] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
}

extension DetailProductViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if sections[indexPath.row] == "images" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesProductsCell", for: indexPath)
            if let cell = cell as? ImagesProductsCell {
                cell.releaseView()
                cell.reference = self
                cell.setUpView(product: self.product!)
                return cell
            }
        }
        
        if sections[indexPath.row] == "name" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = product?.name
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.init(name: (cell.textLabel?.font.familyName)!, size: 24.0)
            return cell
        }
        
        if sections[indexPath.row] == "price" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            if let currency = product?.currency, let price = product?.originalPrice {
                cell.textLabel?.text = "\(currency) \(price)"
            }
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.font = UIFont.init(name: (cell.textLabel?.font.familyName)!, size: 28.0)
            cell.textLabel?.textColor = .gray
            return cell
        }
        
        if sections[indexPath.row] == "description" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = product?.description
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textColor = .lightGray
            return cell
        }
        
        if sections[indexPath.row] == "sizes" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.releaseView()
            textFieldSizes.inputView = pickerViewSizes
            textFieldSizes.placeholder = "Tallas disponibles"
            textFieldSizes.translatesAutoresizingMaskIntoConstraints = false
            textFieldSizes.rightViewMode = UITextField.ViewMode.always
            cell.addSubview(textFieldSizes)
            textFieldSizes.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            textFieldSizes.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
            textFieldSizes.topAnchor.constraint(equalTo: cell.topAnchor, constant: 8).isActive = true
            textFieldSizes.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 16).isActive = true
            textFieldSizes.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -16).isActive = true
            return cell
        }
        
        return UITableViewCell()
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentSection = sections[indexPath.row]
        if currentSection == "name" || currentSection == "price" || currentSection == "description" {
            return UITableView.automaticDimension
        }
        if currentSection == "sizes" {
            return 50
        }
        return 250
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}




extension DetailProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (product?.sizes.count)!
    }
    
    // Este es el texto que se muetsra en el Picker View
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerViewSizes {
            return product?.sizes[row].name
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerViewSizes {
            textFieldSizes.text = product?.sizes[row].name
            hidePickerViews()
        }
        
    }
    
}


