//
//  ImagesProductsCell.swift
//  Clothingland
//
//  Created by Luis Segoviano on 26/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import UIKit

class ImagesProductsCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var reference: UIViewController?
    
    lazy var collectionViewImages: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(ImageProductCell.self, forCellWithReuseIdentifier: "ImageProductCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    var images: [String] = []
    
    var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.gray
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.5)
        return pageControl
    }()
    
    func setUpView(product: Product) {
        self.images = product.images
        addSubview(collectionViewImages)
        addSubview(pageControl)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionViewImages)
        addConstraintsWithFormat(format: "H:|[v0]|", views: pageControl)
        addConstraintsWithFormat(format: "V:|[v0]-[v1(50)]|", views: collectionViewImages, pageControl)
        collectionViewImages.reloadData()
        pageControl.numberOfPages = images.count
    }
    
}



extension ImagesProductsCell: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageProductCell", for: indexPath)
        if let cell = cell as? ImageProductCell {
            cell.setUpView(imageUrlString: images[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageProductCell {
            let vc = ImageDetailViewController()
            vc.imageDetail = cell.imageProduct
            reference?.present(vc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 200)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    
}





class ImageProductCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(" Error to initialize ")
    }
    
    let imageProduct: UIImageView = {
        let imageProduct = UIImageView()
        imageProduct.translatesAutoresizingMaskIntoConstraints = false
        imageProduct.image = UIImage(named: "placeholder")
        imageProduct.backgroundColor = .white
        imageProduct.contentMode = .scaleAspectFit
        return imageProduct
    }()
    
    func setUpView(imageUrlString: String) {
        addSubview(imageProduct)
        imageProduct.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageProduct.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageProduct.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageProduct.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageProduct.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageProduct.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        if !imageUrlString.isEmpty {
            imageProduct.af.setImage(withURL: URL(string: imageUrlString)!)
        }
    }
    
}
