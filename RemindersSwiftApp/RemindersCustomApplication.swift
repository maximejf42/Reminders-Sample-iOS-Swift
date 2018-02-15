//
//  RemindersCustomApplication.swift
//  RemindersSwiftApp
//
//  Created by Chanikya on 8/1/17.
//  Copyright © 2017 IBM. All rights reserved.
//

import UIKit
import Tealeaf

class RemindersCustomApplication: UIApplication {
    override func sendEvent(_ event: UIEvent){
        let tlfApplicationHelperObj = TLFApplicationHelper()
        tlfApplicationHelperObj.send(event)
        super.sendEvent(event)
        print("Event send: \(event)");
    }
    override func sendAction(_ action: Selector, to target: Any!, from sender: Any!, for event: UIEvent!) -> Bool{
        let tlfApplicationHelperObj = TLFApplicationHelper.sharedInstance()
        tlfApplicationHelperObj?.sendAction(action, to: target, from: sender, for: event)
        let bResult = super.sendAction(action, to: target, from: sender, for: event)
        print("Action send: \(action)");
        return bResult;
    }
}
