//
//  PhotoGalleryCell.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import UIKit
import SnapKit
import SDWebImage
import Cosmos

class ProductCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let containerV = UIView.createView()
        containerV.backgroundColor = .background
        return containerV
    }()
    
    private let photoView: UIImageView = {
        let imageView = UIView.createImageView(imageName: .transparent)
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let titleLbl: UILabel = {
        let lbl = UIView.createLabel("")
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byTruncatingTail
        lbl.textAlignment = .left
        lbl.font = .InterRegular(ofSize: 14.s)
        return lbl
    }()
    
    private let priceLbl: UILabel = {
        let lbl = UIView.createLabel("")
        lbl.numberOfLines = 1
        lbl.lineBreakMode = .byCharWrapping
        lbl.textColor = .orange
        lbl.textAlignment = .left
        lbl.font = .InterMedium(ofSize: 16.s)
        return lbl
    }()
    
    private let ratingView: CosmosView = {
        let ratV = CosmosView()
        ratV.settings.updateOnTouch = false
        ratV.settings.starSize = 16.s
        ratV.settings.starMargin = 0.s
        ratV.settings.fillMode = .precise
        ratV.translatesAutoresizingMaskIntoConstraints = false
        return ratV
    }()
    
    private var productModel: ProductModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.contentView.addSubview(containerView)
        
        [photoView, titleLbl, priceLbl, ratingView].forEach { view in
            self.containerView.addSubview(view)
        }
        
        defineLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.round(radius: 3.s, borderColor: .lightGray.withAlphaComponent(0.2), borderWidth: 1.s)
    }
    
    private func defineLayout() {
        
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10.s)
            make.top.equalToSuperview().offset(10.s)
            make.trailing.equalToSuperview().offset(-10.s)
            make.bottom.equalToSuperview().offset(-10.s)
        }
        
        photoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.s)
            make.centerX.equalToSuperview()
            make.height.equalTo(140.s)
            make.width.equalTo(140.s)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10.s)
            make.top.equalTo(photoView.snp.bottom).offset(10.s)
            make.trailing.equalToSuperview().offset(-10.s)
        }
        
        priceLbl.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10.s)
            make.top.equalTo(titleLbl.snp.bottom).offset(10.s)
            make.trailing.equalToSuperview().offset(-10.s)
        }
        
        ratingView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10.s)
            make.top.equalTo(priceLbl.snp.bottom).offset(10.s)
        }
    }
    
    public func setupCell(indexPath: IndexPath, productModel: ProductModel) {
        self.productModel = productModel
        let url = URL(string: productModel.imageUrls?.first ?? "")
        photoView.sd_setImage(with: url, placeholderImage: UIImage(named: AppImages.transparent.rawValue))
        titleLbl.text = productModel.title?.stringValue
        priceLbl.text = "\(productModel.price?.intValue ?? 0)"
        ratingView.rating = productModel.reviewAverage?.doubleValue ?? 0.0
        ratingView.text = "(\(productModel.reviewCount?.intValue ?? 0))"
    }
}
