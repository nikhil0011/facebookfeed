//
//  AutogrowingTableViewCell.swift
//  facebook-feed
//
//  Created by Admin on 8/30/18.
//  Copyright © 2018 demo. All rights reserved.
//

import UIKit

class AutogrowingTableViewCell: UITableViewCell {
    let statusTextView: UITextView = {
        let textview = UITextView()
        textview.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ut gravida ipsum. Mauris porta porttitor egestas. Aenean mollis eget dui mattis tincidunt. Suspendisse at condimentum nibh. In aliquam ante turpis, sed suscipit nulla fermentum eu. Morbi vitae accumsan urna. Quisque laoreet ipsum vitae pellentesque dapibus. Cras ullamcorper libero est, id laoreet mauris elementum vel. Nullam posuere diam nunc, eu sagittis orci maximus nec. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean lobortis sem bibendum, dapibus felis eu, porttitor nulla. Ut eu sollicitudin quam, eu pellentesque tortor. Morbi eu nibh sit amet velit sodales bibendum semper id purus. Phasellus quam est, luctus a quam ut, suscipit commodo nulla. Nullam rhoncus luctus sagittis. Vestibulum porttitor tellus nec ipsum rutrum lobortis."
        textview.font = UIFont.preferredFont(forTextStyle: .headline)
         textview.isScrollEnabled = false
        textview.translatesAutoresizingMaskIntoConstraints  = false

        return textview
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init decoder has been implemented")
    }
    
    func setupView(){
        /*
         *Here order of condtraint will not affect as all view are on the basis of addSubview() called
         *Not on the basis of constraints orderd
         */
        backgroundColor = .white
        addSubview(statusTextView)
        addVisualConstraints(format: "H:|-8-[v0]-8-|", view: statusTextView)
        addVisualConstraints(format: "V:|-20-[v0]-20-|",view: statusTextView)
    }
}
