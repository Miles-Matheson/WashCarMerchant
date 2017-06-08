//
//  YKSignRemindView.swift
//  WashCarClient
//
//  Created by kevin on 2017/5/23.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

class YKSignRemindView: UIView {

    var bgView: UIView!
    var coverView: UIView!
    var topImgView: UIImageView!
    var btmBtn: UIButton!
    
    var onClickBtmBtn: ((_ remindView:UIView,_ btmBtn: UIButton)->Void)?
    
    class func show(_ clickBtmBtnCallback:((_ remindView:UIView,_ btmBtn: UIButton)->Void)?){
        let remindView = YKSignRemindView()
        UIApplication.shared.keyWindow?.addSubview(remindView)
        remindView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        remindView.onClickBtmBtn = clickBtmBtnCallback
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI(){
        weak var selfWeak: YKSignRemindView! = self
        
        bgView = UIView()
        self.addSubview(bgView)
        bgView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        coverView = UIView()
        bgView.addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        coverView.backgroundColor = UIColor.init(white: 50 / 255.0, alpha: 0.75)
        coverView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickCoverView)))
        
        topImgView = UIImageView()
        bgView.addSubview(topImgView)
        topImgView.snp.makeConstraints { (make) in
            make.centerX.equalTo(selfWeak.bgView)
            make.centerY.equalTo(selfWeak.bgView).offset(-60)
        }
        topImgView.image = UIImage.init(named: "qd_bg_alert")
        
        btmBtn = UIButton.init(type: UIButtonType.custom)
        bgView.addSubview(btmBtn)
        btmBtn.snp.makeConstraints { (make) in
            make.top.equalTo(selfWeak.topImgView.snp.bottom).offset(10)
            make.centerX.equalTo(selfWeak.topImgView)
//            make.width.equalTo(150)
//            make.height.equalTo(50)
        }
//        btmBtn.contentMode = UIViewContentMode.scaleAspectFit
        btmBtn.setBackgroundImage(UIImage.init(named: "qd_btn_alert"), for: UIControlState.normal)
        btmBtn.addTarget(self, action: #selector(clickBtmBtn(_ :)), for: UIControlEvents.touchUpInside)
        
    }
    
    func clickCoverView(){
        dismiss()
    }
    
    func dismiss(){
        self.removeFromSuperview()
    }
    
    func clickBtmBtn(_ btmBtn: UIButton){
        //点击底部按钮
        dismiss()
        onClickBtmBtn?(self,btmBtn)
    }
    
}
