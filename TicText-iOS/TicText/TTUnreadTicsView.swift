//
//  TTUnreadTicsView.swift
//  TicText
//
//  Created by Kevin Yufei Chen on 10/12/15.
//  Copyright © 2015 Kevin Yufei Chen. All rights reserved.
//

import UIKit

let kTTUnreadTicsViewHeight: CGFloat = 44.0

protocol TTUnreadTicsViewDataSource: NSObjectProtocol {
    func numberOfUnreadTicsInUnreadTicsView(unreadTicsView: TTUnreadTicsView) -> Int
}

protocol TTUnreadTicsViewDelegate: NSObjectProtocol {
    func didTapBannerButtonInUnreadTicsView(unreadTicsView: TTUnreadTicsView)
}

class TTUnreadTicsView: UIView {
    
    weak var dataSource: TTUnreadTicsViewDataSource?
    weak var delegate: TTUnreadTicsViewDelegate?
    
    private var titleLabel: UILabel!
    private var unreadTicsNumberLabel: UILabel!
    private var bannerButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = kTTPurpleColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        self.titleLabel = UILabel(frame: CGRect(x: 60, y: 0, width: self.bounds.width - 120, height: self.bounds.height))
        self.titleLabel.minimumScaleFactor = 0.7
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.textColor = UIColor.whiteColor()
        self.titleLabel.textAlignment = .Center
        self.titleLabel.font = UIFont(name: kTTUIDefaultLightFont, size: self.titleLabel.font.pointSize)
        self.addSubview(self.titleLabel)
        
        self.unreadTicsNumberLabel = UILabel(frame: CGRect(x: self.bounds.width - 50, y: 10, width: 40, height: 24))
        self.unreadTicsNumberLabel.textColor = kTTPurpleColor
        self.unreadTicsNumberLabel.backgroundColor = UIColor.whiteColor()
        self.unreadTicsNumberLabel.textAlignment = .Center
        self.unreadTicsNumberLabel.layer.masksToBounds = true
        self.unreadTicsNumberLabel.layer.cornerRadius = 12
        self.unreadTicsNumberLabel.font = UIFont(name: kTTUIDefaultLightFont, size: self.unreadTicsNumberLabel.font.pointSize)
        self.addSubview(self.unreadTicsNumberLabel)
        
        self.bannerButton = UIButton(frame: self.bounds)
        self.bannerButton.addTarget(self, action: "didTapBannerButton:", forControlEvents: .TouchUpInside)
        self.addSubview(self.bannerButton)
        
        if (self.dataSource?.numberOfUnreadTicsInUnreadTicsView(self) == 0) {
            self.titleLabel.text = "You have no new Tics"
        } else {
            self.titleLabel.text = "Tap to view your unread Tics"
        }
        self.unreadTicsNumberLabel.text = self.dataSource?.numberOfUnreadTicsInUnreadTicsView(self).description
    }
    
    func didTapBannerButton(button: UIButton) {
        self.delegate?.didTapBannerButtonInUnreadTicsView(self)
    }

}
