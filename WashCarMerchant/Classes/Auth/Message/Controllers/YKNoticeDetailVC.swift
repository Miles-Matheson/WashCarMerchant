//
//  YKNoticeDetailVC.swift
//  WashCarClient
//
//  Created by kevin on 2017/5/10.
//  Copyright © 2017年 Ecommerce. All rights reserved.
//

import UIKit

class YKNoticeDetailVC: SuperViewController,UITableViewDataSource,UITableViewDelegate {
    
    var _tableView: UITableView!
    
    var msg: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNav()
        setUI()
    }
    
    func setNav(){
        self.setNavWithTitle("公告", isShowBack: true)
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
        _tableView.register(UINib.init(nibName: "YKNoticeDetailCell", bundle: nil), forCellReuseIdentifier: "YKNoticeDetailCell")
    }
    
    // MARK: UITableViewDelegate && UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        weak var selfWeak = self
        return tableView.fd_heightForCell(withIdentifier: "YKNoticeDetailCell", cacheBy: indexPath, configuration: { (cell) in
            selfWeak?.setCell(cell as! YKNoticeDetailCell)
        })
    }
    
    func setCell(_ cell: YKNoticeDetailCell){
        cell.fd_enforceFrameLayout = true
        //        cell.titleLbl.text = "快快洗车在线下单功能公告"
        cell.timeLbl.text = msg?["createDate"].stringValue
        //        cell.fromLbl.text = "快快洗车"
        cell.contentLbl.text = msg?["content"].stringValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YKNoticeDetailCell") as! YKNoticeDetailCell
        setCell(cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
