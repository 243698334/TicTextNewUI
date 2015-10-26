//
//  TTMyTicsConversationTableViewCell.swift
//  TicText
//
//  Created by Kevin Yufei Chen on 10/13/15.
//  Copyright © 2015 Kevin Yufei Chen. All rights reserved.
//

import UIKit

class TTMyTicsConversationTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = CGRect(x: 45, y: 5, width: 40, height: 40)
        self.imageView?.layer.masksToBounds = true
        self.imageView?.layer.cornerRadius = 20
        self.imageView?.layer.borderColor = UIColor.orangeColor().CGColor
        self.imageView?.layer.borderWidth = 1.0
        
        self.detailTextLabel?.frame = CGRect(x: CGRectGetMaxX(self.bounds) - 100, y: 10, width: 55, height: 30)
        self.detailTextLabel?.textAlignment = .Right
        self.detailTextLabel?.font = UIFont(name: kTTUIDefaultLightFont, size: 14)
        self.detailTextLabel?.textColor = kTTPurpleColor
        
        self.textLabel?.frame = CGRect(x: CGRectGetMaxX((self.imageView?.frame)!), y: 5, width: CGRectGetMinX((self.detailTextLabel?.frame)!) - CGRectGetMaxX((self.imageView?.frame)!), height: 40)
        self.textLabel?.textAlignment = .Center
        self.textLabel?.font = UIFont(name: kTTUIDefaultLightFont, size: 18)
        self.textLabel?.textColor = UIColor.orangeColor()
    }

}
