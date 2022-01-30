//
//  ProfileDetailViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/28.
//

import UIKit

class ProfileDetailViewController: BaseViewController {
    
    
    let mainView = ProfileDetailView()
    
    override func loadView() {
        self.view = mainView
        
        
        let time = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: time) {
            self.mainView.ageBar.trackHighlightTintColor = UIColor.brandColor(.green)
            self.mainView.ageBar.thumbImage = UIImage(named: AssetIcon.filterControl.rawValue)
          //self.mainView.ageBar.highlightedThumbImage = UIImage(named: AssetIcon.filterControl.rawValue)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = TabBarTitle.detail.rawValue
    
        
    }
    
    override func addAction() {
        mainView.ageBar.addTarget(self, action: #selector(rangeSliderValueChanged(_:)),
                                  for: .valueChanged)
        
        
    }
    
    @objc func rangeSliderValueChanged(_ rangeSlider: RangeSlider) {
      let values = "(\(rangeSlider.lowerValue) \(rangeSlider.upperValue))"
      print("Range slider value changed: \(values)")
    }

}
