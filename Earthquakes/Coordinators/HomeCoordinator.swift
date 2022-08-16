//
//  HomeCoordinator.swift
//  Earthquakes
//
//  Created by Praveen on 8/15/22.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let apiClient           : ApiClient
    let rootViewController  : UINavigationController
    
    var earthQuakesViewModel: EarthquakesViewModel {
        let earthquakeService   = EarthquakeApiService(apiClient: apiClient)
        let viewModel = EarthquakesViewModel(serive: earthquakeService)
        viewModel.coordinatorDelegate = self
        return viewModel
    }
    
    init(rootViewController: UINavigationController, apiClient: ApiClient) {
        self.rootViewController = rootViewController
        self.apiClient          = apiClient
    }
    
    override func start() {
        let earthquakesVC = EarthquakesViewController.instantiateFromStoryboard()
        earthquakesVC.viewModel = earthQuakesViewModel
        rootViewController.setViewControllers([earthquakesVC], animated: false)
    }
}


extension HomeCoordinator: EarthquakesViewModelCoordinatorDelegate {
    func open(url: String) {
        if let url = URL(string: url), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}
