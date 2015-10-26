//
//  TTConversationsViewController.swift
//  TicText
//
//  Created by Kevin Yufei Chen on 10/6/15.
//  Copyright © 2015 Kevin Yufei Chen. All rights reserved.
//

import UIKit

class TTHomeViewController: UIViewController, TTUnreadTicsViewDataSource, TTUnreadTicsViewDelegate, TTQuickTicViewDataSource, TTQuickTicViewDelegate, TTMyTicsViewDataSource, TTMyTicsViewDelegate {

    private var unreadTicsView: TTUnreadTicsView!
    private var quickTicView: TTQuickTicView!
    private var myTicsView: TTMyTicsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUserInterface()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    private func setupUserInterface() {
        self.setupStatusBar()
        self.setupNavigationBar()
        self.setupUnreadTicsView()
        self.setupQuickTicView()
        self.setupMyTicsView()
    }
    
    private func setupStatusBar() {
        let statusBarBackgroundView = UIView(frame: CGRect(x: 0, y: -20, width: self.view.bounds.width, height: 20))
        statusBarBackgroundView.backgroundColor = kTTPurpleColor //UIColor.orangeColor()
        self.navigationController!.navigationBar.addSubview(statusBarBackgroundView)
    }
    
    private func setupNavigationBar() {
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "TitleView"))
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBar.backgroundColor = kTTUltraLightPurpleColor
    }
    
    private func setupUnreadTicsView() {
        self.unreadTicsView = TTUnreadTicsView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: kTTUnreadTicsViewHeight))
        self.unreadTicsView.dataSource = self
        self.unreadTicsView.delegate = self
        self.view.addSubview(self.unreadTicsView)
    }
    
    private func setupQuickTicView() {
        self.quickTicView = TTQuickTicView(frame: CGRect(x: 0, y: CGRectGetMaxY(self.unreadTicsView.frame), width: self.view.bounds.width, height: kTTQuickTicViewHeight))
        self.quickTicView.dataSource = self
        self.quickTicView.delegate = self
        self.view.addSubview(self.quickTicView)
    }
    
    private func setupMyTicsView() {
        self.myTicsView = TTMyTicsView(frame: CGRect(x: 0, y: CGRectGetMaxY(self.quickTicView.frame), width: self.view.bounds.width, height: self.view.bounds.height - kTTUnreadTicsViewHeight - kTTQuickTicViewHeight))
        self.myTicsView.dataSource = self
        self.myTicsView.delegate = self
        self.view.addSubview(self.myTicsView)
    }
    
    // MARK: TTUnreadTicsViewDataSource
    
    func numberOfUnreadTicsInUnreadTicsView(unreadTicsView: TTUnreadTicsView) -> Int {
        return 0
    }
    
    
    // MARK: TTUnreadTicsViewDelegate
    
    func didTapBannerButtonInUnreadTicsView(unreadTicsView: TTUnreadTicsView) {
        
    }
    
    
    // MARK: TTQuickTicViewDataSource
    
    func errorMessageInQuickTicView(quickTicView: TTQuickTicView) -> String {
        return ""
    }
    

    // MARK: TTQuickTicViewDelegate
    
    func quickTicView(quickTicView: TTQuickTicView, didTapTicItButtonWithText text: String?, image: UIImage?, timeLimit: NSTimeInterval) -> Bool {
        quickTicView.endEditing(true)
        return true
    }
    
    
    // MARK: TTMyTicsViewDataSource
    
    func numberOfConversationsInMyTicsView(myTicsView: TTMyTicsView) -> Int {
        return 22
    }
    
    func numberOfTotalTicsInMyTicsView(myTicsView: TTMyTicsView) -> Int {
        return 165
    }
    
    func myTicsView(myTicsView: TTMyTicsView, contactNameForConversationAtIndex index: Int) -> String {
        return "Conversation " + String(index)
    }
    
    func myTicsView(myTicsView: TTMyTicsView, previewForConversationAtIndex index: Int) -> String {
        return "Hi there, I just want to tell you this is a sample Tic."
    }
    
    func myTicsView(myTicsView: TTMyTicsView, contactImageForConversationAtIndex index: Int) -> UIImage {
        return UIImage(named: "TestProfilePicture")!
    }
    
    func myTicsView(myTicsView: TTMyTicsView, timestampForConversationAtIndex index: Int) -> NSDate {
        return NSDate()
    }
    
    
    // MARK: TTMyTicsViewDelegate
    
    func myTicsView(myTicsView: TTMyTicsView, didSelectConversationAtIndex index: Int) {
        
    }
    
    func myTicsView(myTicsView: TTMyTicsView, didTapSummaryButtonWithCurrentTopVisibleConversationIndex index: Int) {
        self.navigationController?.tabBarController?.selectedIndex = 1
    }


}
