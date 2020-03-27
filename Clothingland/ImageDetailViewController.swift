//
//  ImageDetailViewController.swift
//  Clothingland
//
//  Created by Luis Segoviano on 26/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController, UIScrollViewDelegate {
    
    var mainView: UIView {
        return self.view
    }
    
    let close: UIButton = {
        let image = UIImage(named: "close")
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return button
    }()
    
    var imageDetail: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: UIScreen.main.bounds)
        scrollView.backgroundColor = .white
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 7.0
        scrollView.isUserInteractionEnabled = true
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.flashScrollIndicators()
        scrollView.clipsToBounds = false
        return scrollView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
        
        scrollView.delegate = self
        mainView.addSubview(scrollView)
        mainView.addSubview(close)
        mainView.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        mainView.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        mainView.addConstraintsWithFormat(format: "H:[v0(24)]-|", views: close)
        mainView.addConstraintsWithFormat(format: "V:|-16-[v0(24)]", views: close)
        scrollView.addSubview(imageDetail)
        scrollView.addConstraintsWithFormat(format: "H:|[v0(\(UIScreen.main.bounds.width))]|", views: imageDetail)
        scrollView.addConstraintsWithFormat(format: "V:|[v0(\(UIScreen.main.bounds.height))]|", views: imageDetail)
        
        let tapZoom = UITapGestureRecognizer(target: self, action: #selector(zoomImage))
        tapZoom.numberOfTapsRequired = 2
        mainView.addGestureRecognizer(tapZoom)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageDetail
    }
    
    @objc func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Oculta el status-bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc func zoomImage(_ recognizer: UITapGestureRecognizer) {
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
        else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
    
}
