//
//  EarthquakeViewData.swift
//  Earthquakes
//
//  Created by Praveen on 8/16/22.
//

import Foundation

protocol EarthquakeViewDataType {
    
    var title     : String { get }
    var eventTime : String { get }
    var eventURL  : String { get }
}

struct EarthquakeViewData: EarthquakeViewDataType {
    
    var title       : String
    var eventTime   : String
    var eventURL    : String
    
    init(event: Feature) {
        self.title = event.properties.title
        self.eventTime = Date.init(timeIntervalSince1970: event.properties.time/1000).string(DateFormats.eventDate)
        self.eventURL  = event.properties.url
    }
}
