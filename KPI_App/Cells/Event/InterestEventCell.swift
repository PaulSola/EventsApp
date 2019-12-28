//
//  EventSearchCell.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/2/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class InterestEventCell : UITableViewCell {
    
    var event : Event!
    let eventImage : UIImageView = {
        let imageV = UIImageView()
        return imageV
    }()
    
    func configureCell(with event : Event){
        self.event = event
        self.textLabel?.text = event.getTitle()
    }
    
}
