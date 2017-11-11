//
// Created by Sandeep Rana on 11/11/17.
// Copyright (c) 2017 thedancho. All rights reserved.
//

import Foundation
import UIKit

class ChartFilled: UIView {
    var width: CGFloat = 50.0;

    override func draw(_ rect: CGRect) {
        let fillrect: CGRect = CGRect(x: 0, y: 0, width: self.width, height: self.frame.height);
        #colorLiteral(red: 0.9925985932, green: 0.8971266747, blue: 0.8981112838, alpha: 1).setFill();
        UIRectFill(fillrect);
        let fillrectRight: CGRect = CGRect(x: self.width, y: 0, width: self.frame.width - self.width, height: self.frame.height);
        #colorLiteral(red: 0.9765608907, green: 0.9770647883, blue: 0.9759072661, alpha: 1).setFill();
        UIRectFill(fillrectRight);

    }

    func fillTill(_ point: CGFloat) {
        self.width = point;
        setNeedsLayout();
        setNeedsDisplay()
    }
}
