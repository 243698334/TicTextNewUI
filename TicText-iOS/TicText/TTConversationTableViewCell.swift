//
//  TTConversationsTableViewCell.swift
//  TicText
//
//  Created by Kevin Yufei Chen on 10/14/15.
//  Copyright © 2015 Kevin Yufei Chen. All rights reserved.
//

import UIKit

class TTConversationTableViewCell: UITableViewCell {

    var timestampLabel: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.timestampLabel = UILabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.timestampLabel?.frame = CGRect(x: CGRectGetMaxX(self.bounds) - 15 - 80, y: 6, width: 80, height: 13)
        self.timestampLabel?.textAlignment = .Right
        self.timestampLabel?.font = UIFont(name: kTTUIDefaultLightFont, size: 10)
        self.timestampLabel?.textColor = UIColor.whiteColor()
        self.addSubview(self.timestampLabel!)
        
        self.imageView?.frame = CGRect(x: 15, y: 6, width: 56, height: 56)
        self.imageView?.layer.masksToBounds = true
        self.imageView?.layer.cornerRadius = 28
        self.imageView?.layer.borderColor = UIColor.orangeColor().CGColor
        self.imageView?.layer.borderWidth = 2.0
        
        self.textLabel?.frame = CGRect(x: CGRectGetMaxX((self.imageView?.frame)!) + 10, y: 10, width: (CGRectGetMinX((self.timestampLabel?.frame)!) - 10) - (CGRectGetMaxX((self.imageView?.frame)!) + 10), height: 25.0)
        self.textLabel?.textAlignment = .Left
        self.textLabel?.font = UIFont(name: kTTUIDefaultLightFont, size: 22)
        self.textLabel?.textColor = UIColor.orangeColor() //kTTPurpleColor
        
        self.detailTextLabel?.frame = CGRect(x: CGRectGetMinX((self.textLabel?.frame)!), y: CGRectGetMaxY((self.textLabel?.frame)!) + 6, width: CGRectGetMaxX(self.bounds) - CGRectGetMinX((self.textLabel?.frame)!), height: 16)
        self.detailTextLabel?.textAlignment = .Left
        self.detailTextLabel?.font = UIFont(name: kTTUIDefaultLightFont, size: 14)
        self.detailTextLabel?.textColor = UIColor.whiteColor()
    }


}
