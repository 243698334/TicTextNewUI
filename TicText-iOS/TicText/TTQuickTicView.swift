//
//  TTQuickTicView.swift
//  TicText
//
//  Created by Kevin Yufei Chen on 10/12/15.
//  Copyright © 2015 Kevin Yufei Chen. All rights reserved.
//

import UIKit

let kTTQuickTicViewHeight: CGFloat = 172.0

@objc protocol TTQuickTicViewDataSource: NSObjectProtocol {
    
    optional func errorMessageInQuickTicView(quickTicView: TTQuickTicView) -> String
}

protocol TTQuickTicViewDelegate: NSObjectProtocol {
    
    func quickTicView(quickTicView: TTQuickTicView, didTapTicItButtonWithText text: String?, image: UIImage?, timeLimit: NSTimeInterval) -> Bool
}

class TTQuickTicView: UIView, UITextViewDelegate {

    weak var dataSource: TTQuickTicViewDataSource?
    weak var delegate: TTQuickTicViewDelegate?
    
    private var titleView: UIView!
    private var titleLabel: UILabel!
    private var newTicInputView: UIView!
    private var newTicTextView: UITextView!
    private var ticItButton: UIButton!
    private var inputToolbarView: UIView!
    private var inputToolbarTextButton: UIButton!
    private var inputToolbarImageButton: UIButton!
    private var inputToolbarTimeLimitButton: UIButton!
    
    private var keyboardImagePickerController: KCKeyboardImagePickerController!
    private var selectedImage: UIImage?
    
    private var newTicTextViewEdited: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        self.titleView = UIView(frame: CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.width, height: 36))
        self.titleView.backgroundColor = kTTUltraLightPurpleColor
        self.addSubview(self.titleView)
        
        self.titleLabel = UILabel(frame: CGRect(x: self.titleView.bounds.origin.x + 20, y: self.titleView.bounds.origin.y, width: self.titleView.bounds.width, height: self.titleView.bounds.height))
        self.titleLabel.backgroundColor = kTTUltraLightPurpleColor
        self.titleLabel.font = UIFont(name: kTTUIDefaultFont, size: 24)
        self.titleLabel.textColor = UIColor.orangeColor()
        self.titleLabel.text = "Quick Tic"
        self.titleView.addSubview(self.titleLabel)
        
        self.newTicInputView = UIView(frame: CGRect(x: self.bounds.origin.x, y: CGRectGetMaxY(self.titleLabel.frame), width: self.bounds.width, height: 100))
        self.newTicInputView.backgroundColor = kTTPurpleColor //UIColor.orangeColor()
        self.addSubview(self.newTicInputView)
        
        self.newTicTextView = UITextView(frame: CGRect(x: self.newTicInputView.bounds.origin.x + 15, y: self.newTicInputView.bounds.origin.y, width: self.newTicInputView.bounds.width - 110 - 15, height: self.newTicInputView.bounds.height))
        self.newTicTextView.delegate = self;
        self.newTicTextView.backgroundColor = UIColor.clearColor()
        self.newTicTextView.tintColor = UIColor.whiteColor()
        self.newTicTextView.textColor = UIColor.whiteColor()
        self.newTicTextView.font = UIFont(name: kTTUIDefaultFont, size: UIFont.systemFontSize())
        self.newTicTextView.spellCheckingType = .Yes
        self.newTicTextView.text = "Start Ticing here..."
        self.newTicTextViewEdited = false
        self.newTicInputView.addSubview(self.newTicTextView)
        
        self.ticItButton = UIButton(frame: CGRect(x: self.bounds.origin.x + CGRectGetMaxX(self.newTicTextView.frame), y: self.bounds.origin.y + 25, width: 100, height: 100))
        self.ticItButton.setImage(UIImage(named: "TicItButton"), forState: .Normal)
        self.ticItButton.addTarget(self, action: "didTapTicItButton:", forControlEvents: .TouchUpInside)
        self.ticItButton.backgroundColor = UIColor.clearColor()
        self.addSubview(self.ticItButton)
        
        self.inputToolbarView = UIView(frame: CGRect(x: self.bounds.origin.x, y: CGRectGetMaxY(self.newTicInputView.frame), width: self.bounds.width, height: 36))
        self.inputToolbarView.backgroundColor = kTTPurpleColor// UIColor.orangeColor()
        let inputToolbarTopBorderLayer = CALayer()
        inputToolbarTopBorderLayer.frame = CGRect(x: 15, y: 0, width: self.inputToolbarView.bounds.width - 110 - 15, height: 1)
        inputToolbarTopBorderLayer.backgroundColor = UIColor.lightGrayColor().CGColor
        self.inputToolbarView.layer.addSublayer(inputToolbarTopBorderLayer)
        self.addSubview(self.inputToolbarView)
        
        self.inputToolbarTextButton = UIButton(frame: CGRect(x: 15, y: 0, width: 36, height: 36))
        self.inputToolbarTextButton.setTitle("Aa", forState: .Normal)
        self.inputToolbarTextButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.inputToolbarView.addSubview(self.inputToolbarTextButton)
        
        self.inputToolbarImageButton = UIButton(frame: CGRect(x: CGRectGetMaxX(self.inputToolbarTextButton.frame), y: 0, width: 36, height: 36))
        self.inputToolbarImageButton.setImage(UIImage(named: "QuickTicViewInputToolbarImageButton"), forState: .Normal)
        self.inputToolbarImageButton.addTarget(self, action: "didTapInputToolbarImageButton:", forControlEvents: .TouchUpInside)
        self.inputToolbarView.addSubview(self.inputToolbarImageButton)
        
        self.inputToolbarTimeLimitButton = UIButton(frame: CGRect(x: CGRectGetMaxX(self.inputToolbarImageButton.frame) + 5, y: 0, width: 128, height: 36))
        self.inputToolbarTimeLimitButton.setTitle("Expire in 1h 30m 50s", forState: .Normal)
        self.inputToolbarTimeLimitButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.inputToolbarTimeLimitButton.titleLabel?.font = UIFont(name: kTTUIDefaultLightFont, size: 14.0)
        self.inputToolbarTimeLimitButton.contentHorizontalAlignment = .Left
        self.inputToolbarView.addSubview(self.inputToolbarTimeLimitButton)
        
        self.keyboardImagePickerController = KCKeyboardImagePickerController(parentViewController: self.delegate as! UIViewController)
        self.keyboardImagePickerController.forceTouchPreviewEnabled = true
        let parentViewController = self.delegate as! UIViewController
        parentViewController.view.addSubview(self.keyboardImagePickerController.imagePickerView)

        self.keyboardImagePickerController.addAction(KCKeyboardImagePickerAction(optionButtonTag: 1, title: NSString(string: "Select") as String, forceTouchEnabled: true, handler: { (selectedImage: UIImage!) -> Void in
            self.selectedImage = selectedImage
        }))
    }
    
    func didTapTicItButton(button: UIButton) {
        self.delegate?.quickTicView(self, didTapTicItButtonWithText: "", image: nil, timeLimit: 100)
        //self.keyboardImagePickerController.hideKeyboardImagePickerViewAnimated(true)

    }
    
    func didTapInputToolbarImageButton(button: UIButton) {
        //self.keyboardImagePickerController.showKeyboardImagePickerViewAnimated(true)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]?.CGRectValue
        self.keyboardImagePickerController.keyboardFrame = keyboardFrame!
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if (self.newTicTextViewEdited == false) {
            textView.text = ""
            self.newTicTextViewEdited = true
        }
    }


}
