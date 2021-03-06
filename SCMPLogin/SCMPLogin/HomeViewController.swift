//
//  HomeViewController.swift
//  SCMPLogin
//
//  Created by Norman Lim on 3/12/2018.
//  Copyright © 2018 Norman Lim. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var token: String?
    
    @IBOutlet weak var tokenTextField: UILabel!
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let token = token {
            tokenTextField.text = token
        }
    }

}
