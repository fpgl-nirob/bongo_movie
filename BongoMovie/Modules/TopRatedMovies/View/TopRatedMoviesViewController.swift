//
//  ViewController.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import UIKit
import SnapKit

class TopRatedMoviesViewController: BaseViewController, Alertable {
    
    private lazy var moviesCollectionView: UICollectionView = {
        let collectionV = UIView.createCollectionView(delegate: self, dataSource: self)
        collectionV.collectionViewLayout = TopRatedMoviesFlowLayout()
        collectionV.register(TopRatedMovieCell.self, forCellWithReuseIdentifier: TopRatedMovieCell.cellIdentifier)
        collectionV.backgroundColor = .clear
        collectionV.isScrollEnabled = true
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        return collectionV
    }()
    
    private let hintLbl: UILabel = {
        let lbl = UIView.createLabel(text: .translate_id_0007)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.textAlignment = .center
        lbl.textColor = .lightGray
        lbl.font = .InterRegular(ofSize: 14.s)
        return lbl
    }()
    
    var refreshController = UIRefreshControl()
    private var viewModel = TopRatedMoviesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: .languageChangedNotification, object: nil)
        
        addSubViews()
        setupRefreshController()
        setupLayout()
        loadServerData()
    }
    
    deinit {
        print("deinit search vc")
        NotificationCenter.default.removeObserver(self, name: .languageChangedNotification, object: nil)
    }
    
    @objc func languageChanged(notification: NSNotification) {
        updateNavbarTitle(title: .translate_id_0005)
        hintLbl.text = AppTexts.translate_id_0007.rawValue.tr
    }
    
    private func addSubViews() {
        setupNavBar(title: .translate_id_0005, rightBtnImgName: AppImages.settings.rawValue, rightButtonClicked: {[weak self] in
            let vc = SettingsViewController()
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(vc, animated: true)
        })
        
        [hintLbl, moviesCollectionView].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    private func setupRefreshController() {
        moviesCollectionView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    private func setupLayout() {
        
        hintLbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        moviesCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2.s)
            make.trailing.equalToSuperview().offset(-2.s)
            make.top.equalToSuperview().offset(navBarHeight)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
    
    private func loadServerData() {
        self.showHUD()
        viewModel.getMovieList {[weak self] message, error in
            self?.hideHUD()
            self?.hintLbl.isHidden = true
            if let error = error {
                self?.showAlert(message: error)
            } else {
                self?.moviesCollectionView.reloadData()
            }
        }
    }
    
    @objc func handleRefresh() {
        viewModel.getMovieList {[weak self] message, error in
            self?.refreshController.endRefreshing()
            if let error = error {
                self?.hintLbl.isHidden = false
                self?.showAlert(message: error)
            } else {
                self?.hintLbl.isHidden = true
                self?.moviesCollectionView.reloadData()
            }
        }
    }
}

extension TopRatedMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("you select at: \(indexPath.row)")
        let vc = MovieDetailsViewController()
        vc.movieId = viewModel.movieModels[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension TopRatedMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedMovieCell.cellIdentifier, for: indexPath) as? TopRatedMovieCell else {
            fatalError("TopRatedMovieCell is not initialized")
        }
        cell.setupCell(indexPath: indexPath, movieModel: viewModel.movieModels[indexPath.item])
        return cell
    }
}

extension TopRatedMoviesViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        guard distanceFromBottom < height && viewModel.totalPages >= viewModel.page else { return }
        
        if !viewModel.apiCalling {
            viewModel.apiCalling = true
            showHUD()
            viewModel.loadMoreMovies {[weak self] message, error in
                self?.viewModel.apiCalling = false
                self?.hideHUD()
                if let error = error {
                    self?.showAlert(message: error)
                } else {
                    self?.moviesCollectionView.reloadData()
                }
            }
        }
    }
}

