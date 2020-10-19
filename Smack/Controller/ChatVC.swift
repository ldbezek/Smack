//
//  ChatVC.swift
//  Smack
//
//  Created by Luke Bezek on 10/18/20.
//

import UIKit

class ChatVC: UIViewController {

    
    //Outlets
        @IBOutlet weak var menuBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_: )), for: .touchUpInside) //Adds the channel vc over the chat vc using swreveal
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer()) //adds gesture to open/close
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer()) //adds tap on edge to close
    }
    
}
    
