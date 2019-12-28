//
//  Data.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 5/15/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class Device {
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func safeHeight(with view : UIView) -> CGFloat{
        let guide = view.safeAreaLayoutGuide
        let height = guide.layoutFrame.size.height
        return height
    }
    func safeWidth(with view : UIView) -> CGFloat{
        let guide = view.safeAreaLayoutGuide
        let width = guide.layoutFrame.size.width
        return width
    }
}
