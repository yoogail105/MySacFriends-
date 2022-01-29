//
//  RangeSliderViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/30.
//

import UIKit

class RangeSliderViewController: UIViewController {
  let rangeSlider = RangeSlider(frame: .zero)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    rangeSlider.backgroundColor = .red
    view.addSubview(rangeSlider)
  }
  
  override func viewDidLayoutSubviews() {
    let margin: CGFloat = 20
    let width = view.bounds.width - 2 * margin
    let height: CGFloat = 30
    
    rangeSlider.frame = CGRect(x: 0, y: 0,
                               width: width, height: height)
    rangeSlider.center = view.center
  }
}
