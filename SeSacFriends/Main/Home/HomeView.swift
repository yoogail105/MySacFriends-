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

    let placeButton = UIButton().then {
        $0.setImage(UIImage(named: AssetIcon.place.rawValue), for: .normal)
    }
    
    let searchButton = UIButton().then {
        $0.setImage(UIImage(named: AssetIcon.search.rawValue), for: .normal)
        
    }
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    
    let allButton = UIButton().then {
        $0.setTitle("전체", for: .normal)
    }
    
    let womanButton = UIButton().then {
        $0.setTitle("여자", for: .normal)
    }
    
    let manButton = UIButton().then {
        $0.setTitle("남자", for: .normal)
    }
    
    
    let roundButton = UIButton().then {
        $0.layer.cornerRadius = 32
        $0.clipsToBounds = true
        $0.setImage(UIImage(named: AssetIcon.search.rawValue), for: .normal)
        
    }
    
    
     override func addViews() {
        [mapView, allButton].forEach {
            addSubview($0)
        }
         
         [allButton, womanButton, manButton].forEach {
             stackView.addSubview($0)
         }
         
         stackView.snp.makeConstraints {
             $0.top.equalTo(self.safeAreaLayoutGuide).offset(17)
             $0.leading.equalToSuperview().offset(16)
             $0.height.equalTo(144)
             $0.width.equalTo(48)
         }
         
         placeButton.snp.makeConstraints {
             $0.top.equalTo(stackView.snp.bottom).offset(16)
         }
         
         
         
         roundButton.snp.makeConstraints {
             $0.height.width.equalTo(64)
             $0.trailing.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
         }
    }
    
    
    
    override func constraints() {
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        placeButton.snp.makeConstraints {
            $0.height.width.equalTo(48)
            
        }
        
        searchButton.snp.makeConstraints {
            $0.height.width.equalTo(40)
        }
    }
    
    override func configuration() {
    }
    
    
}
