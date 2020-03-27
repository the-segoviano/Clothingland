//
//  ProductCell.swift
//  Clothingland
//
//  Created by Luis Segoviano on 25/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ProductCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(" Error to initialize ")
    }
    
    let imageProduct: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameProduct: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        return label
    }()
    
    let descriptionProduct: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .lightGray
        label.font = UIFont.init(name: label.font.familyName, size: 13)
        return label
    }()
    
    let priceProduct: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.init(name: label.font.familyName, size: 12)
        return label
    }()
    
    func setUpView(product: Product) {
        nameProduct.text = product.name
        descriptionProduct.text = product.description
        priceProduct.text = "\(product.currency) \(product.originalPrice)"
        addSubview(imageProduct)
        addSubview(nameProduct)
        addSubview(descriptionProduct)
        addSubview(priceProduct)
        addConstraintsWithFormat(format: "H:|-1-[v0]-1-|", views: imageProduct)
        addConstraintsWithFormat(format: "H:|-1-[v0]-1-|", views: nameProduct)
        addConstraintsWithFormat(format: "H:|-1-[v0]-1-|", views: descriptionProduct)
        addConstraintsWithFormat(format: "H:|-1-[v0]-1-|", views: priceProduct)
        addConstraintsWithFormat(format: "V:|[v0(90)]-[v1]-[v2]-[v3]|",
                                 views: imageProduct, nameProduct, descriptionProduct, priceProduct)
        if let firstImage = product.images.first {
            if !firstImage.isEmpty {
                let url = URL(string: firstImage)
                imageProduct.af.setImage(withURL: url!)
            }
        }
        
        
    }
    
}
