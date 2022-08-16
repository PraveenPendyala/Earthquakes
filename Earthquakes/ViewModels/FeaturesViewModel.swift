//
//  FeaturesViewModel.swift
//  Earthquakes
//
//  Created by Praveen on 8/13/22.
//

import Foundation
import Combine
import UIKit

protocol EarthquakesViewDelegate: NSObjectProtocol {
    func reloadUI()
    func loadFailed()
}

protocol EarthquakesViewModelCoordinatorDelegate: NSObjectProtocol {
    func open(url: String)
}

class EarthquakesViewModel: NSObject {
    
    private var apiService          : APIService!
    private var collection          : FeatureCollection!
    weak var delegate               : EarthquakesViewDelegate?
    weak var coordinatorDelegate    : EarthquakesViewModelCoordinatorDelegate?
    var dataSource                  : TableViewDataSource<EarthquakeTableViewCell,Feature>!
    private var publisher           : AnyCancellable?
    
    
    init(serive: APIService) {
        self.apiService = APIService()
    }
    
    func start() {
        getEarthQuakeData()
    }
    
    func getEarthQuakeData() {
        self.publisher = self.apiService.getEarthQuakeData(type: FeatureCollection.self).sink {  [weak self] completion in
            if case .failure(let error) = completion {
                print("Failed with error \(error)")
                self?.delegate?.loadFailed()
            }
        } receiveValue: { [weak self] collection in
            self?.collection = collection
            self?.dataSource  = TableViewDataSource(items: collection.features, configureCell: { cell, earthquake in
                cell.configure(earthquake)
            })
            self?.delegate?.reloadUI()
        }
    }
}

extension EarthquakesViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinatorDelegate?.open(url: self.collection.features[indexPath.row].properties.url)
    }
}
