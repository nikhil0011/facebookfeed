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
//    var flowLayout: UICollectionViewFlowLayout {
//        return self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.flowLayout.estimatedItemSize = CGSize(width: view.frame.width, height: 344)
        let postbyMark = Post()
        postbyMark.name = "Mark Zuckerberg"
        postbyMark.statusText = "You code only once but it effects by millions Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porta sodales neque, quis porta elit faucibus quis. Morbi vitae luctus nibh, id volutpat mauris. Integer sagittis sagittis nisi vitae "
        postbyMark.profileImageName = "zuckprofile"
        postbyMark.location = "January 18 ・ San Hose ・"
        postbyMark.statusImageName = "https://i.pinimg.com/564x/36/cb/3e/36cb3e8edbc43330e2eb50652f4cd170.jpg"
        postbyMark.numLikes = 190
        postbyMark.numComment = 1000
        
        let postbySteve = Post()
        postbySteve.name = "Alan Walker"
        postbySteve.statusText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porta sodales neque, quis porta elit faucibus quis. Morbi vitae luctus nibh, id volutpat mauris. Integer sagittis sagittis nisi vitae suscipit. Phasellus nisl mauris, gravida ac neque a, venenatis pulvinar eros. Sed tempus tellus quam, ut convallis orci lobortis sit amet. Donec enim risus, dignissim ac velit non, varius iaculis turpis. Nam et elementum leo. Aliquam vehicula mi quis justo dictum euismod. Praesent sit amet porttitor nisl, sit amet semper neque. Donec sit amet ipsum eget mi aliquet iaculis eget et ligula. Etiam a orci non libero vestibulum fermentum nec quis mauris."
        postbySteve.profileImageName = "steve_profile"
        postbySteve.location = "December 18 ・ London ・"
        postbySteve.statusImageName = "https://i.pinimg.com/564x/a4/48/9e/a4489ecc55fb154000c92270c0fbb645.jpg"
        postbySteve.numLikes = 440
        postbySteve.numComment = 9900
        
        
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
//        return UICollectionViewFlowLayoutAutomaticSize
    }
}
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
