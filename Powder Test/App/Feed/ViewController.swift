//
//  ViewController.swift
//  Powder Test
//
//  Created by Charles Bessonnet on 19/07/2020.
//  Copyright © 2020 Charles Bessonnet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let viewModel = FeedViewModel()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.itemSize = UIScreen.main.bounds.size
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: String(describing: FeedCell.self))
        
        collectionView.dataSource   = self
        collectionView.delegate     = self
        
        collectionView.isPagingEnabled = true
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInterface()
        setupConstraints()
        viewModel.fetch()
    }
    
    // MARK: - Setup
    
    private func setupInterface() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FeedCell.self), for: indexPath) as? FeedCell else { fatalError() }
        
        cell.setup(viewModel: viewModel.cellViewModels[indexPath.row])
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? FeedCell)?.pause()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as? FeedCell)?.play()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.frame.width)
        
        if index == 0 {
            scrollTo(index: viewModel.cellViewModels.count - 2)
        } else if index == viewModel.cellViewModels.count - 1 {
            scrollTo(index: 1)
        }
    }
    
    private func scrollTo(index: Int) {
        let point = CGPoint(x: self.collectionView.frame.width * CGFloat(index), y: 0)
        self.collectionView.setContentOffset(point, animated: false)
    }
}

extension ViewController: FeedViewModelDelegate {
    func refresh() {
        DispatchQueue.main.async {
            if self.viewModel.cellViewModels.count >= 2 {
                self.scrollTo(index: 1)
            }
            self.collectionView.reloadData()
        }
    }
    
    func showError() {
        print("error")
    }
}

