//
//  Font.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import Foundation

enum AppFont: String {
    case regular = "NotoSansCJKkr-Regular"
    case medium = "NotoSansCJKkr-Medium"
}

//
//extension UILabel {
//    func setTextWithLineHeight(text: String?, lineHeight: CGFloat) {
//        if let text = text {
//
//
//            let style = NSMutableParagraphStyle()
//            style.maximumLineHeight = lineHeight
//            style.minimumLineHeight = lineHeight
//
//
//            let attributes: [NSAttributedString.Key: Any] = [
//            .paragraphStyle: style,
//            .baselineOffset: (lineHeight - font.lineHeight) / 4 // 추가!!️️🤟
//            ]
//
//            let attrString = NSAttributedString(string: text,
//                                                attributes: attributes)
//            self.attributedText = attrString
//        }
//    }
//}
