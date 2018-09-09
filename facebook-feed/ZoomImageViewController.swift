
//
//  ZoomImageViewController.swift
//  facebook-feed
//
//  Created by Admin on 9/2/18.
//  Copyright © 2018 demo. All rights reserved.
//

import UIKit

class ZoomImageViewController: UIViewController {
    let zoomView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.backgroundColor = .blue
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ZoomImageView"
        view.backgroundColor = .white
        view.addSubview(zoomView)
        zoomView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateImageview)))
        // Do any additional setup after loading the view.
    }

    @objc func animateImageview(){
        
    let newHeight = self.zoomView.frame.width * self.view.frame.height / self.view.frame.width
//        let newHeight = (self.zoomView.frame.width  / self.view.frame.width) * self.view.frame.height
    let y = self.view.frame.height / 2 - self.zoomView.frame.height
    UIView.animate(withDuration: 02, animations: {
            self.zoomView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: newHeight)
//            self.zoomView.backgroundColor = .yellow
            self.zoomView.alpha = 0.6
    })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
