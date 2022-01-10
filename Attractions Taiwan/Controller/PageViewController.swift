//
//  PageViewController.swift
//  Attractions Taiwan
//
//  Created by NDHU_CSIE on 2021/12/27.
//

import UIKit

protocol PageIndexDelegate: AnyObject {
    func didUpdatePageIndex(currentIndex: Int)
}

class PageViewController: UIPageViewController {
    
    var scenes = Scene()
    var photoSet : [Data?] = [nil, nil, nil]
    var currentIndex = 0
    
    weak var indexDalegate: PageIndexDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // copy the image paths to the photoSet array
        photoSet[0] = scenes.photo1
        photoSet[1] = scenes.photo2
        photoSet[2] = scenes.photo3
        
        if photoSet[1] == nil {
            photoSet[1] = photoSet[2]
            photoSet[2] = nil
        }
        if photoSet[0] == nil {
            photoSet[0] = photoSet[1]
            photoSet[1] = photoSet[2]
            photoSet[2] = nil
        }
        
        // Set the data source and delegate to itself
        dataSource = self
        delegate = self
        
        // Create the first image content screen
        if let startingViewController = contentViewControllerR(at: 0) {
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    func contentViewControllerR(at index: Int) -> ContentViewController? {
        if index < 0 || index >= Int(scenes.photoCount){
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController {
            
            if photoSet[index] != nil {
                pageContentViewController.image = photoSet[index]!
                pageContentViewController.index = index
            }

            return pageContentViewController
        }
        
        return nil
    }
    
    func contentViewControllerL(at index: Int) -> ContentViewController? {
        if index < 0 || index >= Int(scenes.photoCount){
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "ContentViewController") as? ContentViewController {
            
            if photoSet[index] != nil {
                pageContentViewController.image = photoSet[index]!
                pageContentViewController.index = index
            }

            return pageContentViewController
        }
        
        return nil
    }
    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewControllerR(at: currentIndex) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
}


// MARK: - UIPageViewControllerDataSource methods

extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! ContentViewController).index
        index -= 1   // get the previous page index
        
        return contentViewControllerL(at: index)  //Create a contentViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index = (viewController as! ContentViewController).index
        index += 1
        
        return contentViewControllerR(at: index)
        
    }
    
}

// MARK: - UIPageViewControllerDelegate methods
extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? ContentViewController {
                
                currentIndex = contentViewController.index
                
                indexDalegate?.didUpdatePageIndex(currentIndex: currentIndex)
            }
            
        }
    }
}


