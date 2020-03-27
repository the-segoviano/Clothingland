//
//  ViewController.swift
//  Clothingland
//
//  Created by Luis Segoviano on 23/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    fileprivate var filtered = [Country]()
    
    fileprivate var filterring = false
    
    var countries: [Country] = []
    
    var storeViewsSelected: [StoreViews] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true // Navigation bar large titles
        navigationItem.title = "Countries"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        HttpManager.getRequest(segment: "/stores", context: self) {
            [weak self] (responseData, errorMessage) -> () in
            if (errorMessage?.isEmpty)! {
                if let result = responseData as? [Dictionary<String, Any>] {
                    DispatchQueue.main.async {
                        if result.count > 0 {
                            for c in result {
                                let newCountry = Country(countryDictionary: c)
                                self?.countries.append(newCountry)
                            }
                            self?.tableView.reloadData()
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
    
    var sectionSelected: Int?
    
    @objc func reloadSection(sender: ReloadSectionTapGesture) {
        if let sec = sender.section {
            sectionSelected = sec
            let countrySelected = countries[sec]
            storeViewsSelected = countrySelected.storeViews
            self.tableView.reloadData()
        }
    }
    
}

extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.filterring ? self.filtered.count : countries.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionSelected != nil {
            if sectionSelected == section {
                return storeViewsSelected.count
            }
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = storeViewsSelected[indexPath.row].name
        cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let countrySelected = storeViewsSelected[indexPath.row]
        let vc = CategoriesViewController()
        vc.storeID = countrySelected.storeId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let reloadSectionRecognizer = ReloadSectionTapGesture(target: self, action: #selector(ViewController.reloadSection(sender:)))
        reloadSectionRecognizer.section = section
        let headerInSection = UIView()
        headerInSection.isUserInteractionEnabled = true
        headerInSection.addGestureRecognizer(reloadSectionRecognizer)
        let nameCountryLabel = UILabel()
        nameCountryLabel.translatesAutoresizingMaskIntoConstraints = false
        nameCountryLabel.text = self.countries[section].name
        headerInSection.addSubview(nameCountryLabel)
        nameCountryLabel.centerXAnchor.constraint(equalTo: headerInSection.centerXAnchor).isActive = true
        nameCountryLabel.centerYAnchor.constraint(equalTo: headerInSection.centerYAnchor).isActive = true
        nameCountryLabel.leadingAnchor.constraint(equalTo: headerInSection.leadingAnchor, constant: 8).isActive = true
        if sectionSelected == section {
            headerInSection.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        }
        else{
            headerInSection.backgroundColor = UIColor.white
        }
        return headerInSection
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
    
    class ReloadSectionTapGesture: UITapGestureRecognizer {
        var section: Int?
    }
    
}
