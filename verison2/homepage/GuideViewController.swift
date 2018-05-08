//
//  MainViewController.swift
//  Flipper
//
//  Created by clare on 20/04/2018.
//  Copyright © 2018 CSE 208-Group India. All rights reserved.
//
import UIKit

class GuideViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startButton: UIButton!
    
    fileprivate var scrollView: UIScrollView!
    
    fileprivate let numOfPages = 5


    @IBOutlet weak var insLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        let frame = self.view.bounds
        
        scrollView = UIScrollView(frame: frame)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPoint.zero
        
        // set size of scrollView as three times of width of screen(may change according to actual situation)
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: frame.size.height)
        
        scrollView.delegate = self
        insLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        insLabel.numberOfLines = 0
        for index  in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "GuideImage\(index)"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            imageView.contentMode = UIViewContentMode.center
            imageView.alpha = 0.6
            scrollView.addSubview(imageView)
        }
        
        self.view.insertSubview(scrollView, at: 0)
        
        // set corner for the start button
        startButton.layer.cornerRadius = 15.0
        // hide the button
        startButton.alpha = 0.0
        
        
    }
    
    // hide the status bar
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

// MARK: - UIScrollViewDelegate
extension GuideViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // change the state of pageControl
        pageControl.currentPage = Int(offset.x / view.bounds.width)
        var textList = ["Welcome to Flipper :)","You can swipe up to learn the next word, swipe down to check the last word", "Also choose different level of difficulty", "Play a interesting game to test your learning achievement", "Swipe up to record your learning data in the Calendar"]
        insLabel.text = ""
        DispatchQueue.main.asyncAfter(deadline: 1.5, execute: {self.insLabel.text = textList[self.pageControl.currentPage]})
        if pageControl.currentPage == numOfPages - 1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.startButton.alpha = 1.0
            }) 
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.startButton.alpha = 0.0
            }) 
        }
    }
}
