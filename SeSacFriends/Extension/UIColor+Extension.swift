//
//  UIColor+Extension.swiftb
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/18.
//

import UIKit

enum BrandColor{
    case green
    case whitegreen
    case yellowgreen
}

enum Grayscale {
    case gray1
    case gray2
    case gray3 //inactive, active, disable
    case gray4
    case gray5
    case gray6
    case gray7
}

enum SystemColor {
    case success
    case error
    case focus
}


extension UIColor {
    
    static func brandColor(_ name: BrandColor) -> UIColor {
        switch name {
        case .green:
            return #colorLiteral(red: 0.2823529412, green: 0.862745098, blue: 0.5725490196, alpha: 1)
        case .whitegreen:
            return #colorLiteral(red: 0.8039215686, green: 0.9568627451, blue: 0.8823529412, alpha: 1)
        case .yellowgreen:
            return #colorLiteral(red: 0.6941176471, green: 0.9215686275, blue: 0.3764705882, alpha: 1)
      
        }
    }
    
    static func grayColor(_ name: Grayscale) -> UIColor {
        switch name {
        case .gray1:
            return #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        case .gray2:
            return #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)
        case .gray3:
            return #colorLiteral(red: 0.8862745098, green: 0.8862745098, blue: 0.8862745098, alpha: 1)
        case .gray4:
            return #colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)
        case .gray5:
            return #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        case .gray6:
            return #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        case .gray7:
            return #colorLiteral(red: 0.5333333333, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
    
        }
    }
    
    static func systemColor(_ name: SystemColor) -> UIColor {
        switch name {
        case .success:
            return #colorLiteral(red: 0.3843137255, green: 0.5607843137, blue: 0.8980392157, alpha: 1)
        case .error:
            return #colorLiteral(red: 0.9137254902, green: 0.4, blue: 0.4196078431, alpha: 1)
        case .focus:
            return #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        }
    }
    
    convenience init(hex value: Int, alpha: CGFloat = 1.0) {
        self.init(
        red: CGFloat((value & 0xFF0000) >> 16 ) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8 ) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    
}
