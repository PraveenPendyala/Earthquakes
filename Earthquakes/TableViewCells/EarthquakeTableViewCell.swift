//
//  EarthquakeTableViewCell.swift
//  Earthquakes
//
//  Created by Praveen on 8/13/22.
//

import Foundation
import UIKit

final class EarthquakeTableViewCell: UITableViewCell {
    
    
    // MARK: -
    // MARK: IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func configure(_ event: Feature) {
        self.titleLabel.text = event.properties.title
        self.subTitleLabel.text = Date.init(timeIntervalSince1970: event.properties.time/1000).string(DateFormats.eventDate)
    }
    
}
