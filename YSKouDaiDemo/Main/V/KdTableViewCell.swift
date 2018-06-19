//
//  KdTableViewCell.swift
//  KoudaiDemo
//
//  Created by guangwei li on 2018/6/19.
//  Copyright © 2018年 guangwei li. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

@objc protocol delegateCell {
    func clickBtn(tag:Int)->Void
}

class KdTableViewCell: UITableViewCell {

    var imgview:UIImageView?
    var label:UILabel?
    var btnA:UIButton?
    var btnB:UIButton?
    
   weak var delegate:delegateCell?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
//        backgroundColor = UIColor.red
        imgview = UIImageView()
        addSubview(imgview!)
        imgview?.snp.makeConstraints{make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.width.equalTo(UIScreen.main.bounds.width-20)
            make.height.equalTo(UIScreen.main.bounds.width/2)
        }
        label = UILabel()
//        label?.adjustsFontSizeToFitWidth = true
        label?.numberOfLines = 0
        addSubview(label!)
        label?.snp.makeConstraints{make in
            make.top.equalTo((imgview?.snp.bottom)!).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.width.equalTo(UIScreen.main.bounds.width-20)
        }
        btnA = UIButton.init(type: .system)
        btnA?.backgroundColor = UIColor.blue
        btnA?.setTitle("A", for: .normal)
        btnA?.setTitleColor(UIColor.white, for: .normal)
        btnA?.tag = 1001
        btnA?.addTarget(self, action: #selector(click(btn:)), for: .touchUpInside)
        addSubview(btnA!)
        btnA?.snp.makeConstraints{make in
            make.top.equalTo((label?.snp.bottom)!).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.width.equalTo((UIScreen.main.bounds.width-30)/2)
            make.height.equalTo(44)
        }
        
        btnB = UIButton.init(type: .system)
        btnB?.setTitle("B", for: .normal)
        btnB?.backgroundColor = UIColor.blue
        btnB?.tag = 1002
        btnB?.setTitleColor(UIColor.white, for: .normal)
        btnB?.addTarget(self, action: #selector(click(btn:)), for: .touchUpInside)
        addSubview(btnB!)
        btnB?.snp.makeConstraints{make in
            make.top.equalTo((label?.snp.bottom)!).offset(10)
            make.left.equalTo((btnA?.snp.right)!).offset(10)
            make.width.equalTo((UIScreen.main.bounds.width-30)/2)
            make.height.equalTo(44)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func click(btn:UIButton){
       delegate?.clickBtn(tag: btn.tag)
    }
    func loadData(img:String,text:String){
        imgview?.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: img)!))
        label?.text = text
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    // MARK: - 设置为true 让自身成为第一响应者
    override var canBecomeFirstResponder: Bool {
        return true
    }
    // MARK: - 设置为false 不使用系统自带的item
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
}
