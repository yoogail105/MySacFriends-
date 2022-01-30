//
//  RangeSliderTrackLayer.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/30.
//

import UIKit

class RangeSliderTrackLayer: CALayer {
  weak var rangeSlider: RangeSlider?
  
  override func draw(in ctx: CGContext) {
    guard let slider = rangeSlider else {
      return
    }
    
    let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
    ctx.addPath(path.cgPath)
    
    ctx.setFillColor(slider.trackTintColor.cgColor)
    ctx.fillPath()
    
    ctx.setFillColor(slider.trackHighlightTintColor.cgColor)
    let lowerValuePosition = slider.positionForValue(slider.lowerValue)
    let upperValuePosition = slider.positionForValue(slider.upperValue)
    let rect = CGRect(x: lowerValuePosition, y: 0,
                      width: upperValuePosition - lowerValuePosition,
                      height: bounds.height)
    ctx.fill(rect)
  }
}
