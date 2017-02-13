//
//  TapView.swift
//  TwoGroup
//
//  Created by tangshenchun on 2017/2/10.
//  Copyright © 2017年 tangshenchun. All rights reserved.
//

import UIKit

class TapView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var label:UILabel?
    func setupUI(frame:CGRect) {
        self.frame = frame

        label = UILabel(frame:CGRect(x: 20, y: 5, width: 200, height: 30))
  
        self.addSubview(label!)
    }

}
