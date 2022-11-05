//
//  SettingsViewController.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import UIKit
import SnapKit

class SettingsViewController: BaseViewController, Alertable {
    
    private let containerView: UIView = {
        let view = UIView.createView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let themeModeLbl: UILabel = {
        let label = UIView.createLabel(text: .translate_id_0001)
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .InterRegular(ofSize: 14.sp)
        return label
    }()
    
    private let themeSwitch: UISwitch = {
        let tSwitch = UIView.createSwitch()
        return tSwitch
    }()
    
    private let languageLbl: UILabel = {
        let label = UIView.createLabel(text: .translate_id_0019)
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .InterRegular(ofSize: 14.sp)
        return label
    }()
    
    private lazy var arrowBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = .whiteBlack
        button.addTarget(self, action: #selector(arrowBtnClicked), for: .touchUpInside)
        return button
    }()
    
    private var viewModel = SettingsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavBar(title: .translate_id_0003, backButtonClicked: {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
        
        addSubViews()
        defineLayout()
        setContent()
    }
    
    deinit {
        print("deinit settings vc")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.round(radius: 10.s, borderColor: .lightGray.withAlphaComponent(0.2), borderWidth: 1.s)
    }
    
    private func addSubViews() {
        self.view.addSubview(containerView)
        
        [themeModeLbl, themeSwitch, languageLbl, arrowBtn].forEach { view in
            containerView.addSubview(view)
        }
        
        themeSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    private func defineLayout() {
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(335.s)
            make.height.equalTo(200.s)
        }
        
        themeModeLbl.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20.s)
            make.top.equalToSuperview().offset(20.s)
        }
        
        themeSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20.s)
            make.top.equalToSuperview().offset(20.s)
        }
        
        languageLbl.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20.s)
            make.top.equalTo(themeModeLbl.snp.bottom).offset(40.s)
        }
        
        arrowBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20.s)
            make.top.equalTo(themeSwitch.snp.bottom).offset(30.s)
        }
    }
    
    private func setContent() {
        themeModeLbl.text = "\(AppTexts.translate_id_0010.rawValue.tr) \(AppManager.shared.isDarkMode ? "\(AppTexts.translate_id_0011.rawValue.tr)" : "\(AppTexts.translate_id_0012.rawValue.tr)") \(AppTexts.translate_id_0013.rawValue.tr)"
        themeSwitch.isOn = AppManager.shared.isDarkMode
    }
    
    private func updateUIElement() {
        updateNavbarTitle(title: .translate_id_0003)
        themeModeLbl.text = "\(AppTexts.translate_id_0010.rawValue.tr) \(AppManager.shared.isDarkMode ? "\(AppTexts.translate_id_0011.rawValue.tr)" : "\(AppTexts.translate_id_0012.rawValue.tr)") \(AppTexts.translate_id_0013.rawValue.tr)"
        languageLbl.text = AppTexts.translate_id_0019.rawValue.tr
    }
    
    @objc func switchValueChanged(sender: UISwitch) {
        changeTheme(isDark: !AppManager.shared.isDarkMode)
        containerView.round(radius: 10.s, borderColor: .lightGray.withAlphaComponent(0.2), borderWidth: 1.s)
        AppManager.shared.saveDarkMode(isDark: AppManager.shared.isDarkMode)
        
        themeModeLbl.text = "\(AppTexts.translate_id_0010.rawValue.tr) \(AppManager.shared.isDarkMode ? "\(AppTexts.translate_id_0011.rawValue.tr)" : "\(AppTexts.translate_id_0012.rawValue.tr)") \(AppTexts.translate_id_0013.rawValue.tr)"
    }
    
    @objc func arrowBtnClicked(sender: UIButton) {
        let langPicker = AppPickerView(size: CGSize(width: 335.s, height: 250.s))
        langPicker.dataValues = [AppTexts.translate_id_0014.rawValue.tr, AppTexts.translate_id_0015.rawValue.tr]
        langPicker.selectedIndex = viewModel.getSelectedLangIndex()
        langPicker.show(title: AppTexts.translate_id_0018.rawValue.tr) {[weak self] (index, value) in
            guard let self = self else { return }
            print("index: \(index) value: \(value)")
            self.viewModel.selectedLang = value
            AppManager.shared.setLanguage(lang: self.viewModel.getLangCode().rawValue)
            NotificationCenter.default.post(name: .languageChangedNotification, object: nil)
            self.updateUIElement()
        }
        self.view.addSubview(langPicker)
    }

}
