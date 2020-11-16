//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import MapKit
//
import DomainCarTrack

class CarTrackMKAnnotation: NSObject, MKAnnotation {

    let model: CarTrackAppModel.User
    let title: String?
    let subTitle: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String, subTitle: String, coordinate: CLLocationCoordinate2D, model: CarTrackAppModel.User) {
        self.title = title
        self.subTitle = subTitle
        self.coordinate = coordinate
        self.model = model
        super.init()
    }
}
