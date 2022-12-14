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
    
    var viewModel: EarthquakesViewModel!
    
    
    // MARK: -
    // MARK: View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.earthQuakesTableView.delegate = viewModel
        self.viewModel.delegate            = self
        EarthquakeTableViewCell.register(with: earthQuakesTableView)
        self.earthQuakesTableView.refreshControl = UIRefreshControl()
        self.earthQuakesTableView.refreshControl?.beginRefreshing()
        self.viewModel.start()
        self.earthQuakesTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshData))
    }
    
    @objc private func refreshData() {
        self.earthQuakesTableView.refreshControl?.beginRefreshing()
        self.viewModel.getEarthQuakeData()
    }
}

extension EarthquakesViewController: EarthquakesViewDelegate {
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
