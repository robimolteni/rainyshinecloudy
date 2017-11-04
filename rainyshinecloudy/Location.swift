//
//  Location.swift
//  rainyshinecloudy
//
//  Created by robimolte on 02/11/2017.
//  Copyright © 2017 myself. All rights reserved.
//

import Foundation

class Location {
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
}
