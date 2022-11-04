//
//  MovieDetailsViewController.swift
//  ELogy
//
//  Created by mac 2019 on 03/11/2022.
//

import UIKit
import SnapKit
import SDWebImage

class MovieDetailsViewController: BaseViewController, Alertable {

    private lazy var scrollView: UIScrollView = {
        let scrollV = UIView.createScrollView(delegate: nil)
        scrollV.backgroundColor = UIColor.clear
        return scrollV
    }()
    
    private lazy var containerView: UIView = {
        let containerV = UIView.createView()
        containerV.backgroundColor = UIColor.clear
        return containerV
    }()
    
    private let posterImageView: UIImageView = {
        let imgV = UIView.createImageView(imageName: .transparent)
        imgV.tag = 0
        imgV.contentMode = .scaleAspectFit
        return imgV
    }()
    
    private let backdropImageView: UIImageView = {
        let imgV = UIView.createImageView(imageName: .transparent)
        imgV.tag = 0
        imgV.contentMode = .scaleToFill
        return imgV
    }()
    
    private let titleLbl: UILabel = {
        let lbl = UIView.createLabel("")
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = .InterBold(ofSize: 18.s)
        return lbl
    }()
    
    private let circularProgressView: CircularProgressBar = {
        let circularPV = CircularProgressBar()
        circularPV.labelSize = 14.sp
        circularPV.labelPercentSize = 10.sp
        circularPV.labelCompleteSize = 0.0
        circularPV.safePercent = 100
        circularPV.lineWidth = 5.s
        circularPV.backgroundColor = .clear
        return circularPV
    }()
    
    private let userScoreLbl: UILabel = {
        let lbl = UIView.createLabel("User Score")
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.font = .InterBold(ofSize: 12.s)
        return lbl
    }()
    
    private let releaseLbl: UILabel = {
        let lbl = UIView.createLabel("")
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        lbl.textColor = .white
        lbl.font = .InterBold(ofSize: 12.s)
        return lbl
    }()
    
    private let taglineLbl: UILabel = {
        let lbl = UIView.createLabel("")
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.textColor = .lightGray
        lbl.font = .italicSystemFont(ofSize: 12.sp)
        return lbl
    }()
    
    private let overviewTitleLbl: UILabel = {
        let lbl = UIView.createLabel("Overview")
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.font = .InterBold(ofSize: 18.s)
        return lbl
    }()
    
    private let overviewDescLbl: UILabel = {
        let lbl = UIView.createLabel("")
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .left
        lbl.textColor = .white
        lbl.font = .InterRegular(ofSize: 12.s)
        return lbl
    }()
    
    public var movieId: Int!
    private lazy var viewModel: MovieDetailsViewModel = {
       let viewM = MovieDetailsViewModel()
        viewM.movieId = self.movieId
        return viewM
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .detailBG
        
        addSubViews()
        setupLayout()
        loadServerData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func addSubViews() {
        setupNavBar(title: .translate_id_0008, backButtonClicked: {[weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        [backdropImageView, posterImageView, titleLbl, circularProgressView, userScoreLbl, releaseLbl, taglineLbl, overviewTitleLbl, overviewDescLbl].forEach { view in
            containerView.addSubview(view)
        }
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
        
        backdropImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.s)
            make.trailing.equalToSuperview().offset(-0.s)
            make.height.equalTo(200.s)
            make.width.equalTo(SizeConfig.screenWidth*0.75)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45.s)
            make.leading.equalToSuperview().offset(0.s)
            make.height.equalTo(150.s)
            make.width.equalTo(150.s)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom).offset(20.s)
            make.leading.equalToSuperview().offset(20.s)
            make.trailing.equalToSuperview().offset(-20.s)
        }
        
        circularProgressView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(20.s)
            make.leading.equalToSuperview().offset(40.s)
            make.width.equalTo(50.s)
            make.height.equalTo(50.s)
        }
        
        userScoreLbl.snp.makeConstraints { make in
            make.leading.equalTo(circularProgressView.snp.trailing).offset(10.s)
            make.centerY.equalTo(circularProgressView.snp.centerY)
        }
        
        releaseLbl.snp.makeConstraints { make in
            make.top.equalTo(circularProgressView.snp.bottom).offset(20.s)
            make.leading.equalToSuperview().offset(20.s)
            make.trailing.equalToSuperview().offset(-20.s)
        }
        
        taglineLbl.snp.makeConstraints { make in
            make.top.equalTo(releaseLbl.snp.bottom).offset(20.s)
            make.leading.equalToSuperview().offset(20.s)
            make.trailing.equalToSuperview().offset(-20.s)
        }
        
        overviewTitleLbl.snp.makeConstraints { make in
            make.top.equalTo(taglineLbl.snp.bottom).offset(20.s)
            make.leading.equalToSuperview().offset(20.s)
            make.trailing.equalToSuperview().offset(-20.s)
        }
        
        overviewDescLbl.snp.makeConstraints { make in
            make.top.equalTo(overviewTitleLbl.snp.bottom).offset(10.s)
            make.leading.equalToSuperview().offset(20.s)
            make.trailing.equalToSuperview().offset(-20.s)
            make.bottom.equalToSuperview().offset(-100.s)
        }
    }
    
    private func loadServerData() {
        viewModel.getMovieDetails(onResult: {[weak self] message, error in
            self?.setupData()
        })
    }
    
    private func setupData() {
        let attrText1 = NSMutableAttributedString(string: viewModel.movieDetails?.title ?? "", attributes:
                                                    [.foregroundColor: UIColor.white])
        let text2 = "  (\(viewModel.movieDetails?.releaseDate?.convertTo(informat: DateFormatConstants.yyyy_mm_dd, outformat: DateFormatConstants.yyyy) ?? ""))"
        let attrText2 = NSAttributedString(string: text2, attributes:
                                            [.foregroundColor: UIColor.lightGray])
        attrText1.append(attrText2)
        titleLbl.attributedText = attrText1
        
        backdropImageView.sd_setImage(with: viewModel.movieDetails?.backdropUrl, placeholderImage: UIImage(named: AppImages.transparent.rawValue))
        posterImageView.sd_setImage(with: viewModel.movieDetails?.posterUrl, placeholderImage: UIImage(named: AppImages.transparent.rawValue))
        circularProgressView.setProgress(to: Double(viewModel.movieDetails?.popularity ?? 0.0)/100.0, withAnimation: false)
        releaseLbl.text = viewModel.getReleaseText()
        taglineLbl.text = viewModel.movieDetails?.tagline
        overviewDescLbl.text = viewModel.movieDetails?.overview
    }
    
    @objc func featureImgClicked(gesture: UITapGestureRecognizer) {
        
    }
    
    @objc func buyBtnClicked(sender: UIButton) {
        self.showAlert(message: "Buy option is not implemented currently")
    }
}
