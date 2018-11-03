//
//  AddReminderViewController.swift
//  RemindersSwiftApp
//
//  Created by Chanikya on 7/27/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import UIKit

class AddReminderViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var remindDaySwitch: UISwitch!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    var reminder_id:String!
    var reminder:[String:Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addReminder))
        self.navigationItem.title = "Manage reminder"
        
        self.notesTextView.layer.borderWidth = 1
        self.notesTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.notesTextView.layer.cornerRadius = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let reminder = reminder {
            self.titleTextField.text = reminder["title"] as? String
            self.notesTextView.text = reminder["notes"] as? String
            self.prioritySegmentedControl.selectedSegmentIndex = reminder["priority"] as! Int
            if let dueDate = reminder["reminderDate"] {
                self.remindDaySwitch.setOn(true, animated: false)
                self.datePicker.date = dueDate as! Date
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleSwitch(_ sender: Any) {
        if (sender as! UISwitch).isOn {
            self.datePicker.isHidden = false
        }
        else {
            self.datePicker.isHidden = true
        }
    }
    
    @objc func addReminder() {
        if self.titleTextField.text?.count == 0 ||  self.notesTextView.text?.count == 0 {
            let alertController = UIAlertController(title: "Missing required fields", message: "Please enter text for reminder title and notes", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                print("OK")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let id = (self.reminder != nil) ? ((self.reminder["id"] as? String) ?? UUID().uuidString) :UUID().uuidString
            
            let remind = [
                "id": id,
                "title": self.titleTextField.text!,
                "notes": self.notesTextView.text!,
                "priority": prioritySegmentedControl.selectedSegmentIndex,
                "dueDate": self.datePicker.date
                ] as [String : Any]
            RemindersDataSource.sharedInstance.addReminder(reminder:remind)
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // dismiss keyboard when tapped outside textField/textView
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: Any) {
        
    }
    
    @IBAction func priorityChanged(_ sender: Any) {
    }

}
