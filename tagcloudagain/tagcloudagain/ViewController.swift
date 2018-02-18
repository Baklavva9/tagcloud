//
//  ViewController.swift
//  TagsCloud
//
//  Created by Woohoo on 4/18/17.
//  Copyright © 2017 iostutorilajunction.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var txtInput: UITextField!
    var tagsArray:[String] = Array()
    
    var tagHolder = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTagCloud(OnView: self.view, withArray: tagsArray as [AnyObject])
        
        txtInput?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTagCloud(OnView view: UIView, withArray data:[AnyObject]) {
        
//    if let tagHolder .... {
        
        for tempView in view.subviews {
            if tempView.tag != 0 {
                tempView.removeFromSuperview()
            }
        }
        
        var xPos:CGFloat = 15.0
        var ypos: CGFloat = 130.0
        var tag: Int = 1
        for str in data  {
            let startstring = str as! String
            let width = startstring.widthOfString(usingFont: UIFont(name:"verdana", size: 13.0)!)
            let checkWholeWidth = CGFloat(xPos) + CGFloat(width) + CGFloat(13.0) + CGFloat(25.5 )//13.0 is the width between lable and cross button and 25.5 is cross button width and gap to righht
            if checkWholeWidth > UIScreen.main.bounds.size.width - 30.0 {
                //we are exceeding size need to change xpos
                xPos = 15.0
                ypos = ypos + 29.0 + 8.0
            }
            
            let bgView = UIView(frame: CGRect(x: xPos, y: ypos, width:width + 17.0 + 38.5 , height: 29.0))
            bgView.layer.cornerRadius = 14.5
            bgView.backgroundColor = UIColor(red: 33.0/255.0, green: 135.0/255.0, blue:199.0/255.0, alpha: 1.0)
            bgView.tag = tag
            
            let textlable = UILabel(frame: CGRect(x: 17.0, y: 0.0, width: width, height: bgView.frame.size.height))
            textlable.font = UIFont(name: "verdana", size: 13.0)
            textlable.text = startstring
            textlable.textColor = UIColor.white
            bgView.addSubview(textlable)
            
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: bgView.frame.size.width - 2.5 - 23.0, y: 3.0, width: 23.0, height: 23.0)
            button.backgroundColor = UIColor.white
            button.layer.cornerRadius = CGFloat(button.frame.size.width)/CGFloat(2.0)
            button.setImage(UIImage(named: "CrossSmall"), for: .normal)
            button.tag = tag
            button.addTarget(self, action: #selector(removeTag(_:)), for: .touchUpInside)
            bgView.addSubview(button)
            xPos = CGFloat(xPos) + CGFloat(width) + CGFloat(17.0) + CGFloat(43.0)
            view.addSubview(bgView)
            tag = tag  + 1
            
        }
        
    }
    
    @objc func removeTag(_ sender: AnyObject) {
        tagsArray.remove(at: (sender.tag - 1))
        createTagCloud(OnView: self.view, withArray: tagsArray as [AnyObject])
    }
    
    @IBAction func addTag(_ sender: AnyObject) {
        
        if txtInput.text?.characters.count != 0 {
            tagsArray.append(txtInput.text!)
            createTagCloud(OnView: self.view, withArray: tagsArray as [AnyObject])
        }
    }
    
//     function to append tags on the view
    
//     func textFieldDidEndEditing(_ textField: UITextField) {
    
//         txtInput?.delegate = self
//
//        if txtInput.text?.characters.count != 0 {
//            tagsArray.append(txtInput.text!)
//            createTagCloud(OnView: self.view, withArray: tagsArray as [AnyObject])
//        }
//
//    }
    
}
    
//    func reloadViewHoldingTextView() {
//
//        textView?.text = textHolder
//        resizeTextViewFrame()
//
//    }

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
}




