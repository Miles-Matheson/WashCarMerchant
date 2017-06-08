//
//  YKMessageListVC.swift
//  WashCarClient
//
//  Created by kevin on 2017/5/10.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

enum YKMessageListType : Int {
    case order = 1     //订单消息
    case notify   //通知消息
    case pubNotice//公告
}

class YKMessageListVC: SuperViewController,UITableViewDelegate,UITableViewDataSource {

    var _tableView: UITableView!
    
    var type: YKMessageListType?
    
    func setType(type: Int){
        self.type = YKMessageListType.init(rawValue: type)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        setUI()
        requestMainData()
    }
    
    func setNav(){
        self.setNavWithTitle(type == YKMessageListType.order ? "订单消息" : type == YKMessageListType.notify ? "通知消息" : "公告", isShowBack: true)
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
        _tableView.sectionFooterHeight = CGFloat.leastNormalMagnitude
        _tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        _tableView.register(UINib.init(nibName: "YKMessageListCell", bundle: nil), forCellReuseIdentifier: "YKMessageListCell")
    }
    
    // MARK: UITableViewDelegate && UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = self.contentArr() else { return 0 }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YKMessageListCell") as! YKMessageListCell
        cell.type = type ?? YKMessageListType.order
        guard let dataSource = self.contentArr() else { return cell }
        cell.msg = dataSource[indexPath.row] as? JSON
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let aType = type else {
            return
        }
        guard let dataSource = self.contentArr() else { return }
        let msg = dataSource[indexPath.row] as? JSON
        switch aType {
        case YKMessageListType.order:
            
            let orderDetailVC = OrderDetailController()
            orderDetailVC.orderId = msg?["orderId"].stringValue
            
            self.navigationController?.pushViewController(orderDetailVC, animated: true)
            break
        case YKMessageListType.notify:
            switch msg?["stat"].intValue ?? 1 {
            case 4:
                //定向推送
                
                let noticeDetailVC = YKNoticeDetailVC()
                noticeDetailVC.msg = msg
        
                self.navigationController?.pushViewController(noticeDetailVC, animated: true)
                break
            case 5:
                //惩罚消息
                
                break
            case 6:
                //评论消息
                
                break
            case 7:
                //付款消息
                
                break
            default:
                break
            }
            break
        case YKMessageListType.pubNotice:
            let noticeDetailVC = YKNoticeDetailVC()
            noticeDetailVC.msg = msg
            self.navigationController?.pushViewController(noticeDetailVC, animated: true)
            break
        }
    }

    func requestMainData() {
    
        
        weak var selfWeak = self
        let arrKeys: [String] = ["orderMessageList","infoMsgList","noticeList"]
        
        let key = arrKeys[(type?.rawValue ?? 1)-1]

        let uid = UserDefaults.standard.object(forKey: "userId") ?? ""
        
        self.setScroll(_tableView, firstPageNor: 1, pageSize: 10, networkCallback: { (page, completionCallback) in

            YKRequest.postData(withHost: YKServer, path: YKUrl.commonUrl(), params: ["key":"MESSAGELIST","type":"1","userId":uid,"pageNo":"1","pageSize":"10","stat":"\(selfWeak?.type?.rawValue ?? 1)"], isCache: false, isShowLoading: false, success: { (json) in
                let jsonModel = JSON(json ?? "")
                completionCallback?(jsonModel["code"].intValue == 10000, jsonModel[key].arrayValue)
            }, fail: { 
                completionCallback?(false,[])
            })
        }) { (page) in
            if page != 1 {
                selfWeak?.view.showCenterToast("没有更多数据了")
            }
        }
        self.refreshScroll()
    }
}
