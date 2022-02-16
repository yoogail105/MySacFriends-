//
//  PageViewController.swift
//  SeSacFriends
//
//  Created by 성민주민주 on 2022/01/21.
//

import UIKit

class PageViewController: UIPageViewController {
    
    
    var pages = [UIViewController]()
    let pageControl = OnboardingView().pageControl
    let initialPage = 0

    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }
}

extension PageViewController {
    func setup() {
        
        self.dataSource = self
        self.delegate = self
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        let page1 = OnboardingCard01ViewController()
        let page2 = OnboardingCard02ViewController()
        let page3 = OnboardingCard03ViewController()
        
        [page1, page2, page3].forEach {
            self.pages.append($0)
        }
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
    }
    
    func style() {
        self.pageControl.currentPage = initialPage
    }
    
    
    func layout() {
    }
}

//- actions

// 유저가 제스처를 취했을 때 수행할 함수

extension PageViewController {
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) { //현재(넘기기 전의 인덱스)
            print("before viewControllerIndex:", viewControllerIndex)
            print(self.initialPage)
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return nil
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return nil
            }
        }
        return nil
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    // pageControl
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        //set the pageControl.currentPage to the index of the current viewController in pages
        guard let viewControllers = pageViewController.viewControllers else { return }
        
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        OnboardingView().pageControl.currentPage = currentIndex
        print(currentIndex)
    }
}

