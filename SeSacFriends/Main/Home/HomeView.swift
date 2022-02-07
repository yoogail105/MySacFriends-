//
//  HomeView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/07.
//

import UIKit
import MapKit

class HomeView: BaseUIView {
    
    let mapView = MKMapView().then {
        $0.mapType = MKMapType.standard
        $0.isZoomEnabled = true
        $0.isScrollEnabled = true
    }

    
    
     override func addViews() {
        [mapView].forEach {
            addSubview($0)
        }
    }
    
    override func constraints() {
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configuration() {

    }
    
    
}
