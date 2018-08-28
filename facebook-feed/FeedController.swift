//
//  ViewController.swift
//  facebook-feed
//
//  Created by Admin on 8/27/18.
//  Copyright © 2018 demo. All rights reserved.
//

import UIKit
let cellid = "cellid"

class FeedController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Facebook Feed"
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        // Do any additional setup after loading the view, typically from a nib.
        collectionView?.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: cellid)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath)
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 60)
    }
}

