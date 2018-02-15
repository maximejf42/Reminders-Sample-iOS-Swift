//
//  ReminderTableViewCell.swift
//  RemindersSwiftApp
//
//  Created by Chanikya on 7/27/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var markDoneOutlet: UIButton!
    
    weak var delegate:RemindersViewController?
    var reminder_id = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.markDoneOutlet.layer.cornerRadius = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func markDone(_ sender: Any) {
        self.delegate?.markDone(reminder_id: self.reminder_id)
    }

}
