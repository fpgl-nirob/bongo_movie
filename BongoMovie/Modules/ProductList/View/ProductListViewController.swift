//
//  ViewController.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import UIKit

class ProductListViewController: BaseViewController, Alertable {
    
    private lazy var photoCollectionView: UICollectionView = {
        let collectionV = UIView.createCollectionView(delegate: self, dataSource: nil)
        collectionV.collectionViewLayout = ProductListFlowLayout()
        collectionV.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.cellIdentifier)
        collectionV.backgroundColor = .clear
        collectionV.isScrollEnabled = true
        collectionV.showsVerticalScrollIndicator = false
        collectionV.showsHorizontalScrollIndicator = false
        return collectionV
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchB = UISearchBar()
        searchB.delegate = self
        searchB.backgroundColor = .background
        searchB.barTintColor = .background
        searchB.setBackgroundImage(UIImage(named: AppImages.transparent.rawValue), for: .any, barMetrics: .default)
        searchB.placeholder = AppTexts.translate_id_0006.rawValue.tr
        searchB.translatesAutoresizingMaskIntoConstraints = false
        return searchB
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
    
    // MARK: - Value Types
    typealias DataSource = UICollectionViewDiffableDataSource<ProductListViewModel.Section, ProductModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<ProductListViewModel.Section, ProductModel>
    
    private lazy var dataSource = makeDataSource()
    private var viewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(languageChanged), name: .languageChangedNotification, object: nil)
        
        addSubViews()
        setupRefreshController()
        setupLayout()
    }
    
    deinit {
        print("deinit search vc")
        NotificationCenter.default.removeObserver(self, name: .languageChangedNotification, object: nil)
    }
    
    @objc func languageChanged(notification: NSNotification) {
        updateNavbarTitle(title: .translate_id_0005)
        searchBar.placeholder = AppTexts.translate_id_0006.rawValue.tr
        hintLbl.text = AppTexts.translate_id_0007.rawValue.tr
    }
    
    private func addSubViews() {
        setupNavBar(title: .translate_id_0005, rightBtnImgName: AppImages.settings.rawValue, rightButtonClicked: {[weak self] in
            let vc = SettingsViewController()
            vc.hidesBottomBarWhenPushed = true
            self?.navigationController?.pushViewController(vc, animated: true)
        })
        
        [searchBar, hintLbl, photoCollectionView].forEach { view in
            self.view.addSubview(view)
        }
    }
    
    private func setupRefreshController() {
        photoCollectionView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    private func setupLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(navBarHeight)
            make.centerX.equalToSuperview()
            make.height.equalTo(40.s)
            make.width.equalTo(335.s)
        }
        
        hintLbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        photoCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2.s)
            make.trailing.equalToSuperview().offset(-2.s)
            make.top.equalTo(searchBar.snp.bottom).offset(4.s)
            make.bottom.equalTo(view.snp.bottomMargin)
        }
    }
    
    private func loadServerData() {
        self.showHUD()
        viewModel.searchProduct {[weak self] message, error in
            self?.hideHUD()
            self?.hintLbl.isHidden = true
            if let error = error {
                self?.showAlert(message: error)
            } else {
                self?.applySnapshot(animatingDifferences: false)
            }
        }
    }
    
    @objc func handleRefresh() {
        guard !viewModel.searchText.isEmpty else {
            refreshController.endRefreshing()
            return
        }
        viewModel.searchProduct {[weak self] message, error in
            self?.refreshController.endRefreshing()
            if let error = error {
                self?.hintLbl.isHidden = false
                self?.showAlert(message: error)
            } else {
                self?.hintLbl.isHidden = true
                self?.applySnapshot(animatingDifferences: true)
            }
        }
    }
    
    // MARK: - DataSource
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: photoCollectionView, cellProvider: { (collectionView, indexPath, productModel) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.cellIdentifier, for: indexPath) as? ProductCell else {
                fatalError("ProductCell is not initialized properly")
            }
            cell.setupCell(indexPath: indexPath, productModel: productModel)
            return cell
        })
        return dataSource
    }
    
    func applySnapshot(animatingDifferences: Bool = true) {
        
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.productModels)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

extension ProductListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("you select at: \(indexPath.row)")
        let vc = ProductDetailsViewController()
        vc.productModel = viewModel.productModels[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ProductListViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        guard distanceFromBottom < height && viewModel.shouldLoadMoreData else { return }
        
        if !viewModel.apiCalling {
            viewModel.apiCalling = true
            showHUD()
            viewModel.loadMoreProduct {[weak self] message, error in
                self?.viewModel.apiCalling = false
                self?.hideHUD()
                if let error = error {
                    self?.showAlert(message: error)
                } else {
                    self?.applySnapshot(animatingDifferences: true)
                }
            }
        }
    }
}

extension ProductListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        loadServerData()
        photoCollectionView.setContentOffset(CGPoint.zero, animated: false)
    }
}

