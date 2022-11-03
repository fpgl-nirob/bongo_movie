//
//  BaseViewController.swift
//  GCommerce
//
//  Created by mac 2019 on 10/28/22.
//

import UIKit
import SnapKit
import MBProgressHUD

class BaseViewController: UIViewController {

    var navBar: NavBar?
    var navBarHeight: CGFloat!
    
    // MARK: -Super Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.view.endEditing(true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    func changeTheme(isDark: Bool) {
        if let window = UIApplication.shared.windows.first {
            window.overrideUserInterfaceStyle = isDark ? .dark : .light
        }
    }
    
    // MARK: -Custom Methods
    func setupNavBar(title: AppTexts, rightBtnImgName: String? = nil, backButtonClicked: BackButtonClicked? = nil, rightButtonClicked: RightButtonClicked? = nil) {
        navBar = NavBar(title: title.rawValue.tr, rightBtnImgName: rightBtnImgName, backButtonClicked: backButtonClicked, rightButtonClicked: rightButtonClicked)
        self.view.addSubview(navBar!)
        navBarHeight = SizeConfig.navBarHeight
        navBar?.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0.s)
            make.top.equalToSuperview().offset(0.s)
            make.trailing.equalToSuperview().offset(0.s)
            make.height.equalTo(SizeConfig.navBarHeight)
        }
    }
    
    func updateNavbarTitle(title: AppTexts) {
        navBar?.updateTitle(title: title)
    }
    
    func showHUD() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }

}
