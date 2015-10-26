//
//  TTRootViewController.swift
//  TicText
//
//  Created by Kevin Yufei Chen on 10/6/15.
//  Copyright © 2015 Kevin Yufei Chen. All rights reserved.
//

import UIKit

class TTRootViewController: UIViewController {
    
    var explodeTabBarController: KCExplodeTabBarController!
    var homeTabBarController: UITabBarController!
    
    var logInViewController: TTLogInViewController!
    var findFriendsViewController: TTFindFriendsViewController!
    
    var homeViewController: TTHomeViewController!
    var homeViewNavigationController: UINavigationController!
    
    var conversationViewController: TTConversationViewController!
    var conversationNavigationViewController: UINavigationController!
    
    var contactsViewController: TTContactsViewController!
    var contactsNavigationController: UINavigationController!
    
    var settingsViewController: TTSettingsViewController!
    var settingsNavigationViewController: UINavigationController!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.presentMainUserInterface()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func presentMainUserInterface() {
        self.homeViewController = TTHomeViewController()
        self.homeViewNavigationController = UINavigationController(rootViewController: self.homeViewController)
        //self.homeViewNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "HomeTabBar"), selectedImage: nil, borderWidth: 0.0, borderColor: UIColor.orangeColor())
        self.homeViewNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "HomeTabBarSmall"), selectedImage: UIImage(named: "HomeTabBarSmall"))
        
        self.conversationViewController = TTConversationViewController()
        self.conversationNavigationViewController = UINavigationController(rootViewController: self.conversationViewController)
        //self.contactsNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "ContactsTabBar"), selectedImage: nil, borderWidth: 0.0, borderColor: UIColor.orangeColor())
        self.conversationNavigationViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ContactsTabBarSmall"), selectedImage: UIImage(named: "ContactsTabBarSmall"))

        self.contactsViewController = TTContactsViewController()
        self.contactsNavigationController = UINavigationController(rootViewController: self.contactsViewController)
        //self.contactsNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "ContactsTabBar"), selectedImage: nil, borderWidth: 0.0, borderColor: UIColor.orangeColor())
        self.contactsNavigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "ContactsTabBarSmall"), selectedImage: UIImage(named: "ContactsTabBarSmall"))
        
        self.settingsViewController = TTSettingsViewController()
        self.settingsNavigationViewController = UINavigationController(rootViewController: self.settingsViewController)
        //self.settingsNavigationViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "SettingsTabBar"), selectedImage: nil, borderWidth: 0.0, borderColor: UIColor.orangeColor())
        self.settingsNavigationViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "SettingsTabBarSmall"), selectedImage: UIImage(named: "SettingsTabBarSmall"))
        
//        self.explodeTabBarController = KCExplodeTabBarController()
//        self.explodeTabBarController.mainTabBorderWidth = 0.0
//        self.explodeTabBarController.viewControllers = [self.homeViewNavigationController]
//        self.navigationController?.setViewControllers([self, self.explodeTabBarController], animated: false)
        
        self.homeTabBarController = UITabBarController()
        self.homeTabBarController!.viewControllers = [self.homeViewNavigationController, self.conversationNavigationViewController, self.contactsNavigationController, self.settingsNavigationViewController]
        self.homeTabBarController.tabBar.backgroundColor = UIColor.whiteColor()
        self.homeTabBarController.tabBar.translucent = false
        var tabBarFrame = self.homeTabBarController.tabBar.frame
        tabBarFrame.size.height -= 10.0
        tabBarFrame.origin.y += 10.0
        self.homeTabBarController.tabBar.frame = tabBarFrame
        self.homeTabBarController.tabBar.tintColor = kTTPurpleColor
        self.navigationController?.setViewControllers([self, self.homeTabBarController!], animated: false)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
