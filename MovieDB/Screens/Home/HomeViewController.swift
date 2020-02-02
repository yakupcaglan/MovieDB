//
//  HomeViewController.swift
//  MovieDB
//
//  Created by yakup caglan on 29.01.2020.
//  Copyright © 2020 yakup caglan. All rights reserved.
//

import UIKit

class HomeViewController: LayoutingViewController, UINavigationControllerDelegate {
    
    typealias ViewType = HomeView
    
    private let viewModel: HomeViewModel
    
    private var hasFavorited: Bool = false
    
    private var collectionView: UICollectionView {
        return layoutableView.collectionView
    }
    
    override func loadView() {
        super.loadView()
        
        view = ViewType.create()
    }
    
    public required init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "TV Shows"
        
        viewModel.delegate = self
        viewModel.fetchPopulerTVShows()
        
        layoutableView.refreshButton.addTarget(self, action: #selector(refreshTVShows), for: .touchUpInside)
        navigationController?.navigationBar.isTranslucent = false
        
        checkNewPopulerTVShow()
        
        self.navigationController?.delegate = self
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    @objc func refreshTVShows() {
        self.collectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .top, animated: true)
        
        UIView.animate(withDuration: 0.5) {
            self.layoutableView.refreshButton.alpha = 0.0
            self.layoutableView.refreshButton.center.y = 0
        }
        
        viewModel.fetchPopulerTVShows()
    }
    
    private func checkNewPopulerTVShow() {
        
        
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { (timer) in
            let refreshButton = self.layoutableView.refreshButton
           
            var updateItems = self.viewModel.checkNewPopulerTvShows()
            
            if updateItems > 0 {
                guard refreshButton.alpha <= 0.0 else {
                        return
                }
                UIView.animate(withDuration: 0.5) {
                    refreshButton.alpha = 1.0
                    refreshButton.center.y = 32
                }
            }
            updateItems = 0
        }
    }
    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
         switch operation {
         case .push:
            return CustomAnimator(isPresenting: true)
         default:
            return CustomAnimator(isPresenting: false)
         }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: TVShowCell = collectionView.dequeueReusableCell(formIndexPath: indexPath)
        cell.item = viewModel.item(by: indexPath.row)
        
        cell.starButton.tag = indexPath.row
        cell.starButton.addTarget(self, action: #selector(handleFavorite), for: .touchUpInside)
        return cell
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print("awdawdwadwada")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 32 , height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TVShowCell else {
            return
        }
        
        guard let item = cell.item else {
            return
        }

        let container = DependencyContainer()
        
        let detailViewController = container.makeDetailViewController(tvShowID: item.id)
        
        navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
    @objc func handleFavorite(sender: UIButton) {
        hasFavorited = !hasFavorited
        hasFavorited ? (sender.tintColor = UIColor.imdbColor) : (sender.tintColor = UIColor.lightGray)
        viewModel.favoriteStatus(at: sender.tag, hasFavorited)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        guard indexPath.row >= viewModel.numberOfItems - 1 else { return }
        
        viewModel.isRefreshing = true
    }
}

extension HomeViewController: HomeViewModelDelegate {
   
    func refreshStateDidChange() {
        viewModel.fetchPopulerTVShows()
    }

    func itemsDidLoad() {
        viewModel.isRefreshing = false
        layoutableView.collectionView.reloadData()
    }
}
