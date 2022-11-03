//
//  PhotoCell.swift
//  ELogy
//
//  Created by mac 2019 on 03/11/2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.contentView.addSubview(containerView)
        
        [photoView].forEach { view in
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
            make.leading.equalToSuperview().offset(4.s)
            make.top.equalToSuperview().offset(4.s)
            make.trailing.equalToSuperview().offset(-4.s)
            make.bottom.equalToSuperview().offset(-4.s)
        }
        
        photoView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4.s)
            make.top.equalToSuperview().offset(4.s)
            make.trailing.equalToSuperview().offset(-4.s)
            make.bottom.equalToSuperview().offset(-4.s)
        }
    }
    
    public func setupCell(indexPath: IndexPath, imageUrl: String?) {
        photoView.sd_setImage(with: URL(string: imageUrl ?? ""), placeholderImage: UIImage(named: AppImages.transparent.rawValue))
    }
}
