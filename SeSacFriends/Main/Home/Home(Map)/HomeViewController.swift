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
import SwiftUI
import Moya

class HomeViewController: UIViewController {
    
    var coordinator: MainCoordinator?
    let viewModel = QueueViewModel()
    let mainView = HomeView()
    let disposeBag = DisposeBag()
    
  
    
    var mapView: MKMapView?
    let locationManager = CLLocationManager()
    var selectedGender: SelectedGender = .total
    
    
    var defaultCoordinate = CLLocationCoordinate2D(latitude: 37.51818789942772, longitude: 126.88541765534976)
    
    override func loadView() {
        print(#function)
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
        updateFriends(gender: viewModel.genderObservable.value)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        print("HomeViewController: \(#function)")
        checkUser() // 유저 상태 체크하기
        
        mapView = mainView.mapView
        mapView?.center = mainView.center
        mapView?.delegate = self
        
        let navigationController = self.navigationController
        coordinator = MainCoordinator(navigationController: navigationController!, parentCoordinator: coordinator)
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView?.showsUserLocation = true
        mapView?.setRegion(MKCoordinateRegion(center: defaultCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        bind()
    }
    
    func bind() {
        
        mainView.gpsButton.rx.tap
            .bind {
                self.findMyLocation()
            }
            .disposed(by: disposeBag)
        
        mainView.floatingButton.rx.tap
            .bind {
                self.updateFriends(gender: self.viewModel.genderObservable.value)
                self.moveToSearching()
            }
            .disposed(by: disposeBag)
        
        Observable.merge(
            mainView.totalButton.rx.tap.map { _ in SelectedGender.total},
            mainView.manButton.rx.tap.map { _ in SelectedGender.man},
            mainView.womanButton.rx.tap.map { _ in SelectedGender.woman}
        ).bind(to: viewModel.genderObservable)
            .disposed(by: disposeBag)
        
        
        viewModel.genderObservable
            .subscribe(onNext: {
                self.mainView.totalButton.buttonModeColor(.white)
                self.mainView.manButton.buttonModeColor(.white)
                self.mainView.womanButton.buttonModeColor(.white)
                switch $0 {
                case .total:
                    self.mainView.totalButton.buttonModeColor(.fill)
                case .man:
                    self.mainView.manButton.buttonModeColor(.fill)
                case .woman:
                    self.mainView.womanButton.buttonModeColor(.fill)
                }
                
                self.updateFriends(gender: self.viewModel.genderObservable.value)
            })
            .disposed(by: disposeBag)
        
        //home뷰에서 알아서 바뀌나?
        viewModel.matchingStatusObservable
            .subscribe(onNext: { status in
                var imageName = ""
                switch status {
                case .normal:
                    imageName = homeIcon.finding.rawValue
                case .done:
                    imageName = homeIcon.message.rawValue
                case .ing:
                    imageName = homeIcon.search.rawValue
                }
                self.mainView.floatingButton.setImage(UIImage(named: imageName), for: .normal)
            })
            .disposed(by: disposeBag)
    }
    
    func checkUser() {
        let authViewModel = AuthViewModel()
        authViewModel.onErrorHandling = { error in
            if error == .notAcceptable {
                UserDefaults.standard.startMode = StartMode.auth.rawValue
                print("로그인 새로 해야함")
                self.coordinator?.pushToAuthSignUp()
                // 토스트 메세지: 로그인을 해주세요
            } else if error  == .unAuthorized {
                print("errorHandling: 로그인 새로 해야함")
                self.coordinator?.pushToAuthSignUp()
            }
        }
        authViewModel.getUser()
    }
    
    private func setUserLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
        
        let locationValue = CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let region = MKCoordinateRegion(center: locationValue, span: spanValue)
        mapView?.setRegion(region, animated: true)
        return locationValue
    }
    
    func moveToSearching() {
        UserDefaults.standard.matchingStatus = MatchingStatus.ing.rawValue
        let vc = SearchHobbyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func findMyLocation() {
        guard locationManager.location != nil else {
            requestLocationPermissionAlert()
            return
        }
        updateFriends(gender: viewModel.genderObservable.value)
        mapView?.showsUserLocation = true
        mapView?.setUserTrackingMode(.follow, animated: true)
    }
    
    func updateFriends(gender: SelectedGender) {
        viewModel.onErrorHandling = { result in
            if result == .ok {
                self.mapView?.removeAnnotations((self.mapView?.annotations)!)
                self.addAnnotation(friends: self.viewModel.totalFriends)
               // self.selectAnnotations(gender: self.viewModel.genderObservable.value)
            }
        }
        viewModel.searchFriends()
    }
    
    private func addAnnotation(friends: [Friend?]) {
        print(#function)
        
        for friend in friends {
            let userLocation = CLLocationCoordinate2D(latitude: friend?.lat ?? defaultCoordinate.latitude, longitude: friend?.long ?? defaultCoordinate.longitude)
            let userSesacImageName = viewModel.setFriendSesacImage(imgaeNumber: friend!.sesac)
            let annotation = CustomPointAnnotation(coordinate: userLocation, imageName: userSesacImageName)
            mapView?.addAnnotation(annotation)
        }
    }

    
    func selectAnnotations(gender: SelectedGender) {
        print(#function)
        switch gender {
        case .total:
            showSelectedAnnotation(hideManAnnotations: false, hideWomanAnnotations: false)
        case .man:
            showSelectedAnnotation(hideManAnnotations: false, hideWomanAnnotations: true)
        case .woman:
            showSelectedAnnotation(hideManAnnotations: true, hideWomanAnnotations: false)
        }
    }
    
    func showSelectedAnnotation(hideManAnnotations: Bool, hideWomanAnnotations: Bool) {
        print(#function)
        
        for manAnnotation in mainView.manAnnotations {
            print(mainView.manAnnotations)
            mapView?.view(for: manAnnotation)?.isHidden = hideManAnnotations
        }
        
        for womanAnnotation in mainView.womanAnnotations {
            mapView?.view(for: womanAnnotation)?.isHidden = hideWomanAnnotations
        }
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
            .subscribe(onNext: {
                alertView.removeFromSuperview()
            })
            .disposed(by: disposeBag)
        
        alertView.okButton.rx.tap
            .subscribe(onNext: {
                self.moveToSetting()
                alertView.removeFromSuperview()
            })
            .disposed(by: disposeBag)
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
    
    func checkUsersLocationServicesAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus: authorizationStatus)
        }
        
    }
    
    func checkCurrentLocationAuthorization(authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("GPS 권한 설정됨")
            self.locationManager.startUpdatingLocation()
        case .notDetermined:
            print("GPS 권한 설정되지 않음")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
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
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("위치 접근 실패: \(error)")
        // 위치접근 실패: error alert
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUsersLocationServicesAuthorization()
        
        
    }
}


extension HomeViewController: MKMapViewDelegate {
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: CustomPointAnnotation.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomPointAnnotation.identifier)
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = annotation
        }
        
        let pin = annotation as? CustomPointAnnotation
        let size = CGSize(width: 83, height: 83)
        UIGraphicsBeginImageContext(size)
        let pinImage = UIImage(named: pin!.imageName)
        
        pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView?.image = resizedImage
        
        
        return annotationView
    }
    
    
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.updateFriends(gender: self.viewModel.genderObservable.value)
        }
        
    }
}


struct Match: Codable {
    let dodged, matched, reviewed: Int
    let matchedNick, matchedUid: String
}
