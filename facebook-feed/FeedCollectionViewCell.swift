
//
//  FeedCollectionViewCell.swift
//  facebook-feed
//
//  Created by Admin on 8/28/18.
//  Copyright © 2018 demo. All rights reserved.
//

import UIKit

var cache = NSCache<AnyObject, AnyObject>()
class FeedCollectionViewCell: UICollectionViewCell, UITextViewDelegate {
   

    func textViewDidChange(_ textView: UITextView) {
        debugPrint("Entered Text",textView.text!)
        UIView.setAnimationsEnabled(false)
        textView.sizeToFit()
        if let collectionVc = parentViewController as? FeedController {
            collectionVc.collectionView?.reloadData()
            collectionVc.collectionView?.performBatchUpdates(nil, completion: {
                (result) in
                self.setNeedsLayout()
                self.layoutIfNeeded()
                // ready
            })
        }
        UIView.setAnimationsEnabled(true)
    }
    
    var post: Post?{
        didSet{
            if let name = post?.name{
                let attributesString = NSMutableAttributedString(string: name, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
                if let location = post?.location{
                    attributesString.append(NSAttributedString(string: "\n" + location, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.rgb(red: 155/255, green: 161/255, blue: 171/255)]))
                    
                }

                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                
                attributesString.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributesString.string.characters.count))
                
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "globe_icon")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                attributesString.append(NSAttributedString(attachment: attachment))
                nameLabel.attributedText = attributesString
            }
            if let statusText = post?.statusText{
                statusTextView.delegate = self
                statusTextView.text = statusText
            }
            if let profileImageName = post?.profileImageName{
                profileImageView.image  = UIImage(named: profileImageName)
            }
            if let statusImageUrl = post?.statusImageName{
                if let cacheImage = cache.object(forKey: statusImageUrl as AnyObject){
                    statusImageView.image = cacheImage as! UIImage
                }
                else{
                    URLSession.shared.dataTask(with: URL(string: statusImageUrl)!, completionHandler: {(data,response,error) -> Void in
                        if error != nil{
                            print(error!)
                        }
                        let image = UIImage(data: data!)
                        cache.setObject(statusImageUrl as AnyObject, forKey: image!)
                        DispatchQueue.main.async {
                            self.statusImageView.image = image
                            
                        }
                    }).resume()
                }
                //statusImageView.image  = UIImage(named: statusImageName)
            }
            if let numLikes = post?.numLikes{
                likeButton.setTitle("\(numLikes) Likes", for: .normal)
            }
            if let numComment = post?.numComment{
                commentButton.setTitle("\(numComment) Comments", for: .normal)
            }
        }
    }
    
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = UIColor.lightGray
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let statusTextView: UITextView = {
        let textview = UITextView()
        textview.text = "Hi We Love iOS"
        textview.font = UIFont.systemFont(ofSize: 12)
        return textview
    }()
    
    let statusImageView: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode  = .scaleAspectFill
        imageview.layer.masksToBounds = true
        return imageview
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "400 likes    4000 Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 155 , green: 161, blue: 171)
        return label
    }()
    
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 226, green: 227, blue: 228)
        return view
    }()
    
    
    let likeButton: UIButton = buttonForTitle(title: "Like", image: "like")
    let shareButton: UIButton = buttonForTitle(title: "Share", image: "share")
    let commentButton: UIButton = buttonForTitle(title: "Comment", image: "comment")

    static func buttonForTitle(title: String, image: String) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 143, green: 150, blue: 163), for: .normal)
        button.setImage(UIImage(named: image), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubview(likesLabel)
        addSubview(dividerView)
        addSubview(likeButton)

        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(commentButton)
        addSubview(shareButton)
        
        addVisualConstraints(format: "H:|-8-[v0(44)]-8-[v1]|", view: profileImageView,nameLabel)
        addVisualConstraints(format: "H:|-8-[v0]-8-|", view: statusTextView)
        addVisualConstraints(format: "H:|[v0]|", view: statusImageView)
        addVisualConstraints(format: "H:|-12-[v0]-12-|", view: likesLabel)
        addVisualConstraints(format: "H:|-12-[v0]-12-|", view: dividerView)
//        [v0(v2)] This expression says set the height of v0 equal to what v2 already have .
//        This technique is being used to put two or more button horizontally align with equal width
        addVisualConstraints(format: "H:|[v0(v2)][v1(v2)][v2]|", view: likeButton,commentButton,shareButton)

//                Here in visual contrain if you dont mention any constant in constraint it will alow it to consume complete space as eg "V:|[v0]|"
//        addVisualConstraints(format: "V:|[v0]|", view: nameLabel)
        
        //Add -8 (constant contraint to restrain it to -8 from top space)
        addVisualConstraints(format: "V:|-8-[v0]", view: nameLabel)
        addVisualConstraints(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-4-[v3(24)]-8-[v4(0.5)][v5(44)]|", view: profileImageView,statusTextView,statusImageView,likesLabel,dividerView,likeButton)
        addVisualConstraints(format: "V:[v0(44)]|", view: commentButton)
        addVisualConstraints(format: "V:[v0(44)]|", view: shareButton)
    }
}

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
}

extension UIView{
    func addVisualConstraints(format: String, view: UIView...){
        var viewDict = [String: UIView]()
        
        for (index,view) in view.enumerated(){
            let key = "v\(index)"
            viewDict[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil , views: viewDict))
    }
}
