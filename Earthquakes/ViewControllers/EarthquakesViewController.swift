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
    
    fileprivate var viewModel: FeatureViewModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = FeatureViewModel()
        self.earthQuakesTableView.delegate = viewModel
        self.viewModel.delegate            = self
        EarthquakeTableViewCell.register(with: earthQuakesTableView)
        self.earthQuakesTableView.refreshControl = UIRefreshControl()
        self.earthQuakesTableView.refreshControl?.beginRefreshing()
        self.earthQuakesTableView.refreshControl?.addTarget(self, action: #selector(refershData), for: .valueChanged)
    }
    
    @objc private func refershData() {
        self.earthQuakesTableView.refreshControl?.beginRefreshing()
        self.viewModel.getEarthQuakeData()
    }
}

extension EarthquakesViewController: FeatureViewModelDelegate {
    func reloadUI() {
        self.earthQuakesTableView.dataSource = self.viewModel.dataSource
        self.earthQuakesTableView.reloadData()
        self.earthQuakesTableView.refreshControl?.endRefreshing()
    }
    
    func loadFailed() {
        self.earthQuakesTableView.refreshControl?.endRefreshing()
    }
}

extension EarthquakesViewController: StoryboardInitializable {
    static func instantiateFromStoryboard() -> EarthquakesViewController {
        return UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "EarthquakesViewController") as! EarthquakesViewController
    }
}
