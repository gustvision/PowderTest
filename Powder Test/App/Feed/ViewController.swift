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
        
        viewModel.fetch()
    }
}

extension ViewController: FeedViewModelDelegate {
    func refresh() {
        print("refresh")
    }
    
    func showError() {
        print("error")
    }
}

