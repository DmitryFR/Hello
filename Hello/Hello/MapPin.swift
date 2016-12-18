//
//  MapPin.swift
//  Hello
//
//  Created by Дмитрий Фролов on 18.12.16.
//  Copyright © 2016 Дмитрий Фролов. All rights reserved.
//

import UIKit
import MapKit
class MapPin: NSObject, MKAnnotation {
    private var coord: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var coordinate: CLLocationCoordinate2D{
        get{
            return coord
        }
    }

    var title: String? = ""
    var subtitle: String? = ""
    func setCoordinate(newCoord:CLLocationCoordinate2D){
        self.coord = newCoord
    }
    
    
}
