//
//  FeaturesViewModel.swift
//  Earthquakes
//
//  Created by Praveen on 8/13/22.
//

import Foundation
import Combine
import UIKit

protocol FeatureViewModelDelegate: NSObjectProtocol {
    func reloadUI()
    func loadFailed()
}

class FeatureViewModel: NSObject {
    
    private var apiService: APIService!
    private var collection: FeatureCollection!
    weak var delegate: FeatureViewModelDelegate?
    var dataSource : TableViewDataSource<EarthquakeTableViewCell,Feature>!
    private var publisher: AnyCancellable?
    
    override init() {
        super.init()
        self.apiService = APIService()
        self.getEarthQuakeData()
    }
    
    @objc func getEarthQuakeData() {
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

extension FeatureViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let url = URL(string: self.collection.features[indexPath.row].properties.url),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}