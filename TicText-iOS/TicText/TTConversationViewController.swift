//
//  TTConversationViewController.swift
//  TicText
//
//  Created by Kevin Yufei Chen on 10/14/15.
//  Copyright © 2015 Kevin Yufei Chen. All rights reserved.
//

import UIKit

class TTConversationViewController: UIViewController, TTUnreadTicsViewDataSource, TTUnreadTicsViewDelegate, UITableViewDataSource, UITableViewDelegate {

    var unreadTicsView: TTUnreadTicsView!
    var conversationTableView: UITableView!
    
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
        self.setupConversationTableView()
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
    
    private func setupConversationTableView() {
        self.conversationTableView = UITableView(frame: CGRect(x: self.view.bounds.origin.x, y: CGRectGetMaxY(self.unreadTicsView.frame), width: self.view.bounds.width, height: self.view.bounds.height - kTTUnreadTicsViewHeight - 36))
        self.conversationTableView.dataSource = self
        self.conversationTableView.delegate = self
        self.conversationTableView.separatorStyle = .None
        self.conversationTableView.backgroundColor = kTTPurpleColor
        self.conversationTableView.tableFooterView = UIView(frame: .zero)
        self.conversationTableView.registerClass(TTConversationTableViewCell.self, forCellReuseIdentifier: "ConversationTableViewCell")
        self.view.addSubview(self.conversationTableView)
    }
    
    
    // MARK: TTUnreadTicsViewDataSource
    
    func numberOfUnreadTicsInUnreadTicsView(unreadTicsView: TTUnreadTicsView) -> Int {
        return 0
    }
    
    
    // MARK: TTUnreadTicsViewDelegate
    
    func didTapBannerButtonInUnreadTicsView(unreadTicsView: TTUnreadTicsView) {
        
    }
    
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 22
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = TTConversationTableViewCell(style: .Subtitle, reuseIdentifier: "ConversationTableViewCell")
        cell.backgroundColor = indexPath.row % 2 == 0 ? kTTUltraLightPurpleColor : kTTLightPurpleColor
        cell.textLabel?.text = "Conversation " + String(indexPath.row)
        cell.detailTextLabel?.text = "Hi there, I just want to tell you this is a sample Tic."
        cell.imageView?.image = UIImage(named: "TestProfilePicture")!
        cell.timestampLabel?.text = "3m ago"
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 68.0
    }
    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}

extension UINavigationController {
    
    public override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.topViewController
    }
}
