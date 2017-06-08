//
//  YKMessageListCell.swift
//  WashCarClient
//
//  Created by kevin on 2017/5/10.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

class YKMessageListCell: UITableViewCell {
    
    @IBOutlet weak var timeLbl: UILabel!

    @IBOutlet weak var leftImgView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var contentLbl: UILabel!
    
    var type: YKMessageListType = YKMessageListType.order
    
    var msg: JSON? {
        didSet{
            timeLbl.text = msg?["createDate"].stringValue
            
            leftImgView.sd_setImage(with: URL.init(string: msg?["shopImg"].stringValue ?? ""))
            
            contentLbl.text = msg?["content"].stringValue
            
            if type != YKMessageListType.pubNotice {
                //订单消息、通知消息
                let types = type == YKMessageListType.order ? ["订单支付消息","催单消息","已取消消息","已完成消息"] : ["回复消息","充值消息","优惠券消息","定向推送","惩罚消息","评论消息","付款消息"]
                let typeIndex = (msg?[type == YKMessageListType.order ? "type" : "stat"].intValue ?? 1)-1
                if typeIndex >= 0 && typeIndex < types.count {
                    titleLbl.text = types[typeIndex]
                } else {
                    titleLbl.text = ""
                }
            }
            
            switch type {
            case YKMessageListType.order:
                break
            case YKMessageListType.notify:
                break
            case YKMessageListType.pubNotice:
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLbl.text = ""
        contentLbl.text = ""
    }

    
}
