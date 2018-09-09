
//
//  DemoViewController.swift
//  facebook-feed
//
//  Created by Admin on 8/30/18.
//  Copyright © 2018 demo. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController {
    var isKeyboardAppear = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.view.backgroundColor = UIColor.white
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            let textview = UITextView()
            textview.frame = CGRect(x: 20, y: 0, width: view.frame.width, height: 200)
            textview.backgroundColor  = .yellow
            textview.isScrollEnabled = false
            textview.text = ";;;;Sdkjhdhvjkldhdfskaljbvdnaklh"
            textview.translatesAutoresizingMaskIntoConstraints  = false
            view.addSubview(textview)
            [
                textview.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor),
                textview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                textview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                textview.heightAnchor.constraint(equalToConstant: 50)
            ]
            .forEach{  $0.isActive = true  }
            
            textview.font = UIFont.preferredFont(forTextStyle: .headline)
            textview.delegate = self
            textViewDidChange(textview)
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)

    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print("show")
//        adjustingHeight(show: true, notification: notification)
        if !isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0{
                    self.view.frame.origin.y -= keyboardSize.height 
                }
            }
            isKeyboardAppear = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        print("hide")
        if isKeyboardAppear {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y != 0{
                    self.view.frame.origin.y += keyboardSize.height
                }
            }
            isKeyboardAppear = false
        }
//        adjustingHeight(show: false, notification: notification)
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

extension DemoViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text)
        // MARK: - Size To Fit Text View
        // return 'best' size to fit given size. does not actually resize view. Default is return existing view size
        let size = CGSize(width: self.view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        //MARK:- Looping through constriant to get height constriant.
        textView.constraints.forEach{(constraint) in
            if constraint.firstAttribute == .height{}
                constraint.constant = estimatedSize.height
        }
    }

    //MARK:- Return to close keyboard by default is not possible with uitextview
    //whenever Return is pressed "\n" is emitted by keyboard
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
