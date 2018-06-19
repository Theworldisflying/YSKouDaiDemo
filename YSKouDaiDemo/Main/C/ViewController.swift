//
//  ViewController.swift
//  YSKouDaiDemo
//
//  Created by guangwei li on 2018/6/19.
//  Copyright © 2018年 guangwei li. All rights reserved.
//

import UIKit

import Moya
import Kingfisher
import SwiftyJSON

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,delegateCell {
   
    
    
    let cellId = "cell"
     var tableView:UITableView?
    var dataArr = Array<JSON>()
    
let provider = MoyaProvider<NetWorkManager>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "首页"
    
        initTableView()
        
        Network.request(.list, success: {(json) in
            print("baisi=\(String(describing: json.array?.count))=====\(json)")
//                dataArr = json
//            guard let arr = json.array else {
//                return
//            }
            self.dataArr = json.array!
            self.tableView?.reloadData()
                    }, error: {(error) in
            
                    }, failure: {(failure) in
            
                    })
    }
    func clickBtn(tag: Int) {
        if tag == 1001 {
           self.navigationController?.pushViewController(AViewController(), animated: true)
        }else{
            self.navigationController?.pushViewController(BViewController(), animated: true)
        }
    }

    func initTableView(){
        
        
        
        let table = UITableView.init(frame: view.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self
        
        table.separatorStyle = .none
        table.selectRow(at: IndexPath.init(row: 1, section: 0), animated: true, scrollPosition: .none)
        
        table.register(KdTableViewCell.classForCoder(), forCellReuseIdentifier: cellId)
        
        view.addSubview(table)
        
        tableView = table
        
        //默认选中第一个
        let indexPath = IndexPath.init(row: 1, section: 0)
        table.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let t = self.dataArr[indexPath.row]["text"].rawString()! as NSString
        var size = CGSize(width: UIScreen.main.bounds.width-20, height: 500)
        size = t.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)], context: nil).size
        return view.bounds.size.width/2 + size.height + 40 + 44
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        var cell = tableView.dequeueReusableCell(withIdentifier: menuCell) as! MenuTableViewCell
        let cell  = KdTableViewCell.init(style: .default, reuseIdentifier: cellId)
        cell.delegate = self
        
        //        cell?.textLabel?.text = arr?[indexPath.row]
        //
        
        cell.selectionStyle = .none
        let img = self.dataArr[indexPath.row]["image"].rawString()
        let text = self.dataArr[indexPath.row]["text"].rawString()
        cell.loadData(img: img!, text: text!)
        
//        cell1.setContent(str: (arr?[indexPath.row])!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }

//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 10
//    }
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let v = UIView()
//        return v
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//
//extension  ViewController:UITableViewDataSource,UITableViewDelegate{
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5;
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        var cell:KdTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId) as! KdTableViewCell
////        if cell == nil{
//          let  cell = KdTableViewCell.init(style: .default, reuseIdentifier: cellId)
////        }
//
//        cell.loadData(img: "=====", text: "dsafdaf")
//
//
//        return cell
//    }
//
//
//
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
//
//
//
//
//}
