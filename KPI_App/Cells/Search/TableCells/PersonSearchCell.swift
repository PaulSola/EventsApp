//
//  PersonSearchCell.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/2/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class PersonSearchCell : UITableViewCell {
    
    let imageSize : CGFloat = 50
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    lazy var userImage : UIImageView = {
        let userView = UIImageView()
        userView.layer.masksToBounds = false
        userView.clipsToBounds = true
        userView.layer.cornerRadius = imageSize / 2
        userView.contentMode = .scaleAspectFill
        userView.layer.borderWidth = 1
        userView.layer.borderColor = UIColor.black.cgColor
        userView.translatesAutoresizingMaskIntoConstraints = false
        return userView
    }()
    
    var person : User!
    
    
    func configureCell(with person : User){
        self.person = person
        userImage.kf.setImage(with: person.imageURL)
        titleLabel.text = person.nickName
        setUpView()
    }
    
    func setUpView(){
        selectionStyle = .none
        contentView.addSubview(userImage)
        userImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        userImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: imageSize).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: imageSize).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 10).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
    
    
    
}
