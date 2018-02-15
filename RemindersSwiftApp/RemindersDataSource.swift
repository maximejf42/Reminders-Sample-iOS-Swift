//
//  RemindersDataSource.swift
//  RemindersSwiftApp
//
//  Created by Chanikya on 7/25/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import UIKit

class RemindersDataSource: NSObject {
    static let sharedInstance = RemindersDataSource()
    var itemsList = [Any]()
    
    func addReminder(reminder:[String:Any]) {
        let id = reminder["id"] as! String
        var itemIndex = -1;
        if self.itemsList.count > 0 {
            for index in 0...itemsList.count-1 {
                if ((itemsList[index] as? [String:Any])?["id"] as! String) == id {
                    itemIndex = index
                }
            }
        }
        
        if itemIndex == -1 {
            itemsList.append(reminder)
        }
        else {
            itemsList[itemIndex] = reminder
        }
    }
    
    func deleteReminder(reminder_id:String) {
        var itemIndex = -1;
        for index in 0...itemsList.count-1 {
            if ((itemsList[index] as? [String:Any])?["id"] as! String) == reminder_id {
                itemIndex = index
            }
        }
        
        if itemIndex == -1 {
            print("Item not found")
        }
        else {
            itemsList.remove(at: itemIndex)
        }
    }
}
