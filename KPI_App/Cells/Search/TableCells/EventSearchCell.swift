//
//  EventSearchCell.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/7/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class EventSearchCell : UITableViewCell {
    
        var event : Event!
    
    let eventImageView : UIImageView = {
        let eventIV = UIImageView()
        eventIV.translatesAutoresizingMaskIntoConstraints = false
        return eventIV
    }()
    
    let eventTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let baseView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        view.layer.shadowRadius = 1
        view.layer.shadowOpacity = 0.1

        return view
    }()
    
    func configureCell(with event : Event){
        self.event = event
        eventTitleLabel.text = event.getTitle()
        eventImageView.kf.setImage(with: event.getEventImage())
        
        setUpCell()
    }
    
    func setUpCell(){
        contentView.backgroundColor = #colorLiteral(red: 0.909638479, green: 0.909638479, blue: 0.909638479, alpha: 1)
        selectionStyle = .none

        contentView.addSubview(baseView)
        baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        baseView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        baseView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        baseView.addSubview(eventImageView)
        eventImageView.topAnchor.constraint(equalTo: baseView.topAnchor).isActive = true
        eventImageView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor).isActive = true
        eventImageView.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 0.45).isActive = true
        eventImageView.rightAnchor.constraint(equalTo: baseView.rightAnchor).isActive = true
        
        baseView.addSubview(eventTitleLabel)
        eventTitleLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 20).isActive = true
        eventTitleLabel.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: 15).isActive = true
        eventTitleLabel.rightAnchor.constraint(equalTo: eventImageView.leftAnchor, constant: -10).isActive = true
        
    }
    
}
