//
//  AppAlert.swift
//  TheBeats
//
//  Created by mac 2019 on 8/30/22.
//

import Foundation
import UIKit
import SnapKit

class AppPickerView: UIView {
    private let containerView: UIView = {
        let view = UIView.createView()
        view.backgroundColor = .white
        view.round(radius: 20.s, borderColor: UIColor.lightGray.withAlphaComponent(0.2), borderWidth: 1.s)
        return view
    }()
    
    private let titleLbl: UILabel = {
        let label = UIView.createLabel()
        label.textColor = .lightGray
        label.backgroundColor = .clear
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .InterMedium(ofSize: 14.sp)
        return label
    }()
    
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIView.createPickerView(delegate: self, dataSource: self)
        pickerView.backgroundColor = .clear
        return pickerView
    }()
    
    private lazy var cancelBtn: UIButton = {
        let button = UIView.createButton(title: .translate_id_0017)
        button.backgroundColor = .lightGray
        button.setTitleColor(UIColor.grayDarkLight, for: .normal)
        button.titleLabel?.font = .InterMedium(ofSize: 14.sp)
        button.round(radius: 24.s, borderColor: UIColor.lightGray, borderWidth: 1.s)
        button.addTarget(self, action: #selector(cancelBtnClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var confirmBtn: UIButton = {
        let button = UIView.createButton(title: .translate_id_0016)
        button.backgroundColor = .orange
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .InterMedium(ofSize: 14.sp)
        button.round(radius: 24.s, borderColor: UIColor.orange, borderWidth: 1.s)
        button.addTarget(self, action: #selector(confirmBtnClicked), for: .touchUpInside)
        return button
    }()
    
    private var alertSize: CGSize!
    private var confirmBlock: ((_ index: Int, _ value: String) -> Void)?
    public var dataValues: [String] = []
    public var selectedIndex: Int = 0
    
    init(size: CGSize) {
        super.init(frame: CGRect(x: 0, y: 0, width: SizeConfig.screenWidth, height: SizeConfig.screenHeight))
        alertSize = size
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupUI() {
        self.backgroundColor = .black.withAlphaComponent(0.3)
        self.addSubview(containerView)
        
        [pickerView, titleLbl, cancelBtn, confirmBtn].forEach { view in
            self.containerView.addSubview(view)
        }
        
        defineLayout()
    }
    
    private func defineLayout() {
        containerView.snp.makeConstraints { make in
            make.height.equalTo(alertSize.height)
            make.width.equalTo(alertSize.width)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.s)
            make.centerX.equalToSuperview()
        }
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(10.s)
            make.bottom.equalTo(cancelBtn.snp.top).offset(-10.s)
            make.centerX.equalToSuperview()
            make.width.equalTo(alertSize.width - 30.s)
        }
        cancelBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20.s)
            make.centerX.equalToSuperview().offset(-80.s)
            make.height.equalTo(48.s)
            make.width.equalTo(140.s)
        }
        confirmBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20.s)
            make.centerX.equalToSuperview().offset(80.s)
            make.height.equalTo(48.s)
            make.width.equalTo(140.s)
        }
    }
    
    public func show(title: String?, confirmed: ((_ index: Int, _ value: String) -> Void)? = nil) {
        confirmBlock = confirmed
        titleLbl.text = title
        pickerView.reloadAllComponents()
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, let window = appDelegate.window {
            window.addSubview(self)
            pickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
        }
    }
    
    private func hide() {
        self.removeFromSuperview()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != containerView {
            self.hide()
        }
    }
    
    @objc func cancelBtnClicked(sender: UIButton) {
        hide()
    }
    
    @objc func confirmBtnClicked(sender: UIButton) {
        hide()
        confirmBlock?(selectedIndex, dataValues[selectedIndex])
    }
}

extension AppPickerView: UIPickerViewDelegate {
    
}

extension AppPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.s
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.HiraginoSansW3(ofSize: 14.sp)]
        let attrStr = NSMutableAttributedString(string: dataValues[row], attributes: attributes)
        return attrStr
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row selected at: \(row)")
        selectedIndex = row
    }
}
