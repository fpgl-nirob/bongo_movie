//
//  UIView+Extension.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func round(radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        if borderWidth > 0.0 {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor.resolvedColor(with: AppManager.shared.traitCollection ?? self.traitCollection).cgColor
        }
    }
    
}

extension UIView {
    class func fromNib<T: UIView>() -> T? {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil)?.first as? T
    }
    
    static func createSwitch() -> UISwitch {
        let uiSwitch = UISwitch(frame: CGRect.zero)
        uiSwitch.translatesAutoresizingMaskIntoConstraints = false
        return uiSwitch
    }
    
    static func createLabel(text: AppTexts?) -> UILabel {
        return createLabel(text?.rawValue.tr)
    }
    
    static func createLabel(_ text: String? = nil) -> UILabel {
        let label: UILabel = UILabel()
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func createButton(imageName: AppImages? = nil) -> UIButton {
        return createButton(imageName?.rawValue)
    }
    
    static func createButton(_ imageName: String? = nil) -> UIButton {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: imageName ?? ""), for: .normal)
        return button
    }
    
    static func createButton(title: AppTexts?) -> UIButton {
        return createButton(title: title?.rawValue.tr)
    }
    
    static func createButton(title: String?) -> UIButton {
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .InterRegular(ofSize: 12.s)
        return button
    }
    
    static func createImageView(imageName: AppImages?) -> UIImageView {
        return createImageView(imageName?.rawValue)
    }
    
    static func createImageView(_ imageName: String?) -> UIImageView {
        let imageView: UIImageView = UIImageView()
        if imageName != nil {
            imageView.image = UIImage(named: imageName!)
        }
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    static func createView() -> UIView {
        let cView: UIView = UIView()
        cView.backgroundColor = UIColor.white
        cView.translatesAutoresizingMaskIntoConstraints = false
        return cView
    }
    
    static func createUITextField(_placeholder: String?, _delegate: UITextFieldDelegate?) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = true
        textField.delegate = _delegate
    
        textField.placeholder = _placeholder
        textField.borderStyle = .none
        textField.autocapitalizationType     = .none
        textField.autocorrectionType         = .no
        textField.clearButtonMode            = .whileEditing
        textField.contentVerticalAlignment   = .center
        textField.font                       = .InterSemiBold(ofSize: 14.sp)
        textField.textColor                  = .white
        textField.tintColor                  = .white
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.kern: 1.0])
        textField.backgroundColor            = UIColor.clear
        
        return textField
    }
    
    static func createSearchTextField(placeholder: AppTexts?) -> UISearchTextField {
        return createSearchTextField(placeholder: placeholder?.rawValue)
    }
    
    static func createSearchTextField(placeholder: String?) -> UISearchTextField {
        let searchField = UISearchTextField()
        searchField.borderStyle = .none
        searchField.backgroundColor = .white.withAlphaComponent(0.5)
        searchField.placeholder = placeholder?.tr
        return searchField
    }
    
    public static func createTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        
        return tableView
    }
    
    public static func createCollectionView(delegate: UICollectionViewDelegate?, dataSource: UICollectionViewDataSource?) -> UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0.s, left: 0.s, bottom: 0.s, right: 0.s)
        layout.minimumInteritemSpacing = 2.s
        layout.minimumLineSpacing = 2.s
        layout.itemSize = CGSize(width: 75.s, height: 90.s)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
        collectionView.backgroundColor = UIColor.clear
        
        return collectionView
    }
    
    public static func createPickerView(delegate: UIPickerViewDelegate, dataSource: UIPickerViewDataSource) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = delegate
        pickerView.dataSource = dataSource
        pickerView.backgroundColor = UIColor.clear
        
        return pickerView
    }
    
    public static func createScrollView(delegate: UIScrollViewDelegate) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = delegate
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }
    
    static func createTimePicker() -> UIDatePicker {
        let dp = UIDatePicker(frame: CGRect(x:0, y:0, width:SizeConfig.screenWidth, height: 30.s))
        dp.datePickerMode = UIDatePicker.Mode.time
        dp.translatesAutoresizingMaskIntoConstraints = false
        //dp.frame = CGRectMake(0, 0, 320, 180);
        dp.locale =  Locale(identifier: "ja_JP")
        dp.minuteInterval = 15
        if #available(iOS 13.4, *) {
            dp.preferredDatePickerStyle = .wheels
        }
        return dp
    }
}
