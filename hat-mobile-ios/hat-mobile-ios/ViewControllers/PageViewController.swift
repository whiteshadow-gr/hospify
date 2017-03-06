/**
 * Copyright (C) 2017 HAT Data Exchange Ltd
 *
 * SPDX-License-Identifier: MPL2
 *
 * This file is part of the Hub of All Things project (HAT).
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/
 */

import UIKit

// MARK: Class

/// The Page view controller child. Shows info about hat and what you can do
class PageViewController: UIViewController {
    
    // MARK: - Variables
    
    /// a variable to know the page number of the view
    var itemIndex: Int = 0
    
    /// the second PegeViewController that appears when user has tapped the learn more on the first screen
    private var pageViewController: HATCapabilitiesPageViewController? = nil
    
    // MARK: - IBOutlets

    /// An IBOutlet to handle the imageView
    @IBOutlet weak var imageView: UIImageView!
    
    /// An IBOutlet to handle the titleLabel
    @IBOutlet weak var titleLabel: UILabel!
    /// An IBOutlet to handle the mainLabel
    @IBOutlet weak var mainLabel: UILabel!
    
    /// An IBOutlet to handle the moreButton
    @IBOutlet weak var moreButton: UIButton!
    
    // MARK: - IBActions
    
    /**
     An IBAction executed when user has pressed the moreInfoButton and presents a second page view controller
     
     - parameter sender: The object that calls this method
     */
    @IBAction func moreInfoActionButton(_ sender: Any) {
     
        // create page view controller
        let pageItemController = self.storyboard!.instantiateViewController(withIdentifier: "CapabilitiesPageViewController") as! HATCapabilitiesPageViewController
        
        // set up the created page view controller
        self.pageViewController = pageItemController
        pageItemController.view.createFloatingView(frame: CGRect(x: self.view.frame.origin.x + 15, y: self.view.frame.origin.x + 15, width: self.view.frame.width - 30, height: self.view.frame.height - 30), color: .white, cornerRadius: 15)
        
        // add the page view controller to self
        self.addViewController(pageItemController)
        
        // notify parent page view controller for disabling the scrolling between pages
        NotificationCenter.default.post(name: NSNotification.Name(Constants.NotificationNames.disablePageControll.rawValue), object: nil)
    }
    
    // MARK: - ViewController delegate methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // init a LearnMoreObject
        var pageObject: LearnMoreObject = LearnMoreObject()
        
        // change the color of the pagination dots at the bottom of the screen
        self.pageViewController?.changePaginationColors(pageTintColor: .white, pageCurrentTintColor: .tealColor())
        
        // check if we are out of bounds
        if (itemIndex >= 0 && itemIndex <= 6 ) {
            
            // create a LearnMoreObject according to page we are
            pageObject = LearnMoreObject(pageNumber: itemIndex)
        }
        
        if itemIndex == 6 {
            
            // format main label
            let partOne = "Because we think YOU should be at the ".createTextAttributes(foregroundColor: .white, strokeColor: .white, font: UIFont(name: Constants.fontNames.openSansCondensedLight.rawValue, size: 36)!)
            let partTwo = "hub of all things".createTextAttributes(foregroundColor: .tealColor(), strokeColor: .tealColor(), font: UIFont(name: Constants.fontNames.openSans.rawValue, size: 36)!)
            
            mainLabel.attributedText = partOne.combineWith(attributedText: partTwo)
        } else {
            
            mainLabel.text = pageObject.info
        }
        
        // assign the values of the object to the UIElements
        imageView.image = pageObject.image
        titleLabel.text = pageObject.title
        
        // if we are in the first page show the button, else hide it
        if (pageObject.buttonTitle != "") {
            
            moreButton.setTitle(pageObject.buttonTitle, for: .normal)
            moreButton.addBorderToButton(width: 1, color: .white)
        } else {
            
            moreButton.isHidden = true
        }
        
        // add a notification observer in order to hide the second page view controller
        NotificationCenter.default.addObserver(self, selector: #selector(removeSecondPageController), name: Notification.Name(Constants.NotificationNames.hideCapabilitiesPageViewContoller.rawValue), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Remove second PageViewController

    /**
     Removes the second pageviewcontroller on demand when receivd the notification
     
     - parameter notification: The Notification object send with this notification
     */
    @objc private func removeSecondPageController(notification: Notification) {
        
        // if view is found remove it
        if let view = self.pageViewController {
            
            view.removeViewController()
        }
    }
}
