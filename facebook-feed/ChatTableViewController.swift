//
//  ChatTableViewController.swift
//  facebook-feed
//
//  Created by Admin on 9/10/18.
//  Copyright © 2018 demo. All rights reserved.
//

import UIKit
struct ChatMessages {
    let message: String
    let incomingMessage: Bool
    let date: Date
}

extension Date{
    static func dateFromCustomString(dateString: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: dateString) ?? Date()
    }
}

class ChatTableViewController: UITableViewController {
    fileprivate let cellIdentifier = "cellIdentifier"
    
    let textMessages = [
        [
            ChatMessages(message: "It's Auto grIt's Auto growing cells It's Auto growing cells", incomingMessage: true,date: Date.dateFromCustomString(dateString: "10/31/2018")),
        ChatMessages(message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dumm", incomingMessage: true,date: Date.dateFromCustomString(dateString: "10/31/2018")),
        ChatMessages(message: "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.", incomingMessage: false,date: Date.dateFromCustomString(dateString: "10/31/2018"))
        ],
        [
            ChatMessages(message: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English", incomingMessage: true,date: Date.dateFromCustomString(dateString: "11/31/2018")),
        ChatMessages(message: "There are many variations of passages", incomingMessage: false,date: Date.dateFromCustomString(dateString: "11/31/2018")),
        ChatMessages(message: "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 \n translation by H. Rackham.", incomingMessage: false,date: Date.dateFromCustomString(dateString: "11/31/2018"))
        ]

    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Comments"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 246, green: 246, blue: 246)
        self.navigationController?.navigationBar.titleTextAttributes   = [NSAttributedStringKey.foregroundColor: UIColor.black]
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        tableView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return textMessages.count
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if let firstObj = textMessages[section].first{
//            let date = firstObj.date
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MM/dd/yyyy"
//            let dateString = dateFormatter.string(from: date)
//            return "\(dateString)"
//
//        }
//        return "section: \(section)"
//    }
    
    
    class DataHeaderLabel: UILabel{
        override init(frame: CGRect) {
            super.init(frame: frame)
            textColor = .white
            textAlignment = .center
            backgroundColor = UIColor.rgb(red: 37, green: 211, blue: 102)
            font = UIFont.boldSystemFont(ofSize: 14)
            translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize{
            let orgContentSize = super.intrinsicContentSize
            let height = orgContentSize.height + 12
            self.layer.cornerRadius = height / 2
            self.layer.masksToBounds = true
            return CGSize(width: orgContentSize.width + 20, height: height)
        }
    }
    
    /*
     *When you want to use custom header use this method as it returns view rather a text string
     *
     */
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = DataHeaderLabel()
        
        if let firstObj = textMessages[section].first{
            let date = firstObj.date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateString = dateFormatter.string(from: date)
            label.text = dateString
        }
        
        let containerView = UIView()
        containerView.addSubview(label)
//        containerView.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        


        return containerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return textMessages[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ChatTableViewCell
        cell.chatMessage = textMessages[indexPath.section][indexPath.row]
        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
