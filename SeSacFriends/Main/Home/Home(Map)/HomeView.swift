//
//  HomeView.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/07.
//

import UIKit
import MapKit

class HomeView: BaseUIView {
    
    var manAnnotations: [MKAnnotation] = []
    var womanAnnotations: [MKAnnotation] = []

    
    let mapView = MKMapView().then {
        $0.mapType = MKMapType.standard
        $0.isZoomEnabled = true
        $0.isScrollEnabled = true
    }

    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 0
        $0.alignment = .fill
        $0.distribution = .fillEqually
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.addShadow()
    }
    
    
    let totalButton = BaseButton().then {
        $0.tag = 2
        $0.buttonMode(.fill, title: ButtonTitle.all.rawValue)
        $0.titleLabel?.font = UIFont().Title4_R14
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    let manButton = UIButton().then {
        $0.tag = 1
        $0.buttonMode(.white, title: ButtonTitle.man.rawValue)
        $0.titleLabel?.font = UIFont().Title4_R14
    }
    
    let womanButton = BaseButton().then {
        $0.tag = 0
        $0.buttonMode(.white, title: ButtonTitle.woman.rawValue)
        $0.titleLabel?.font = UIFont().Title4_R14
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
    
    let gpsButton = BaseButton().then {
        $0.setImage(UIImage(named: AssetIcon.place.rawValue), for: .normal)
        $0.backgroundColor = .white
        $0.addShadow()
        $0.imageEdgeInsets = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    }
    
    let floatingButton = UIButton().then {
    
        var matchingStatus = MatchingStatus(rawValue: UserDefaults.standard.matchingStatus!)
        var imageName = ""
        
        switch matchingStatus {
        case .ing:
            imageName = homeIcon.finding.rawValue
        case .done:
            imageName = homeIcon.message.rawValue
        default:
            imageName = homeIcon.search.rawValue
        }
        
        $0.setImage(UIImage(named: imageName), for: .normal)
        $0.addShadow()
    }
    
    let marker = UIImageView().then {
        $0.image = UIImage(named: homeIcon.marker.rawValue)
    }
    
    var requestLocationPermissionAlertView = AlertView().then {
        $0.title.text = AlertText.requestLocationPermissionTitle.rawValue
        $0.subTitle.text = AlertText.requestLocationPermissionSubtitle.rawValue
        $0.okButton.setTitle(AlertText.moveToSetting.rawValue, for: .normal)
    }
    
    
    override func configuration() {
        
    }
    
     override func addViews() {
    
        [mapView, stackView, gpsButton, floatingButton, marker].forEach {
            addSubview($0)
        }
         
         [totalButton, manButton, womanButton].forEach {
             stackView.addArrangedSubview($0)
         }
        
    }
    
    
    
    override func constraints() {
        
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(17)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(144)
            $0.width.equalTo(48)
        }
        
        gpsButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(16)
            $0.leading.equalTo(stackView.snp.leading)
            $0.width.height.equalTo(48)
        }
        
        floatingButton.snp.makeConstraints {
            $0.height.width.equalTo(64)
            $0.trailing.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
        }
        
        marker.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.height.width.equalTo(48)
        }
    }
    

}
