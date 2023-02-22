//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Bryan on 21/10/2023.
//  Copyright © 2023 Bryan Abergas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        loadMessages()
    }
    
    func loadMessages() {
        db.collection(Constants.FStore.collectionName).order(by: Constants.FStore.dateField).addSnapshotListener { querySnapshot, error in
            self.messages = []
            if let e = error {
                print(e.localizedDescription)
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for document in snapshotDocuments {
                        let data = document.data()
                        if let sender = data[Constants.FStore.senderField] as? String, let message = data[Constants.FStore.bodyField] as? String {
                            self.messages.append(Message(sender:  sender, body: message))
                         }
                    }
                    DispatchQueue.main.async {
                        let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                        self.tableView.reloadData()
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField: messageSender, Constants.FStore.bodyField: messageBody, Constants.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    print("Successfully saved data")
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.sender == Auth.auth().currentUser?.email {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.label.text = message.body
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.purple)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden = false
            cell.label.text = message.body
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lighBlue)
            cell.label.textColor = UIColor(named: Constants.BrandColors.blue)
            return cell
        }
    }
    
    
}
