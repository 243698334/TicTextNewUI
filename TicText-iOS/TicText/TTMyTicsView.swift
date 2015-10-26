//
//  TTMyTicsView.swift
//  TicText
//
//  Created by Kevin Yufei Chen on 10/12/15.
//  Copyright © 2015 Kevin Yufei Chen. All rights reserved.
//

import UIKit


protocol TTMyTicsViewDataSource: NSObjectProtocol {
    
    func numberOfConversationsInMyTicsView(myTicsView: TTMyTicsView) -> Int
    
    func numberOfTotalTicsInMyTicsView(myTicsView: TTMyTicsView) -> Int
    
    func myTicsView(myTicsView: TTMyTicsView, contactNameForConversationAtIndex index: Int) -> String
    
    func myTicsView(myTicsView: TTMyTicsView, previewForConversationAtIndex index: Int) -> String
    
    func myTicsView(myTicsView: TTMyTicsView, contactImageForConversationAtIndex index: Int) -> UIImage
    
    func myTicsView(myTicsView: TTMyTicsView, timestampForConversationAtIndex index: Int) -> NSDate
}

protocol TTMyTicsViewDelegate: NSObjectProtocol {
    
    func myTicsView(myTicsView: TTMyTicsView, didSelectConversationAtIndex index: Int)
    
    func myTicsView(myTicsView: TTMyTicsView, didTapSummaryButtonWithCurrentTopVisibleConversationIndex index: Int)
}

class TTMyTicsView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    weak var dataSource: TTMyTicsViewDataSource?
    weak var delegate: TTMyTicsViewDelegate?
    
    private var titleView: UIView!
    private var titleLabel: UILabel!
    private var featuredConversationsTableView: UITableView!
    private var conversationsTableView: UITableView!
    private var transitionCoversationTableView: UITableView!
    private var summaryButton: UIButton!
    private var summaryConversationsNumberLabel: UILabel!
    private var summaryTicsNumberLabel: UILabel!
    
    private var isObservingContentOffsetChange: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleView = UIView(frame: .zero)
        self.titleLabel = UILabel(frame: .zero)
        self.featuredConversationsTableView = UITableView(frame: .zero)
        self.conversationsTableView = UITableView(frame: .zero)
        self.transitionCoversationTableView = UITableView(frame: .zero)
        self.summaryButton = UIButton(frame: .zero)
        self.summaryConversationsNumberLabel = UILabel(frame: .zero)
        self.summaryTicsNumberLabel = UILabel(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func drawRect(rect: CGRect) {
        self.titleView.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: 36)
        self.titleView.backgroundColor = kTTUltraLightPurpleColor
        self.addSubview(self.titleView)
        
        self.titleLabel.frame = CGRect(x: self.titleView.bounds.origin.x, y: self.titleView.bounds.origin.y, width: self.titleView.bounds.width - 20, height: self.titleView.bounds.height)
        self.titleLabel.backgroundColor = kTTUltraLightPurpleColor
        self.titleLabel.font = UIFont(name: kTTUIDefaultFont, size: 24)
        self.titleLabel.textColor = UIColor.orangeColor()
        self.titleLabel.textAlignment = .Right
        self.titleLabel.text = "My Tics"
        self.titleView.addSubview(self.titleLabel)
        
        self.featuredConversationsTableView.frame = CGRect(x: self.bounds.origin.x, y: CGRectGetMaxY(self.titleView.frame), width: self.bounds.width, height: 136)
        self.featuredConversationsTableView.dataSource = self
        self.featuredConversationsTableView.delegate = self
        self.featuredConversationsTableView.showsVerticalScrollIndicator = false
        self.featuredConversationsTableView.backgroundColor = kTTPurpleColor //UIColor.orangeColor()
        self.featuredConversationsTableView.separatorStyle = .SingleLine
        self.featuredConversationsTableView.tableFooterView = UIView(frame: .zero);
        self.featuredConversationsTableView.registerClass(TTMyTicsFeaturedConversationTableViewCell.self, forCellReuseIdentifier: "MyTicsFeaturedConversationTableViewCell")
        self.featuredConversationsTableView.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
        self.addSubview(self.featuredConversationsTableView)
        
        self.conversationsTableView.frame = CGRect(x: self.bounds.origin.x, y: CGRectGetMaxY(self.featuredConversationsTableView.frame), width: self.bounds.width, height: self.bounds.height - self.titleView.frame.height - self.featuredConversationsTableView.frame.height - 64)
        self.conversationsTableView.dataSource = self
        self.conversationsTableView.delegate = self
        self.conversationsTableView.backgroundColor = kTTPurpleColor //UIColor.orangeColor()
        self.conversationsTableView.separatorStyle = .SingleLine
        self.conversationsTableView.tableFooterView = UIView(frame: CGRectZero);
        self.conversationsTableView.registerClass(TTMyTicsConversationTableViewCell.self, forCellReuseIdentifier: "MyTicsConversationTableViewCell")
        self.conversationsTableView.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
        self.addSubview(self.conversationsTableView)
        
        self.summaryButton.frame = CGRect(x: 10, y: self.bounds.origin.y + 25, width: 100, height: 100)
        self.summaryButton.setImage(UIImage(named: "MyTicsViewSummary"), forState: .Normal)
        self.summaryButton.addTarget(self, action: "didTapSummaryButton:", forControlEvents: .TouchUpInside)
        self.addSubview(self.summaryButton)
        
        self.summaryConversationsNumberLabel.frame = CGRect(x: 17, y: 25, width: 30, height: 20)
        self.summaryConversationsNumberLabel.text = String((self.dataSource?.numberOfConversationsInMyTicsView(self))!)
        self.summaryConversationsNumberLabel.textColor = kTTPurpleColor
        self.summaryConversationsNumberLabel.textAlignment = .Right
        self.summaryButton.addSubview(self.summaryConversationsNumberLabel)
        
        self.summaryTicsNumberLabel.frame = CGRect(x: 25, y: 67, width: 50, height: 20)
        self.summaryTicsNumberLabel.text = String((self.dataSource?.numberOfTotalTicsInMyTicsView(self))!)
        self.summaryTicsNumberLabel.textColor = kTTPurpleColor
        self.summaryTicsNumberLabel.textAlignment = .Right
        self.summaryButton.addSubview(self.summaryTicsNumberLabel)
        
        self.isObservingContentOffsetChange = false
    }
    
    func didTapSummaryButton(button: UIButton) {
        self.expandConversationTableView({ () -> Void in
            self.delegate?.myTicsView(self, didTapSummaryButtonWithCurrentTopVisibleConversationIndex: (self.featuredConversationsTableView.indexPathsForVisibleRows?.first?.row)!)
        })
    }
    
    private func expandConversationTableView(completion: ((Void) -> Void)?) {
        let transitionCoverView = UIView(frame: self.featuredConversationsTableView.frame)
        transitionCoverView.backgroundColor = self.featuredConversationsTableView.backgroundColor
        transitionCoverView.alpha = 0
        self.addSubview(transitionCoverView)
        
        self.transitionCoversationTableView.frame = self.featuredConversationsTableView.frame
        self.transitionCoversationTableView.dataSource = self.featuredConversationsTableView.dataSource
        self.transitionCoversationTableView.delegate = self.featuredConversationsTableView.delegate
        self.transitionCoversationTableView.separatorStyle = .None
        self.transitionCoversationTableView.backgroundColor = self.featuredConversationsTableView.backgroundColor
        self.transitionCoversationTableView.tableFooterView = UIView(frame: CGRectZero);
        self.transitionCoversationTableView.registerClass(TTConversationTableViewCell.self, forCellReuseIdentifier: "ConversationTableViewCell")
        self.transitionCoversationTableView.contentOffset = self.featuredConversationsTableView.contentOffset
        self.transitionCoversationTableView.alpha = 0
        transitionCoverView.addSubview(self.transitionCoversationTableView)
        
        UIView.animateWithDuration(0.25) { () -> Void in
            transitionCoverView.alpha = 1
        }
        
        UIView.animateWithDuration(0.5) { () -> Void in
            var transitionCoverViewFinalFrame = self.superview?.bounds
            transitionCoverViewFinalFrame?.origin.y -= (self.frame.origin.y - 44)
            transitionCoverViewFinalFrame?.size.height -= 44
            transitionCoverView.frame = transitionCoverViewFinalFrame!
            self.transitionCoversationTableView.frame = transitionCoverView.bounds
        }
        
        UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.transitionCoversationTableView.alpha = 1
        }) { (finished: Bool) -> Void in
            if (finished == true) {
                completion?()
                self.transitionCoversationTableView.removeFromSuperview()
                transitionCoverView.removeFromSuperview()
            }
        }
    }
    
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.conversationsTableView) {
            return (self.dataSource?.numberOfConversationsInMyTicsView(self))! - 2
        } else if (tableView == self.featuredConversationsTableView) {
            return (self.dataSource?.numberOfConversationsInMyTicsView(self))!
        } else if (tableView == self.transitionCoversationTableView) {
            return (self.dataSource?.numberOfConversationsInMyTicsView(self))!
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (tableView == self.conversationsTableView) {
            let cell = TTMyTicsConversationTableViewCell(style: .Subtitle, reuseIdentifier: "MyTicsConversationTableViewCell")
            cell.backgroundColor = indexPath.row % 2 == 0 ? kTTUltraLightPurpleColor : kTTLightPurpleColor
            cell.textLabel?.text = self.dataSource?.myTicsView(self, contactNameForConversationAtIndex: indexPath.row + 2)
            cell.detailTextLabel?.text = "10m ago"
            cell.imageView?.image = self.dataSource?.myTicsView(self, contactImageForConversationAtIndex: indexPath.row + 2)
            //cell.timestampLabel?.text = "3m ago"
            return cell
        } else if (tableView == self.featuredConversationsTableView) {
            let cell = TTMyTicsFeaturedConversationTableViewCell(style: .Subtitle, reuseIdentifier: "MyTicsFeaturedConversationTableViewCell")
            cell.backgroundColor = kTTPurpleColor //UIColor.orangeColor()
            cell.textLabel?.text = self.dataSource?.myTicsView(self, contactNameForConversationAtIndex: indexPath.row)
            cell.detailTextLabel?.text = self.dataSource?.myTicsView(self, previewForConversationAtIndex: indexPath.row)
            cell.imageView?.image = self.dataSource?.myTicsView(self, contactImageForConversationAtIndex: indexPath.row)
            cell.timestampLabel?.text = "3m ago"
            return cell
        } else {
            let cell = TTConversationTableViewCell(style: .Subtitle, reuseIdentifier: "ConversationTableViewCell")
            cell.backgroundColor = indexPath.row % 2 == 0 ? kTTUltraLightPurpleColor : kTTLightPurpleColor
            cell.textLabel?.text = self.dataSource?.myTicsView(self, contactNameForConversationAtIndex: indexPath.row)
            cell.detailTextLabel?.text = self.dataSource?.myTicsView(self, previewForConversationAtIndex: indexPath.row)
            cell.imageView?.image = self.dataSource?.myTicsView(self, contactImageForConversationAtIndex: indexPath.row)
            cell.timestampLabel?.text = "3m ago"
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (tableView == self.conversationsTableView) {
            return 50.0
        } else if (tableView == self.featuredConversationsTableView) {
            return 68.0
        } else if (tableView == self.transitionCoversationTableView) {
            return 68.0
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            self.featuredConversationsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            self.conversationsTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }

    
    // MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.delegate?.myTicsView(self, didSelectConversationAtIndex: indexPath.row + 2)
    }
    

    // MARK: Sync table views
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (object!.isKindOfClass(UITableView) && keyPath == "contentOffset") {
            if (self.isObservingContentOffsetChange == true) {
                return
            }
            self.isObservingContentOffsetChange = true
            var offset = change?[NSKeyValueChangeNewKey]?.CGPointValue
            if (object as! UITableView == self.featuredConversationsTableView) {
                offset!.y *= (50.0 / 68.0)
                self.conversationsTableView.contentOffset = offset!
            }
            if (object as! UITableView == self.conversationsTableView) {
                offset!.y *= (68.0 / 50.0)
                self.featuredConversationsTableView.contentOffset = offset!
            }
            self.isObservingContentOffsetChange = false
        }
    }
    
}
