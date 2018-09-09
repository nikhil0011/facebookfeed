
//
//  AutoGrowingTableViewController.swift
//  facebook-feed
//
//  Created by Admin on 8/30/18.
//  Copyright © 2018 demo. All rights reserved.
//

import UIKit

class AutoGrowingTableViewController: UITableViewController{
    let cellid = "cell"
    var isKeyboardAppear = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(AutogrowingTableViewCell.self, forCellReuseIdentifier: cellid)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }

    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let adjustmentHeight = CGFloat(250.0 + 20.0)
        self.tableView.contentInset.bottom += adjustmentHeight
        self.tableView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    

    @objc func keyboardWillHide(notification: NSNotification) {
        let adjustmentHeight = CGFloat(250.0 + 20.0) *  -1
        self.tableView.contentInset.bottom += adjustmentHeight
        self.tableView.scrollIndicatorInsets.bottom += adjustmentHeight
    }

    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AutogrowingTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! AutogrowingTableViewCell
        cell.statusTextView.delegate = self
//        textViewDidChange(cell.statusTextView)
        return cell
    }



}

extension AutoGrowingTableViewController: UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
//        print(textView.text)
//        // MARK: - Size To Fit Text View
//        // return 'best' size to fit given size. does not actually resize view. Default is return existing view size
//        let size = CGSize(width: self.view.frame.width, height: .infinity)
//        let estimatedSize = textView.sizeThatFits(size)
//
//        //MARK:- Looping through constriant to get height constriant.
//        textView.constraints.forEach{(constraint) in
//            if constraint.firstAttribute == .height{}
//            constraint.constant = estimatedSize.height
//            self.tableView.beginUpdates()
//            self.tableView.endUpdates()
//
//        }
//
        let startHeight = textView.frame.size.height
        let calcHeight = textView.sizeThatFits(textView.frame.size).height  //iOS 8+ only

        if startHeight != calcHeight {

            UIView.setAnimationsEnabled(false) // Disable animations
            textView.constraints.forEach{(constraint) in
                if constraint.firstAttribute == .height{}
                constraint.constant = calcHeight
                self.tableView.beginUpdates()
                self.tableView.endUpdates()
                
            }


            // Might need to insert additional stuff here if scrolls
            // table in an unexpected way.  This scrolls to the bottom
            // of the table. (Though you might need something more
            // complicated if editing in the middle.)

            let scrollTo = self.tableView.contentSize.height - self.tableView.frame.size.height
            self.tableView.setContentOffset(CGPoint(x: 0, y: scrollTo), animated: false)
            UIView.setAnimationsEnabled(true)  // Re-enable animations.
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
