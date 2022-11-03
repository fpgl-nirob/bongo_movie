//
//  SplashViewController.swift
//  GCommerce
//
//  Created by mac 2019 on 10/28/22.
//

import UIKit
import SnapKit

class SplashViewController: BaseViewController {
    
    private lazy var logoImageView: UIImageView = {
        let imgV = UIView.createImageView(imageName: .logo)
        return imgV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(logoImageView)
        
        bindingModel()
        defineLayout()
        
        let seconds = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { [weak self] in
            self?.decideAction()
        }
    }
    
    private func bindingModel() {
        
    }
    
    private func defineLayout() {
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(100.s)
            make.width.equalTo(100.s)
        }
    }
    
    private func decideAction() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            appDelegate.setHomeViewController()
        }
    }

}
