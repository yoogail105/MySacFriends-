//
//  HomeViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/27.
//


import UIKit
import MapKit
import CoreLocation
import RxSwift
import RxCocoa
import SnapKit

class HomeViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    let viewModel = AuthViewModel()
    let mainView = HomeView()
    let disposeBag = DisposeBag()
    
    var mapView: MKMapView?
    let locationManager = CLLocationManager()
    
    var defaultCoordinate = CLLocationCoordinate2D(latitude: 37.51818789942772, longitude: 126.88541765534976)
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUser() // 유저 상태 체크하기
        
        mapView = mainView.mapView
        mapView?.center = mainView.center
        
        let navigationController = self.navigationController
        coordinator = MainCoordinator(navigationController: navigationController!, parentCoordinator: coordinator)
        
        // 싹 영등포 캠퍼스 주변: 37.51786407953752, 126.88672749597067
        // mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.51786407953752, longitude: 126.88672749597067), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView?.showsUserLocation = true
        defaultCoordinate = setUserLocation(latitudeValue: 37.51786407953752, longitudeValue: 126.88672749597067, delta: 0.01)
        
        bind()
    }
    
    func bind() {
        mainView.gpsButton.rx.tap
            .bind {
                self.findMyLocation()
            }
            .disposed(by: disposeBag)
    }
    
    func checkUser() {
        print("")
        viewModel.onErrorHandling = { error in
            if error == .notAcceptable {
                UserDefaults.standard.startMode = StartMode.auth.rawValue
                print("로그인 새로 해야함")
                self.coordinator?.pushToAuthSignUp()
                // 토스트 메세지: 로그인을 해주세요
            } else if error == .unAuthorized {
                print("errorHandling: 로그인 새로 해야함")
                self.coordinator?.pushToAuthSignUp()
            }
        }
        self.viewModel.getUser()
    }
    
    private func setUserLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        
        let locationValue = CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let region = MKCoordinateRegion(center: locationValue, span: spanValue)
        mapView?.setRegion(region, animated: true)
        return locationValue
    }
    
    private func addUserPin() {
        let pin = MKPointAnnotation()
        pin.coordinate = defaultCoordinate
        mapView?.addAnnotation(pin)
    }
    
    private func findMyLocation() {
        guard let currentLocation = locationManager.location else {
            print("위치 접근권한 허용안함")
            requestLocationPermissionAlert()
            return
        }
        
        mapView?.showsUserLocation = true
        mapView?.setUserTrackingMode(.follow, animated: true)
    }
    func requestLocationPermissionAlert() {
        let alertView = mainView.requestLocationPermissionAlertView
        view.addSubview(alertView)
        alertView.backgroundColor = .clear
        alertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        alertView.isUserInteractionEnabled = true
        alertView.cancelButton.rx.tap
            .bind{
                print("zmfflr")
                alertView.removeFromSuperview()
            }
            .disposed(by: disposeBag)
        
        alertView.okButton.rx.tap
            .bind {
                self.moveToSetting()
                alertView.removeFromSuperview()
            }
    }
    
    func moveToSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url) { success in
            }
        }
    }
    
    
    
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func reddquestLocationPermissionAlert() {

//        showAlert(title: "위치 서비스를 사용할 수 없습니다.", message: "지도에서 내 위치를 확인하여 정확한 날씨 정보를 얻기 위해 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.", okTitle: "허용하기") {
//            guard let url = URL(string: UIApplication.openSettingsURLString) else {
//                return
//            }
//            if UIApplication.shared.canOpenURL(url){
//                UIApplication.shared.open(url) { success in
//                }
//            }
//
//        }
    }
    
    
    func checkUsersLocationServicesAuthorization(authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            self.locationManager.startUpdatingLocation()
        case .restricted, .notDetermined:
            print("GPS 권한 설정되지 않음")
            getLocationUsagePermission()
        case .denied:
            print("GPS 권한 요청 거부됨")
            requestLocationPermissionAlert()
        default:
            print("GPS: Default")
        }
        
        if #available(iOS 14.0, *) {
            let accuracyState = locationManager.accuracyAuthorization
            switch accuracyState {
            case .fullAccuracy:
                print("full")
            case .reducedAccuracy:
                print("reduced")
            @unknown default:
                print("Unknown")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[locations.count - 1]
        let longitude: CLLocationDegrees = location.coordinate.longitude
        let latitude: CLLocationDegrees = location.coordinate.latitude
    }
    

}
