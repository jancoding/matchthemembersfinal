//
//  StatisticsViewController.swift
//  meetthemembers
//
//  Created by Janvi Shah on 9/17/20.
//  Copyright © 2020 Janvi Shah. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController {

    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var streakLabel: UILabel!
    var results: [String]!
    var longestStreak: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        results = results.suffix(3)
        resultLabel.text = results[0] + "\n" + results[1] + "\n" + results[2]
        let new_text = String(longestStreak)
        print(new_text)
        streakLabel.text = new_text
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func returnGame(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
