//
//  Storyboard+Utility.swift
//  FitApp
//
//  Created by Michael Hayashi on 7/26/18.
//  Copyright © 2018 Michael Hayashi. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum MGType: String {
        case login
        case Tabbar
        
        var fileName: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(type: MGType, bundle: Bundle? = nil) {
        self.init(name: type.fileName, bundle: bundle)
    }
    
    static func initialViewController(for type: MGType) -> UIViewController {
        
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.fileName) storyboard.")
        }
        return initialViewController
        
    }
    
}
