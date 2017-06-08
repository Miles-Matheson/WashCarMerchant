//
//  YKLeftLblRightSwitchCell.swift
//  MerchantCenter
//
//  Created by kevin on 2017/3/3.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

protocol YKLeftLblRightSwitchCellDelegate {
    func switchValueChanged(cell: YKLeftLblRightSwitchCell,_ aSwitch: UISwitch)
}

class YKLeftLblRightSwitchCell: UITableViewCell {

    @IBOutlet weak var leftLbl: UILabel!
    
    @IBOutlet weak var rightSwitch: UISwitch!
    
    @IBOutlet weak var lineView: UIView!
    
    var delegate: YKLeftLblRightSwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        delegate?.switchValueChanged(cell: self, sender)
    }
    
}
