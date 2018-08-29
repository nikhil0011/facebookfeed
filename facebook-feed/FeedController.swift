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
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let postbyMark = Post()
        postbyMark.name = "Mark Zuckerberg"
        postbyMark.statusText = "You code only once but it runs by millions"

        let postbySteve = Post()
        postbySteve.name = "Alan Walker"
        postbySteve.statusText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porta sodales neque, quis porta elit faucibus quis. Morbi vitae luctus nibh, id volutpat mauris. Integer sagittis sagittis nisi vitae suscipit. Phasellus nisl mauris, gravida ac neque a, venenatis pulvinar eros. Sed tempus tellus quam, ut convallis orci lobortis sit amet. Donec enim risus, dignissim ac velit non, varius iaculis turpis. Nam et elementum leo. Aliquam vehicula mi quis justo dictum euismod. Praesent sit amet porttitor nisl, sit amet semper neque. Donec sit amet ipsum eget mi aliquet iaculis eget et ligula. Etiam a orci non libero vestibulum fermentum nec quis mauris."
        posts.append(postbyMark)
        posts.append(postbySteve)
        
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
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FeedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! FeedCollectionViewCell
        cell.post = posts[indexPath.row]
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let statusText = posts[indexPath.item].statusText{
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesDeviceMetrics.union(NSStringDrawingOptions.usesLineFragmentOrigin),attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
            return CGSize(width: view.frame.width, height: rect.height + 370.0)
        }
        return CGSize(width: view.frame.width, height: 370)
    }
}

