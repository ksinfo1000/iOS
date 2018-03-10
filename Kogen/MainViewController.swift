//
//  MainViewController.swift
//  KozhenSpromozhen
//
//  Created by Kogen on 4/6/17.
//  Copyright © 2017 KozhenSpromozhen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate, CAAnimationDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startButton: UIButton!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //1
        self.scrollView.frame = CGRect(x:0, y:0, width:self.view.frame.width, height:self.view.frame.height)
        let scrollViewWidth:CGFloat = self.scrollView.frame.width
        let scrollViewHeight:CGFloat = self.scrollView.frame.height
        //2
        textView.textAlignment = .center
        textView.text = "Sweettutos.com is your blog of choice for Mobile tutorials"
        //textView.textColor = .black
        self.startButton.layer.cornerRadius = 4.0
        //3
        let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgOne.image = UIImage(named: "slide1")
        let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgTwo.image = UIImage(named: "slide2")
        let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
        imgThree.image = UIImage(named: "slide3")
        
        self.scrollView.addSubview(imgOne)
        self.scrollView.addSubview(imgTwo)
        self.scrollView.addSubview(imgThree)

        //4
        self.scrollView.contentSize = CGSize(width:self.scrollView.frame.width * 3, height:self.scrollView.frame.height)
        self.scrollView.delegate = self
        self.pageControl.currentPage = 0
        
//        timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
        
          timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(MainViewController.moveToNextPage), userInfo: nil, repeats: true)
        
    }

    func newStartScrolling()
    {
        var currentOffset = self.scrollView.contentOffset
        currentOffset = CGPoint(x: currentOffset.x+3, y: currentOffset.y )
        
        
        if(currentOffset.x < self.scrollView.contentSize.width - 500)
        {
            
            
            self.scrollView.setContentOffset(currentOffset, animated: false)
            currentOffset = CGPoint(x: 0, y: currentOffset.y )
            //scrollview.contentSize = CGSize(width: 0, height: 0);
        }
        else
        {
            
            timer.invalidate()
            //showview()
            
        }
        
        
    }
    
    
    func moveToNextPage (){
        
        let pageWidth:CGFloat = self.scrollView.frame.width
        let maxWidth:CGFloat = pageWidth * 3
        let contentOffset:CGFloat = self.scrollView.contentOffset.x
        
        let slideToX = contentOffset + pageWidth
        
        if  contentOffset + pageWidth == maxWidth
        {
            //slideToX = 0
            let scrollViewWidth:CGFloat = self.scrollView.frame.width
            let scrollViewHeight:CGFloat = self.scrollView.frame.height
            let imgOne = UIImageView(frame: CGRect(x:0, y:0,width:scrollViewWidth, height:scrollViewHeight))
            imgOne.image = UIImage(named: "slide1")
            let imgTwo = UIImageView(frame: CGRect(x:scrollViewWidth, y:0,width:scrollViewWidth, height:scrollViewHeight))
            imgTwo.image = UIImage(named: "slide2")
            let imgThree = UIImageView(frame: CGRect(x:scrollViewWidth*2, y:0,width:scrollViewWidth, height:scrollViewHeight))
            imgThree.image = UIImage(named: "slide3")
            
            self.scrollView.addSubview(imgOne)
            self.scrollView.addSubview(imgTwo)
            self.scrollView.addSubview(imgThree)
        }
        
        self.scrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.scrollView.frame.height), animated: true)
    }
    
/*
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        // Test the offset and calculate the current page after scrolling ends
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage:CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage);
        // Change the text accordingly
        if Int(currentPage) == 0{
            textView.text = "Sweettutos.com is your blog of choice for Mobile tutorials"
        }else if Int(currentPage) == 1{
            textView.text = "I write mobile tutorials mainly targeting iOS"
        }else if Int(currentPage) == 2{
            textView.text = "And sometimes I write games tutorials about Unity"
            self.startButton.alpha = 1.0
        }
 
    }
 */
}
