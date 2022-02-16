//
//  NetworkMonitor.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/16.
//

/*
 네트워크 연결상태 확인
 if NetworkMonitor.shared.isConnected {
     print("여기는 홈뷰 연결오키")
 } else {
     print("연결안됨 얼럿띄우삼")
 }
*/

import UIKit
import Network

final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init(){
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring(){
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
            
            if self?.isConnected == true{
                print("네트워크 연결 ok")
            }else{
                print("네트워크 연결 x")
            }
        }
    }
    
    public func stopMonitoring(){
        monitor.cancel()
    }
    
    private func getConnectionType(_ path:NWPath) {
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        }else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        }else {
            connectionType = .unknown
        }
    }
}

