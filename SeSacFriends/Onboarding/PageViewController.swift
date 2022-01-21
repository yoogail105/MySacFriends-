//
//  PageViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/21.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    let mainView = OnboardingView()
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let pageControl = mainView.pageControl
        self.dataSource = self
        self.delegate = self
        
        
        let initialPage = 0
        let page1 = Onboarding01ViewController()
        let page2 = Onboarding02ViewController()
        let page3 = Onboarding03ViewController()
        
        [page1, page2, page3].forEach {
            self.pages.append($0)
        }
       
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    // 유저가 제스처를 취했을 때 수행할 함수
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            print("viewControllerIndex:", viewControllerIndex)
                if viewControllerIndex == 0 {
                    // wrap to last page in array
                    return self.pages.last
                } else {
                    // go to previous page in array
                    return self.pages[viewControllerIndex - 1]
                }
            }
            return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
                if viewControllerIndex < self.pages.count - 1 {
                    // go to next page in array
                    return self.pages[viewControllerIndex + 1]
                } else {
                    // wrap to first page in array
                    return self.pages.first
                }
            }
            return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            
    // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.index(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
            }
        }
    }
    
}
