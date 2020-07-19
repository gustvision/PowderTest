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
        collectionViewLayout.scrollDirection = .vertical
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
    
}

extension ViewController: FeedViewModelDelegate {
    func refresh() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showError() {
        print("error")
    }
}

