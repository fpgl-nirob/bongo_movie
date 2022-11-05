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

class TopRatedMovieCell: UICollectionViewCell {
    
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
    
    private let releaseLbl: UILabel = {
        let lbl = UIView.createLabel("")
        lbl.numberOfLines = 1
        lbl.lineBreakMode = .byCharWrapping
        lbl.textColor = .lightGray
        lbl.textAlignment = .left
        lbl.font = .InterRegular(ofSize: 12.s)
        return lbl
    }()
    
    private let descriptionLbl: UILabel = {
        let lbl = UIView.createLabel("")
        lbl.numberOfLines = 2
        lbl.lineBreakMode = .byCharWrapping
        lbl.textColor = .whiteBlack
        lbl.textAlignment = .left
        lbl.font = .InterRegular(ofSize: 12.s)
        return lbl
    }()
    
    private let ratingView: CosmosView = {
        let ratV = CosmosView()
        ratV.settings.updateOnTouch = false
        ratV.settings.starSize = 14.s
        ratV.settings.starMargin = 0.s
        ratV.settings.fillMode = .precise
        ratV.settings.totalStars = 10
        ratV.translatesAutoresizingMaskIntoConstraints = false
        return ratV
    }()
    
    private var movieModel: TopRatedMoviesModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.contentView.addSubview(containerView)
        
        [photoView, titleLbl, releaseLbl, descriptionLbl, ratingView].forEach { view in
            self.containerView.addSubview(view)
        }
        
        defineLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.roundWithShadow(_cornerRadius: 5.s, _x: 0, _y: 0, _blar: 4, _spread: 0.0, _shadowOpacity: 1.0, _shadowColor: .lightGray.withAlphaComponent(0.8))
    }
    
    private func defineLayout() {
        
        containerView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10.s)
            make.top.equalToSuperview().offset(10.s)
            make.trailing.equalToSuperview().offset(-10.s)
            make.bottom.equalToSuperview().offset(-4.s)
        }
        
        photoView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(0.s)
            make.top.equalToSuperview().offset(0.s)
            make.bottom.equalToSuperview().offset(-0.s)
            make.width.equalTo(120.s)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.leading.equalTo(photoView.snp.trailing).offset(10.s)
            make.top.equalToSuperview().offset(10.s)
            make.trailing.equalToSuperview().offset(-10.s)
        }
        
        releaseLbl.snp.makeConstraints { make in
            make.leading.equalTo(photoView.snp.trailing).offset(10.s)
            make.top.equalTo(titleLbl.snp.bottom).offset(10.s)
            make.trailing.equalToSuperview().offset(-10.s)
        }
        
        descriptionLbl.snp.makeConstraints { make in
            make.leading.equalTo(photoView.snp.trailing).offset(10.s)
            make.top.equalTo(releaseLbl.snp.bottom).offset(20.s)
            make.trailing.equalToSuperview().offset(-10.s)
        }
        
        ratingView.snp.makeConstraints { make in
            make.leading.equalTo(photoView.snp.trailing).offset(10.s)
            make.bottom.equalToSuperview().offset(-10.s)
        }
    }
    
    public func setupCell(indexPath: IndexPath, movieModel: TopRatedMoviesModel) {
        self.movieModel = movieModel
        
        photoView.sd_setImage(with: movieModel.posterUrl, placeholderImage: UIImage(named: AppImages.transparent.rawValue))
        titleLbl.text = movieModel.title
        releaseLbl.text = movieModel.releaseDate?.convertTo(informat: DateFormatConstants.yyyy_mm_dd, outformat: DateFormatConstants.MMM_dd_yyyy)
        descriptionLbl.text = movieModel.overview
        ratingView.rating = Double(movieModel.voteAverage ?? 0.0)
        print("rating: \(Double(movieModel.voteAverage ?? 0.0))")
        ratingView.text = "(\(movieModel.voteCount ?? 0))"
    }
}
