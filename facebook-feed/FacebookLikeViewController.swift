//
//  FacebookLikeViewController.swift
//  facebook-feed
//
//  Created by Admin on 8/31/18.
//  Copyright © 2018 demo. All rights reserved.
//

import UIKit

class FacebookLikeViewController: UIViewController {
    let bgImage:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "fb_core_data_bg")
        return image
    }()
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

      
        
        
        let padding: CGFloat = 5
        let iconHeight: CGFloat = 30
        
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
        view.addSubview(bgImage)
        bgImage.frame = view.frame
        setupLongPressGestureRecognizer()
        // Do any additional setup after loading the view.
    }
    
    func setupLongPressGestureRecognizer(){
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override var prefersStatusBarHidden: Bool{
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
