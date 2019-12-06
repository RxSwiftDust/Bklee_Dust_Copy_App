//
//  MainViewController.swift
//  Dusty
//
//  Created by HellSage on 2019/12/06.
//  Copyright © 2019 HellSage. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    /// 상단 컨테이너 뷰
    @IBOutlet weak var topContainerView: UIView!
    /// 하단 컨테이너 뷰
    @IBOutlet weak var bottomContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

    }
    
    // MARK: - private methods
    private func setupUI() {
        let topVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController")
        addChildController(childVC: topVC!, to: topContainerView)
    }
    
    
    private func addChildController(childVC: UIViewController, to view: UIView) {
        childVC.willMove(toParent: self)
        
        addChild(childVC)
        childVC.view.frame = view.bounds
        view.addSubview(childVC.view)
        
        childVC.didMove(toParent: self)
    }
}
