//
//  EarthquakesViewModel.swift
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
    
    private var apiService          : EarthquakeApiService!
    private var events              = [EarthquakeViewData]()
    weak var delegate               : EarthquakesViewDelegate?
    weak var coordinatorDelegate    : EarthquakesViewModelCoordinatorDelegate?
    var dataSource                  : TableViewDataSource<EarthquakeTableViewCell,EarthquakeViewData>!
    private var publisher           : AnyCancellable?
    
    
    init(serive: EarthquakeApiService) {
        self.apiService = serive
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
            self?.events = collection.features.map({ EarthquakeViewData(event: $0) })
            self?.dataSource  = TableViewDataSource(items: self?.events ?? [], configureCell: { cell, earthquake in
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
        coordinatorDelegate?.open(url: self.events[indexPath.row].eventURL)
    }
}
