//
//  SizesProductsCell.swift
//  Clothingland
//
//  Created by Luis Segoviano on 26/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import UIKit

class SizesProductsCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var collectionViewSizes: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.addBorder()
        return collectionView
    }()
    
    var sizes: [Size] = []
    
    func setUpView(product: Product) {
        self.sizes = product.sizes
        addSubview(collectionViewSizes)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionViewSizes)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionViewSizes)
    }
    
}
extension SizesProductsCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentSize = sizes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let sizeLabel = UILabel()
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        sizeLabel.text = currentSize.name
        cell.addSubview(sizeLabel)
        sizeLabel.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
        sizeLabel.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        return cell
    }
    
}
