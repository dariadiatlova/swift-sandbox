//
//  Locations.swift
//  daryouush-first-swift-app
//
//  Created by Daria on 11.02.2022.
//

import Foundation

class Locations: ObservableObject {
    let places: [Location]
    
    var primary: Location {
        places[0]
    }
    
    var secondary: Location {
        places[1]
    }
    
    init() {
        let url = Bundle.main.url(forResource: "locations", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        places = try! JSONDecoder().decode([Location].self, from: data)
    }
}
