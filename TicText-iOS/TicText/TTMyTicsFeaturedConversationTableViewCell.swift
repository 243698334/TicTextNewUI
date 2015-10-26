//
//  TTMyTicsFeaturedConversationTableViewCell.swift
//  TicText
//
//  Created by Kevin Yufei Chen on 10/13/15.
//  Copyright © 2015 Kevin Yufei Chen. All rights reserved.
//

import UIKit

class TTMyTicsFeaturedConversationTableViewCell: UITableViewCell {
    
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
        
        self.imageView?.frame = CGRect(x: CGRectGetMaxX(self.bounds) - 70, y: 6, width: 56, height: 56)
        self.imageView?.layer.masksToBounds = true
        self.imageView?.layer.cornerRadius = 28
        self.imageView?.layer.borderColor = UIColor.orangeColor().CGColor //kTTPurpleColor.CGColor
        self.imageView?.layer.borderWidth = 2.0
        
        self.textLabel?.frame = CGRect(x: 120, y: 5, width: CGRectGetMinX((self.imageView?.frame)!) - 120, height: 25)
        self.textLabel?.textAlignment = .Right
        self.textLabel?.font = UIFont(name: kTTUIDefaultLightFont, size: 22)
        self.textLabel?.textColor = UIColor.orangeColor() //kTTPurpleColor
        
        self.detailTextLabel?.frame = CGRect(x: 120, y: CGRectGetMaxY((self.textLabel?.frame)!), width: CGRectGetMinX((self.imageView?.frame)!) - 120, height: 20)
        self.detailTextLabel?.textAlignment = .Right
        self.detailTextLabel?.font = UIFont(name: kTTUIDefaultLightFont, size: 14)
        self.detailTextLabel?.textColor = UIColor.whiteColor()
        
        self.timestampLabel?.frame = CGRect(x: 120, y: CGRectGetMaxY((self.detailTextLabel?.frame)!), width: CGRectGetMinX((self.imageView?.frame)!) - 120, height: 13)
        self.timestampLabel?.textAlignment = .Right
        self.timestampLabel?.font = UIFont(name: kTTUIDefaultLightFont, size: 10)
        self.timestampLabel?.textColor = UIColor.whiteColor()
        self.addSubview(self.timestampLabel!)
    }

}
