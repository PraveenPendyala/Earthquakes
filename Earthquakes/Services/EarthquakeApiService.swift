//
//  EarthquakeApiService.swift
//  Earthquakes
//
//  Created by Praveen on 8/9/22.
//

import Foundation
import Combine

class EarthquakeApiService: NSObject {
    
    let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
}

extension EarthquakeApiService {
    
    func getEarthQuakeData<T:Decodable>(type: T.Type, _ from: Date = Date().date(byAddingDays: -30), _ to: Date = Date()) -> AnyPublisher<T, Error> {
        
        let url = URL(string: "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=\(from.string())&endtime=\(to.string())")!
        return apiClient.GET(type: T.self, url, queue: .main)
    }
    
}
