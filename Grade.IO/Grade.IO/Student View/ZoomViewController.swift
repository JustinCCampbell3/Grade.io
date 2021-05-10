//
//  ZoomViewController.swift
//  Grade.IO
//
//  Created by user183573 on 1/5/21.
//

import UIKit
import TinyConstraints

class ZoomViewController: UIViewController {
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 400)
    //var for the scroll view that we can populate
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.frame = self.view.bounds
        view.contentSize = contentViewSize
        view.autoresizingMask = .flexibleHeight
        view.bounces = true
        view.showsHorizontalScrollIndicator = true
        return view
    }()
    
    //container view that goes within the scroll view
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.frame.size = contentViewSize
        return view
    }()
    
    //button for a zoom room
    lazy var zoomButton1: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "TestZoomBtn"), for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(zoomButton1)
        zoomButton1.center(in:  containerView)
        */
    }
}
