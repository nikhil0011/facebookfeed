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
    
    let iconsContainerView: UIView = {
        let containerview = UIView()
        containerview.backgroundColor = .white
        
        //        var arrangedSubView = [UIView]()
        let arrayOfColors: [UIColor] = [.yellow,.red,.blue,.orange,.gray]
        let arrayOfImages: [UIImage]  = [#imageLiteral(resourceName: "blue_like"),#imageLiteral(resourceName: "red_heart"),#imageLiteral(resourceName: "cry"),#imageLiteral(resourceName: "cry_laugh"),#imageLiteral(resourceName: "surprised"),#imageLiteral(resourceName: "angry")]
        //
        //        for color in arrayOfColors{
        //            let view = UIView()
        //            view.backgroundColor = color
        //            arrangedSubView.append(view)
        //        }
        
        //Map Generally,Returns an array containing the results of mapping the given closure
        /// over the sequence's elements.
        //It will return array on the basis of array passed on it (as eg name.lowerstring in few cases)
        //or by utilising it's value in properties of returning array as eg view.color below
        
        
        
        
        let padding: CGFloat = 6
        let iconHeight: CGFloat = 38
        
        //        let arrangedSubView = arrayOfColors.map({(color) -> UIView in
        //            let view = UIView()
        //            view.backgroundColor = color
        //            view.layer.cornerRadius = iconHeight/2
        //            return view
        //        })
        
        let arrangedSubView = arrayOfImages.map({image -> UIView in
            let view = UIImageView(image: image)
            view.isUserInteractionEnabled = true
            view.layer.cornerRadius = iconHeight/2
            return view
        })
        let count = CGFloat(arrangedSubView.count)
        
        let containerWidth = count * iconHeight + (count + 1) * padding
        containerview.frame = CGRect(x: 0, y: 0, width: containerWidth, height: iconHeight + 2 * padding)
        containerview.layer.cornerRadius = containerview.frame.height/2
        containerview.layer.shadowColor = UIColor(white: 0.4, alpha: 0.4).cgColor
        containerview.layer.shadowRadius = 8
        containerview.layer.shadowOpacity = 0.5
        containerview.layer.shadowOffset = CGSize(width: 0, height: 4)
        let stackView = UIStackView(arrangedSubviews: arrangedSubView)
        stackView.frame = containerview.frame
        stackView.distribution = .fillEqually
        stackView.spacing = padding
        stackView.layoutMargins =  UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        
        containerview.addSubview(stackView)
        return containerview
    }()
    
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
        
        let postbyGandhi = Post()
        postbyGandhi.name = "Mahatama Gandhi"
        postbyGandhi.statusText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi porta sodales neque, quis porta elit faucibus quis. Morbi vitae luctus nibh, id volutpat mauris. Integer sagittis sagittis nisi vitae suscipit. Phasellus nisl mauris, gravida ac neque a, venenatis pulvinar eros. Sed tempus tellus quam, ut convallis orci lobortis sit amet. Donec enim risus, dignissim ac velit non, varius iaculis turpis. Nam et elementum leo. Aliquam vehicula mi quis justo dictum euismod. Praesent sit amet porttitor nisl, sit amet semper neque. Donec sit amet ipsum eget mi aliquet iaculis eget et ligula. Etiam a orci non libero vestibulum fermentum nec quis mauris."
        postbyGandhi.profileImageName = "gandhi_profile"
        postbyGandhi.location = "December 18 ・ Mumbai ・"
        postbyGandhi.statusImageName = "https://i.pinimg.com/564x/36/cb/3e/36cb3e8edbc43330e2eb50652f4cd170.jpg"
        postbyGandhi.numLikes = 340
        postbyGandhi.numComment = 1900
        
        
        posts.append(postbyMark)
        posts.append(postbySteve)
        posts.append(postbyGandhi)

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
        cell.likeButton.addTarget(self, action: #selector(setupLongPressGestureRecognizer(sender:)), for: .touchUpInside)
        cell.commentButton.addTarget(self, action: #selector(openComments(sender:)), for: .touchUpInside)
        cell.shareButton.addTarget(self, action: #selector(openShare(sender:)), for: .touchUpInside)
    
        return cell
    }
    
    @objc func setupLongPressGestureRecognizer(sender: UIButton){
        sender.tintColor = .blue
        view.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress)))
    }
    
    fileprivate func handleGestureBegan(gesture: UILongPressGestureRecognizer) {
        view.addSubview(iconsContainerView)
        
        let pressedLocation = gesture.location(in: self.view)
        print(pressedLocation)
        
        // transformation of the red box
        let centeredX = (view.frame.width - iconsContainerView.frame.width) / 2
        
        
        iconsContainerView.alpha = 0
        self.iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.iconsContainerView.alpha = 1
            self.iconsContainerView.transform = CGAffineTransform(translationX: centeredX, y: pressedLocation.y - self.iconsContainerView.frame.height)
        })
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer){
        if gesture.state == .began{
            handleGestureBegan(gesture: gesture)
            
        }else if gesture.state == .ended{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                //Getting the first subview in iconsContainerView i.e stack view
                let stackView = self.iconsContainerView.subviews.first
                //looping through all elements in stack view
                stackView?.subviews.forEach({(imageview) in
                    //identity is basically propert which bring the view back to orignal positon
                    imageview.transform = .identity
                })
                self.iconsContainerView.transform = self.iconsContainerView.transform.translatedBy(x: 0, y: self.iconsContainerView.frame.height)
                self.iconsContainerView.alpha = 0
            },completion: { (_) in
                self.iconsContainerView.removeFromSuperview()
            })
        }else if gesture.state == .changed{
            handleGestureChanged(gesture: gesture)
        }
    }
    
    fileprivate func handleGestureChanged(gesture: UILongPressGestureRecognizer){
        //we cant use gesture.location(in: view) cz it return location relative to
        //complete view but wee need only relative to contianer view
        let pressedLocation = gesture.location(in: self.iconsContainerView)
        let fixedYLocation = CGPoint(x: pressedLocation.x, y: self.iconsContainerView.frame.height/2)
        print(pressedLocation)
        let hitview = iconsContainerView.hitTest(fixedYLocation, with: nil)
        if hitview is UIImageView{
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                //Getting the first subview in iconsContainerView i.e stack view
                let stackView = self.iconsContainerView.subviews.first
                //looping through all elements in stack view
                stackView?.subviews.forEach({(imageview) in
                    //identity is basically propert which bring the view back to orignal positon
                    imageview.transform = .identity
                })
                hitview?.transform = CGAffineTransform(translationX: 0, y: -50)
                
            })
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }

    @objc func openComments(sender: UIButton){
        self.navigationController?.pushViewController(ZoomImageViewController(), animated: true)
    }
    @objc func openShare(sender: UIButton){
        self.navigationController?.pushViewController(AutoGrowingTableViewController(), animated: true)
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
