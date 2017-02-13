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

        let dic = ["Cell":"MainCell","isAttached":"0"]
        dataArray.append(dic)

    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let dic = dataArray[indexPath.row] as! [String : Any]

        if dic["Cell"] as! String == "MainCell" {

            var cell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as? MainCell
            if cell == nil { // no value
                cell = MainCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "MainCell")
            }
            cell?.textLabel?.text = "\(indexPath.row)"
            return cell!
        } else if dic["Cell"] as! String == "AttachedCell"{

            var cell = tableView.dequeueReusableCell(withIdentifier: "AttachedCell") as? AttachedCell
            if cell == nil { // no value
                cell = AttachedCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "AttachedCell")
            }
            cell?.textLabel?.text = "AttachedCell \(indexPath.row)"
            return cell!
        }

        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil { // no value
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        }

        return cell!
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        var path:IndexPath? = nil

        let dic = dataArray[indexPath.row] as! [String : Any]

        if dic["Cell"] as! String == "MainCell" {
            path = IndexPath(item: indexPath.row+1, section: indexPath.section)
        } else if dic["Cell"] as! String == "AttachedCell"{
            path = indexPath
        }

        let isAttached = dic["isAttached"] as! String

        if isAttached == "1" {
            // 关闭附加cell

            let dic = ["Cell":"MainCell","isAttached":"0"]
            dataArray[path!.row-1] = dic
            dataArray.remove(at: path!.row)

            self.tableViewMain.beginUpdates()
            self.tableViewMain.deleteRows(at: [path!], with: UITableViewRowAnimation.middle)
            self.tableViewMain.endUpdates()

        } else {
            // 打开附加cell

            let dic = ["Cell":"MainCell","isAttached":"1"]
            dataArray[path!.row-1] = dic

            let addDic = ["Cell":"AttachedCell","isAttached":"1"]
            dataArray.insert(addDic, at: path!.row)

            print(dataArray)
            print(path!.row)

            self.tableViewMain.beginUpdates()
            self.tableViewMain.insertRows(at: [path!], with: UITableViewRowAnimation.middle)
            self.tableViewMain.endUpdates()
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

