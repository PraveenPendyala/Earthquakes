//
//  UIViewController+Extension.swift
//  Earthquakes
//
//  Created by Praveen on 8/14/22.
//

import UIKit

protocol StoryboardInitializable where Self: UIViewController {
    static func instantiateFromStoryboard() -> Self
}
