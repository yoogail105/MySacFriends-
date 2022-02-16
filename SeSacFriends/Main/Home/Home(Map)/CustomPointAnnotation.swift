//
//  class CustomPointAnnotation
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/13.
//

import Foundation
import MapKit

class CustomPointAnnotation: NSObject, MKAnnotation {
    static let identifier = "CustomPointAnnotation"
    
    var coordinate: CLLocationCoordinate2D
    var imageName: String
    
    init(coordinate: CLLocationCoordinate2D, imageName: String) {
        self.coordinate = coordinate
        self.imageName = imageName
    }
    
    
}


