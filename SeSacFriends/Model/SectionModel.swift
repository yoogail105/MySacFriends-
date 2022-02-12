//
//  MyModel.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/02/12.
//

import Foundation
import RxDataSources


struct MySection {
    var header: String
    var items: [Item]
}

extension MySection: AnimatableSectionModelType {
    typealias Item = Int
    init(original: MySection,items: [Int]) {
        self = original
        self.items = items
        
    }
    var identity: String {
        return header
        
    }
}
