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
    
    @IBOutlet weak var titleLabel       : UILabel!
    @IBOutlet weak var subTitleLabel    : UILabel!
    
    func configure(_ event: EarthquakeViewData) {
        self.titleLabel.text    =  event.title
        self.subTitleLabel.text =  event.eventTime
    }
    
}
