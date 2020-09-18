//
//  ViewController.swift
//  meetthemembers
//
//  Created by Janvi Shah on 9/14/20.
//  Copyright © 2020 Janvi Shah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func beginGame(_ sender: Any) {
        self.performSegue(withIdentifier: "GameSegue", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

