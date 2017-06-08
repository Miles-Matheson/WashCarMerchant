//
//  YKMessageController.swift
//  WashCarClient
//
//  Created by kevin on 2017/5/10.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

let kSepLineColor = UIColor.init(red: 231/255.0, green: 231/255.0, blue: 231/255.0, alpha: 1.0)

class YKMessageController: SuperViewController,UITableViewDelegate,UITableViewDataSource {
    
    var _tableView: UITableView!
    
    let imgs   = ["center_dd","center_tz","center_gg"]
    let titles = ["订单消息","通知消息","公告"]
    
    var msgCenter: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestMsgData()
    }
    
    func setNav(){
        self.setNavWithTitle("消息中心", isShowBack: true)
    }
    
    func setUI(){
        setTableView()
    }
    
    func setTableView(){
        _tableView = UITableView.init(frame: CGRect.zero, style: UITableViewStyle.grouped)
        self.view.addSubview(_tableView)
        _tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        _tableView.delegate = self
        _tableView.dataSource = self
        _tableView.backgroundColor = kSepLineColor
        _tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        _tableView.register(UINib.init(nibName: "YKMessageCell", bundle: nil), forCellReuseIdentifier: "YKMessageCell")
    }
    
    // MARK: UITableViewDelegate && UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 63
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YKMessageCell") as! YKMessageCell
        cell.leftImgView.image = UIImage.init(named: imgs[indexPath.row])
        cell.titleLbl.text = titles[indexPath.row]
        
        let msgKeys = ["order","infoMsg","noticeMsg"]
        let noReadKeys = ["orderNoReadCount","infoNoReadCount","noticeNoReadCount"]
        let msg = msgCenter?[msgKeys[indexPath.row]]
        cell.contentLbl.text = msg?["content"].stringValue
        cell.timeLbl.text = msg?["createDate"].stringValue
        cell.setBadge(num: msgCenter?[noReadKeys[indexPath.row]].intValue ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let msgListVC = YKMessageListVC()
        msgListVC.type = YKMessageListType(rawValue: indexPath.row+1)
        self.navigationController?.pushViewController(msgListVC, animated: true)
        //        let noReadKeys = ["orderNoReadCount","infoNoReadCount","noticeNoReadCount"]
        //        msgCenter?[noReadKeys[indexPath.row]] = "0"
        //        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.none)
    }




    func requestMsgData(){
        
        weak var selfWeak = self
        
        let uid = UserDefaults.standard.object(forKey: "userId") ?? ""
        
//        let userId =  YKManager.shared().userId! as NSString
        
        YKRequest.postData(withHost: YKServer, path: YKUrl.commonUrl(), params: ["key":"MESSAGECENTER","userId":uid,"type":"1",], isCache:false , isShowLoading: false, success: { (json) in
            
            let jsonModel = JSON(json ?? "")
            if jsonModel["code"].intValue == 10000 {
                selfWeak?.msgCenter = jsonModel
                selfWeak?._tableView.reloadData()
            }

        }) {
            
        }
    }
    
}
