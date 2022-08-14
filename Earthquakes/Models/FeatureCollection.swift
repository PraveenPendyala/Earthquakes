//
//  FeatureCollection.swift
//  Earthquakes
//
//  Created by Praveen on 8/10/22.
//

import Foundation

struct FeatureCollection: Decodable {
    var features: [Feature]
}

struct Feature: Decodable {
    var properties: FeatureProperty
}

struct FeatureProperty: Decodable {
    var title: String
    var url  : String
    var time : TimeInterval
}
