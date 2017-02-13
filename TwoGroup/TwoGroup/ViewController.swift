//
//  ViewController.swift
//  TwoGroup
//
//  Created by tangshenchun on 2017/2/10.
//  Copyright © 2017年 tangshenchun. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet var tableViewMain: UITableView!
    
    var dataArray = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableViewMain.dataSource = self
        tableViewMain.delegate = self
        
        var dic:[String:Any] = ["Cell":"MainCell","isFolded":false]
        let arr = ["a","b","c","d"]
        dic.updateValue(arr, forKey: "detail")
        dataArray.append(dic)
        dataArray.append(dic)
        dataArray.append(dic)
        dataArray.append(dic)
        
        print(dataArray)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let dic = dataArray[section] as! [String : Any]
        let isFolded = dic["isFolded"] as! Bool
        let detail = dic["detail"] as! [Any]
        
        return isFolded ? detail.count : 0
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headView :TapView?
        
        if (headView == nil) {
            headView = TapView()
            headView!.setupUI(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
            headView!.backgroundColor = UIColor.red
            headView!.label?.text = "标题 \(section)"
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapEvent(tap:)))
            headView!.addGestureRecognizer(tap)
            headView!.tag = section
            
            return headView!
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //  let dic = dataArray[indexPath.row] as! [String : Any]
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as? MainCell
        if cell == nil { // no value
            cell = MainCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "MainCell")
        }
        cell?.textLabel?.text = "\(indexPath.row)"
        return cell!
        
    }
    
    
    func tapEvent(tap:UITapGestureRecognizer) {
        
        var dic = dataArray[tap.view!.tag] as! [String : Any]
        let isFolded = dic["isFolded"] as! Bool
        
        if isFolded {
            // 关闭附加cell
            
            dic.updateValue(false, forKey: "isFolded")
            dataArray[tap.view!.tag] = dic
            self.tableViewMain.reloadData()

        } else {
            // 打开附加cell
            
            dic.updateValue(true, forKey: "isFolded")
            dataArray[tap.view!.tag] = dic
            
            self.tableViewMain.reloadData()
        }
        print(dataArray)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

