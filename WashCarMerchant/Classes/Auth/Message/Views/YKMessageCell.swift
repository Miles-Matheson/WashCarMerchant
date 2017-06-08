//
//  YKMessageCell.swift
//  WashCarClient
//
//  Created by kevin on 2017/5/10.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

class YKMessageCell: UITableViewCell {

    @IBOutlet weak var leftImgView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    var badgeView: JSBadgeView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        badgeView = JSBadgeView.init(parentView: leftImgView, alignment: JSBadgeViewAlignment.topRight)
//        badgeView.badgePositionAdjustment = CGPoint.init(x: 0, y: 3)
        badgeView.badgeBackgroundColor = UIColor.red
        badgeView.badgeOverlayColor = UIColor.clear
        badgeView.badgeStrokeColor = UIColor.red
        
    }

    func setBadge(num: Int){
        badgeView.badgeText = num <= 0 ? nil : "\(num)"
        badgeView.setNeedsLayout()
    }
    
}
