//
//  FeedCell.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 8/5/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import UIKit

class FeedCell : BaseCollectionCell, UITableViewDelegate, UITableViewDataSource {
    
    var homeControllernavigationController: UINavigationController?
     let nonBackEventHelper = NonBackEvent()
    let cellId = "cellId"
    var events = [Event]()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) 
        let event = events[indexPath.row]
        cell.textLabel?.text = event.getTitle()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    
    lazy var tableView : UITableView =  {
        let tv = UITableView()
        tv.dataSource = self
        tv.delegate = self
        tv.backgroundColor = #colorLiteral(red: 0.9313134518, green: 0.9313134518, blue: 0.9313134518, alpha: 1)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        return tv
    }()
    
    func setupTableView(){
        addSubview(tableView)
        tableView.zeroConstraint(with: self)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        //tableView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        //tableView.scrollIndicatorInsets = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)

        events = nonBackEventHelper.getEvents()
    }

    override func setupViews(){
        setupTableView()
        backgroundColor = #colorLiteral(red: 0.9313134518, green: 0.9313134518, blue: 0.9313134518, alpha: 1)
    }
    
    
}
