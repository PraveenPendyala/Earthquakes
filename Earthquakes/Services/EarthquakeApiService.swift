//
//  EarthquakeApiService.swift
//  Earthquakes
//
//  Created by Praveen on 8/9/22.
//

import Foundation
import Combine

class EarthquakeApiService: NSObject {
    
    func getEarthQuakeData<T:Decodable>(type: T.Type, _ from: Date = Date().date(byAddingDays: -30), _ to: Date = Date()) -> AnyPublisher<T, Error> {
        
        let url = URL(string: "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=\(from.string())&endtime=\(to.string())")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ (data, response) in
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
