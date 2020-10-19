//
//  ChannelVC.swift
//  Smack
//
//  Created by Luke Bezek on 10/18/20.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60 //reveals all but 60 pixels
        
    }
}
