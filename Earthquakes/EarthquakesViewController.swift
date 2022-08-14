//
//  ViewController.swift
//  Earthquakes
//
//  Created by Praveen on 8/9/22.
//

import UIKit

final class EarthquakesViewController: UIViewController {

    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet weak var earthQuakesTableView: UITableView!
    
    
    // MARK: -
    // MARK: Properties
    
    private var viewModel: FeatureViewModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = FeatureViewModel()
        self.earthQuakesTableView.delegate = viewModel
        EarthquakeTableViewCell.register(with: earthQuakesTableView)
        self.earthQuakesTableView.refreshControl = UIRefreshControl()
        self.earthQuakesTableView.refreshControl?.beginRefreshing()
        self.earthQuakesTableView.refreshControl?.addTarget(self, action: #selector(refershData), for: .valueChanged)
        self.viewModel.bindViewModelToController = {
            self.earthQuakesTableView.dataSource = self.viewModel.dataSource
            self.earthQuakesTableView.reloadData()
            self.earthQuakesTableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc private func refershData() {
        self.earthQuakesTableView.refreshControl?.beginRefreshing()
        self.viewModel.getEarthQuakeData()
    }
}

