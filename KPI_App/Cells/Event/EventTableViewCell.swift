//
//  AboutMeTableViewCell.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 5/15/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//


import UIKit
import Kingfisher

class EventTableViewCell: UITableViewCell {
    
    var event : SimpleEvent! ; var topView : UIViewController!
    
    let likeView = LikeMeView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    
    let data = MyData()
    
    let baseView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        //        view.layer.shadowColor = UIColor.black.cgColor
        //        view.layer.shadowOpacity = 0.5
        //        view.layer.shadowOffset = CGSize.init(width: -10, height: 10)
        //        view.layer.shadowRadius = 5
        
        
        
        return view
    }()
    
    let view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = false
        view.backgroundColor = .white
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.init(width: -10, height: 10)
        view.layer.shadowRadius = 5
        
        return view
    }()
    
    let titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    let eventImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        image.backgroundColor = UIColor.clear
        
        return image
    }()
    
    let eventTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Some"
        label.font = UIFont(name:"Helvetica", size: 21)
        label.numberOfLines = 1
        return label
    }()
    
    lazy var mapButton : UIButton = {
        let image = UIImage(named: "mapLogo") as UIImage?
        let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(showOnMap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func showOnMap(){
        let eventData = ["event" : event] as [AnyHashable : Any]
        NotificationCenter.default.post(name: .showEventOnMap, object: self, userInfo: eventData)
        topView.tabBarController?.selectedIndex = 2
    }
    
    let eventUsersView : EventUsersView = {
        let eUV = EventUsersView()
        eUV.translatesAutoresizingMaskIntoConstraints = false
        return eUV
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureNightMode(){
        
        //titleView.backgroundColor = .white
        contentView.backgroundColor = #colorLiteral(red: 0.004211155586, green: 0.01019812174, blue: 0.1954909581, alpha: 1)
        view.layer.shadowColor = UIColor.clear.cgColor
    }
    
    func configureDayMode(){
        
        //robotActionTypeTitle.textColor = .black
        contentView.backgroundColor = #colorLiteral(red: 0.9313134518, green: 0.9313134518, blue: 0.9313134518, alpha: 1)
        view.layer.shadowColor = UIColor.black.cgColor
    }
    
    func createView(event : SimpleEvent, topView : UIViewController){
        self.event = event ; self.topView = topView
        
        self.selectionStyle = .none
        self.backgroundColor = #colorLiteral(red: 0.9266933693, green: 0.9266933693, blue: 0.9266933693, alpha: 1)
        self.contentView.addSubview(view)
        self.contentView.addSubview(baseView)
        
        baseView.addSubview(eventImageView)
        baseView.addSubview(titleView)
        baseView.addSubview(mapButton)
        titleView.addSubview(eventTitle)
        titleView.addSubview(likeView)
        titleView.addSubview(eventUsersView)
        
        
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        view.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        view.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25).isActive = true
        view.heightAnchor.constraint(equalToConstant: CGFloat(Int(Device.width - 50)/3*4) - 20).isActive = true
        
        baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        baseView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25).isActive = true
        baseView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -25).isActive = true
        baseView.heightAnchor.constraint(equalToConstant: CGFloat(Int(Device.width - 50)/3*4) - 20).isActive = true
        
        mapButton.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 10).isActive = true
        mapButton.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: -10).isActive = true
        mapButton.heightAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 1/5).isActive = true
        mapButton.widthAnchor.constraint(equalTo: baseView.widthAnchor, multiplier: 1/5).isActive = true
        
        eventImageView.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 0).isActive = true
        eventImageView.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: 0).isActive = true
        eventImageView.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: 0).isActive = true
        eventImageView.heightAnchor.constraint(equalToConstant: CGFloat(Int(Device.width - 50)/3*4) - 100).isActive = true
        
        eventImageView.kf.setImage(with: event.getEventImage())
        titleView.topAnchor.constraint(equalTo: eventImageView.bottomAnchor, constant: 0).isActive = true
        titleView.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: 0).isActive = true
        titleView.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: 0).isActive = true
        titleView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor, constant: 0).isActive = true
        titleView.layoutIfNeeded()
        
        likeView.translatesAutoresizingMaskIntoConstraints = false
        likeView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor).isActive = true
        likeView.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: -20).isActive = true
        likeView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        likeView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        eventTitle.topAnchor.constraint(equalTo: titleView.topAnchor, constant: 5).isActive = true
        eventTitle.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: 10).isActive = true
        eventTitle.rightAnchor.constraint(equalTo: likeView.leftAnchor, constant: -10).isActive = true
        eventTitle.text = event.getTitle()
        
        
        let eventUsersViewSize = titleView.bounds.size.height * 2 / 5
        eventUsersView.setUpView(users: event.getPreMembers().users, size : eventUsersViewSize)
        eventUsersView.topAnchor.constraint(equalTo: eventTitle.bottomAnchor, constant: 10).isActive = true
        eventUsersView.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: 10).isActive = true
        eventUsersView.heightAnchor.constraint(equalToConstant: eventUsersViewSize).isActive = true
        eventUsersView.widthAnchor.constraint(equalToConstant: eventUsersViewSize * 2).isActive = true
        
    }
    
}
