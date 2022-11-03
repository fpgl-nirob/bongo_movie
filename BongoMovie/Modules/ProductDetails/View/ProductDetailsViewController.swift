//
//  ProductDetailsViewController.swift
//  ELogy
//
//  Created by mac 2019 on 03/11/2022.
//

import UIKit
import SnapKit
import SDWebImage
import Lightbox

class ProductDetailsViewController: BaseViewController, Alertable {

    private lazy var scrollView: UIScrollView = {
        let scrollV = UIView.createScrollView(delegate: self)
        scrollV.backgroundColor = UIColor.clear
        return scrollV
    }()
    
    private lazy var containerView: UIView = {
        let containerV = UIView.createView()
        containerV.backgroundColor = UIColor.clear
        return containerV
    }()
    
    private let titleLbl: UILabel = {
        let lbl = UIView.createLabel("")
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.textColor = .whiteGray
        lbl.font = .InterRegular(ofSize: 14.s)
        return lbl
    }()
    
    private let featureImageView: UIImageView = {
        let imgV = UIView.createImageView(imageName: .defaultProfile)
        imgV.tag = 0
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    private lazy var photoCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100.s, height: 100.s)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0.s
        
        let collectionV = UIView.createCollectionView(delegate: self, dataSource: self)
        collectionV.collectionViewLayout = flowLayout
        collectionV.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.cellIdentifier)
        collectionV.backgroundColor = .clear
        collectionV.isScrollEnabled = true
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        return collectionV
    }()
    
    private let priceLbl: UILabel = {
        let lbl = UIView.createLabel("")
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.textColor = .orange
        lbl.font = .InterBold(ofSize: 16.s)
        return lbl
    }()
    
    private let headlineLbl: UILabel = {
        let lbl = UIView.createLabel("")
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.textColor = .grayDarkLight
        lbl.font = .InterMedium(ofSize: 12.s)
        return lbl
    }()
    
    private let descriptionLbl: UILabel = {
        let lbl = UIView.createLabel("")
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.textColor = .lightGray
        lbl.font = .InterRegular(ofSize: 12.s)
        return lbl
    }()
    
    private lazy var buyBtn: UIButton = {
        let btn = UIButton.createButton(title: .translate_id_0009)
        btn.backgroundColor = .orange
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = .InterBold(ofSize: 18.sp)
        btn.addTarget(self, action: #selector(buyBtnClicked), for: .touchUpInside)
        return btn
    }()
    
    public var productModel: ProductModel!  {
        didSet {
            setupData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoCollectionView.round(radius: 1.r, borderColor: .lightGray.withAlphaComponent(0.2), borderWidth: 1.s)
    }
    
    func addSubViews() {
        setupNavBar(title: .translate_id_0008, backButtonClicked: {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        [titleLbl, featureImageView, photoCollectionView, priceLbl, headlineLbl, descriptionLbl, buyBtn].forEach { view in
            containerView.addSubview(view)
        }
        
        featureImageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(featureImgClicked))
        featureImageView.addGestureRecognizer(gesture)
    }
    
    func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(navBarHeight)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(SizeConfig.screenWidth)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20.s)
            make.top.equalToSuperview().offset(20.s)
            make.trailing.equalToSuperview().offset(-20.s)
        }
        
        featureImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(20.s)
            make.centerX.equalToSuperview()
            make.height.equalTo(150.s)
            make.width.equalTo(150.s)
        }
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(featureImageView.snp.bottom).offset(20.s)
            make.centerX.equalToSuperview()
            make.height.equalTo(100.s)
            make.width.equalTo(335.s)
        }
        
        priceLbl.snp.makeConstraints { make in
            make.top.equalTo(photoCollectionView.snp.bottom).offset(20.s)
            make.leading.equalToSuperview().offset(20.s)
            make.trailing.equalToSuperview().offset(-20.s)
        }
        
        headlineLbl.snp.makeConstraints { make in
            make.top.equalTo(priceLbl.snp.bottom).offset(20.s)
            make.leading.equalToSuperview().offset(20.s)
            make.trailing.equalToSuperview().offset(-20.s)
        }
        
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(headlineLbl.snp.bottom).offset(20.s)
            make.leading.equalToSuperview().offset(20.s)
            make.trailing.equalToSuperview().offset(-20.s)
            make.bottom.equalToSuperview().offset(-100.s)
        }
        
        buyBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20.s)
            make.centerX.equalToSuperview()
            make.width.equalTo(200.s)
            make.height.equalTo(40.s)
        }
    }
    
    func setupData() {
        titleLbl.text = productModel.title?.stringValue
        featureImageView.sd_setImage(with: URL(string: productModel.imageUrls?.first ?? ""), placeholderImage: UIImage(named: AppImages.defaultProfile.rawValue))
        priceLbl.text = "USD \(productModel.price?.intValue ?? 0)"
        headlineLbl.text = productModel.headline?.stringValue
        descriptionLbl.text = productModel.description?.stringValue
    }
    
    @objc func featureImgClicked(gesture: UITapGestureRecognizer) {
        LightboxConfig.preload = 2
        
        guard let urlStr = productModel.imageUrls?.first, let url = URL(string: urlStr) else {
            return
        }
        let images = [LightboxImage(imageURL: url)]
        let controller = LightboxController(images: images)
        // bellow two lines are important
        controller.dynamicBackground = true
        controller.dynamicBackground = false
        self.present(controller, animated: true)
    }
    
    @objc func buyBtnClicked(sender: UIButton) {
        self.showAlert(message: "Buy option is not implemented currently")
    }

}

extension ProductDetailsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        featureImageView.tag = indexPath.item
        let imageUrl = productModel.imageUrls?[indexPath.item] ?? ""
        featureImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: AppImages.defaultProfile.rawValue))
    }
}

extension ProductDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productModel.imageUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.cellIdentifier, for: indexPath) as? PhotoCell else {
            fatalError("PhotoCell is not initialized")
        }
        cell.setupCell(indexPath: indexPath, imageUrl: productModel.imageUrls?[indexPath.item])
        return cell
    }
}

extension ProductDetailsViewController: UIScrollViewDelegate {
    
}
