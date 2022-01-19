//
//  UIFont+Extension.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import UIKit

enum AppFont: String {
    case NotoSansCJKkrRegular = "NotoSansCJKkr-Regular"
    case NotoSansCJKkrMedium = "NotoSansCJKkr-Medium"
}


extension UIFont {
    var Display1_R20: UIFont {
        return UIFont(name: AppFont.NotoSansCJKkrRegular.rawValue, size: 20)!
    }
    
    var Title1_M16: UIFont {
        return UIFont(name: AppFont.NotoSansCJKkrMedium.rawValue, size: 16)!
    }
    
    var Title2_R16: UIFont {
        return UIFont(name: AppFont.NotoSansCJKkrRegular.rawValue, size: 16)!
    }
    
    var Title3_M14: UIFont {
        return UIFont(name: AppFont.NotoSansCJKkrMedium.rawValue, size: 14)!
    }
    
    var Title4_R14: UIFont {
        return UIFont(name: AppFont.NotoSansCJKkrRegular.rawValue, size: 14)!
    }
    
    var Title5_M12: UIFont {
        return UIFont(name: AppFont.NotoSansCJKkrMedium.rawValue, size: 12)!
    }
    
    var Title6_R12: UIFont {
        return UIFont(name: AppFont.NotoSansCJKkrRegular.rawValue, size: 12)!
    }
    
    var Body1_M16: UIFont {
        return UIFont(name: AppFont.NotoSansCJKkrMedium.rawValue, size: 16)!
    }
    
    var Body2_R16: UIFont {
        return UIFont(name: AppFont.NotoSansCJKkrRegular.rawValue, size: 16)!
    }
    
    var Body3_R14: UIFont {
        return UIFont(name: AppFont.NotoSansCJKkrRegular.rawValue, size: 14)!
    }
    
    var Body4_R12: UIFont {
        return UIFont(name: AppFont.NotoSansCJKkrRegular.rawValue, size: 12)!
    }
    
    var caption_R10: UIFont {
        return UIFont(name: AppFont.NotoSansCJKkrRegular.rawValue, size: 10)!
    }

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
