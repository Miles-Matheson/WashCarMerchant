//
//  YKNoticeDetailCell.swift
//  WashCarClient
//
//  Created by kevin on 2017/5/10.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

class YKNoticeDetailCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var fromLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleLbl.text = ""
        fromLbl.text = ""
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let contentH: CGFloat = contentLbl.sizeThatFits(size).height
        return CGSize.init(width: size.width, height: contentH+70)
    }
    
}
