//
//  RemindersViewController.swift
//  RemindersSwiftApp
//
//  Created by Chanikya on 7/25/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import UIKit
import Tealeaf

class RemindersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var selectedIndex:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        self.navigationItem.title = "Reminders"
        
        let remind = [
            "id": UUID().uuidString,
            "title": "Add more reminders",
            "notes": "Add more reminders and checkout the replay",
            "priority": 2,
            "dueDate": Date()
            ] as [String : Any]
        RemindersDataSource.sharedInstance.addReminder(reminder: remind)
        
        self.tableView.backgroundColor = UIColor.clear
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.selectedIndex = nil
        self.tableView.reloadData()
    }
    
    func markDone(reminder_id:String) {
        RemindersDataSource.sharedInstance.deleteReminder(reminder_id: reminder_id)
        self.tableView.reloadData()
        self.selectedIndex = nil
        TLFCustomEvent.sharedInstance().logScreenLayout(with: self)  // Manually capturing the screen for newly loaded table contents
    }
    
    @IBAction func addReminder(_ sender: Any) {
        self.performSegue(withIdentifier: "addReminderSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! AddReminderViewController
        
        if (self.selectedIndex != nil) {
            let reminder = (RemindersDataSource.sharedInstance.itemsList[selectedIndex] as? [String:Any])
            destVC.reminder = reminder
            self.selectedIndex = nil
        }
    }
}

extension RemindersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RemindersDataSource.sharedInstance.itemsList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ReminderTableViewCell
        cell.titleLabel.text = (RemindersDataSource.sharedInstance.itemsList[indexPath.row] as? [String:Any])?["title"] as? String
        //cell.dueDateLabel.text = (RemindersDataSource.sharedInstance.itemsList[indexPath.row] as? [String:Any])?["dueDate"] as? String
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "MM/dd/yy, HH:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"
        let remindDate = formatter.string(from: (RemindersDataSource.sharedInstance.itemsList[indexPath.row] as? [String:Any])?["dueDate"] as! Date)
        
        cell.dueDateLabel.text = "\(remindDate)"
        
        cell.reminder_id = ((RemindersDataSource.sharedInstance.itemsList[indexPath.row] as? [String:Any])?["id"] as? String)!
        cell.delegate = self
        return cell
    }
}

extension RemindersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.performSegue(withIdentifier: "addReminderSegue", sender: self)
    }
}
