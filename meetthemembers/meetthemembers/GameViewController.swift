//
//  GameViewController.swift
//  meetthemembers
//
//  Created by Janvi Shah on 9/14/20.
//  Copyright © 2020 Janvi Shah. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var optionOne: UIButton!
    
    @IBOutlet weak var optionTwo: UIButton!
    
    @IBOutlet weak var optionThree: UIButton!
    
    @IBOutlet weak var optionFour: UIButton!
    
    @IBOutlet weak var personImage: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var pauseresumeLabel: UIButton!
    
    
    static let names = ["Aady Pillai", "Aarushi Agrawal", "Aayush Tyagi", "Abhinav Kejriwal", "Afees Tiamiyu", "Ajay Merchia", "Anand Chandra", "Andres Medrano", "Andrew Santoso", "Anika Bagga", "Anik Gupta", "Anita Shen", "Anjali Thakrar", "Anmol Parande", "Ashwin Aggarwal", "Ashwin Kumar", "Athena Leong", "Austin Davis", "Ayush Kumar", "Brandon David", "Candace Chiang", "Candice Ye","Charles Yang", "Colin Zhou", "Daniel Andrews", "Divya Tadimeti", "DoHyun Cheon", "Eric Kong", "Ethan Wong", "Francis Chalissery", "Geo Morales", "Ian Shen", "Imran Khaliq", "Izzie Lau", "Jacqueline Zhang", "James Jung", "Japjot Singh", "Joey Hejna", "Juliet Kim", "Kanyes Thaker", "Karen Alarcon", "Katniss Lee", "Kayli Jiang", "Kiana Go", "Maggie Yi", "Matthew Locayo", "Max Emerling", "Max Miranda", "Melanie Cooray", "Michael Lin", "Michelle Mao", "Mohit Katyal", "Mudabbir Khan", "Natasha Wong", "Neha Nagabothu", "Nicholas Wang", "Nikhar Arora", "Noah Pepper", "Olivia Li", "Patrick Yin", "Paul Shao", "Radhika Dhomse", "Rini Vasan", "Sai Yandapalli", "Salman Husain", "Samantha Lee", "Shaina Chen", "Sharie Wang", "Shaurya Sanghvi", "Shiv Kushwah", "Shomil Jain", "Shubha Jagannatha", "Shubham Gupta", "Simran Regmi", "Sinjon Santos", "Srujay Korlakunta", "Stephen Jayakar", "Tyler Reinecke", "Vaibhav Gattani", "Varun Jhunjhunwalla", "Victor Sun", "Vidya Ravikumar", "Vineeth Yeevani", "Will Oakley", "Will Vavrik", "Xin Yi Chen", "Yatin Agarwal"]
    
    static func getImageFor(name: String) -> UIImage {
        let noWhitespace = name.components(separatedBy: .whitespaces).joined().lowercased()
        return UIImage(named: noWhitespace)!
    }
    
    var correctOption = ""
    var results = ["", "", ""]
    var timer: Timer!
    var timeUntilFire = TimeInterval()
    var paused = false
    var longestStreak = 0
    var correctAnswers = 0

    
    
    //Loading and Updating Page
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        updatePage()
        
    }

    func updatePage(){
        let option1 = GameViewController.names.randomElement()
        var options = [option1]
        
        var option2 = GameViewController.names.randomElement()
        while options.contains(option2){
            option2 = GameViewController.names.randomElement()
        }
        options.append(option2)
        
        var option3 = GameViewController.names.randomElement()
        while options.contains(option3){
            option3 = GameViewController.names.randomElement()
        }
        options.append(option3)
        
        var option4 = GameViewController.names.randomElement()
        while options.contains(option4){
            option4 = GameViewController.names.randomElement()
        }
        options.append(option4)

        
        optionOne.backgroundColor = .init(red: 0, green: 0, blue: 255, alpha: 1.0)
        optionOne.layer.cornerRadius = 10
        optionOne.contentEdgeInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)

        optionTwo.backgroundColor = .init(red: 0, green: 0, blue: 255, alpha: 1.0)
        optionTwo.layer.cornerRadius = 10
        
        optionThree.backgroundColor = .init(red: 0, green: 0, blue: 255, alpha: 1.0)
        optionThree.layer.cornerRadius = 10
        
        optionFour.backgroundColor = .init(red: 0, green: 0, blue: 255, alpha: 1.0)
        optionFour.layer.cornerRadius = 10
        
        optionOne.setTitle(option1, for: .normal)
        
        optionTwo.setTitle(option2, for: .normal)
        optionThree.setTitle(option3, for: .normal)
        optionFour.setTitle(option4, for: .normal)
        correctOption = options.randomElement()!!
        personImage.image = GameViewController.getImageFor(name: correctOption)
        resetTimer()
    }
    
    
    //Incorrect/Wrong Answer Flash
    
    func flashCorrect(){
        UIView.animate(withDuration: 1.0, animations: {
            self.view.backgroundColor = UIColor.green

        })
        UIView.animate(withDuration: 1.0, animations: {
            self.view.backgroundColor = UIColor.black

        })
    }
    
    func flashWrong(){
        UIView.animate(withDuration: 1.0, animations: {
            self.view.backgroundColor = UIColor.red

        })
        UIView.animate(withDuration: 1.0, animations: {
            self.view.backgroundColor = UIColor.black

        })
    }
    
    
    //Timer Information
    
    func startTimer(){
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { timer in
            self.flashWrong()
            self.updatePage()
        })
    }

    func resetTimer(){
        timer.invalidate()
        startTimer()
    }
    
    func pauseTimer(){
        //Get the difference in seconds between now and the future fire date
        timeUntilFire = timer.fireDate.timeIntervalSinceNow
        //Stop the timer
        timer.invalidate()
    }

    func resumeTimer(){
        //Start the timer again with the previously invalidated timers time left with timeUntilFire
        timer = Timer.scheduledTimer(withTimeInterval: timeUntilFire, repeats: false, block: { timer in
            self.flashWrong()
            self.updatePage()
        })
    }
    
    //Button Click Actions

    @IBAction func pauseResume(_ sender: Any) {
        if paused{
            resumeTimer()
            scoreLabel.text = "0"
            pauseresumeLabel.setTitle("Pause", for: .normal)
            paused = false
        }
        else{
            pauseTimer()
            pauseresumeLabel.setTitle("Resume", for: .normal)
            paused = true
        }
    }
    
    @IBAction func optiononeClicked(_ sender: Any) {
        if !paused{
            if optionOne.title(for: .normal) == correctOption {
                results.append("Your selection: " + optionOne.title(for: .normal)! + "--> Correct")
                let new_score = Int(scoreLabel.text!)! + 1
                scoreLabel.text = String(new_score)
                correctAnswers+=1
                flashCorrect()

            }
            else{
                flashWrong()
                results.append("Your selection: " + optionOne.title(for: .normal)! + "--> Incorrect")
                if correctAnswers > longestStreak{
                    longestStreak = correctAnswers
                }
                correctAnswers = 0
            }
            updatePage()
        }
    }
    
    @IBAction func optiontwoClicked(_ sender: Any) {
        if !paused{
            if optionTwo.title(for: .normal) == correctOption {
                results.append("Your selection: " + optionTwo.title(for: .normal)! + "--> Correct")
                let new_score = Int(scoreLabel.text!)! + 1
                scoreLabel.text = String(new_score)
                correctAnswers+=1
                flashCorrect()


            }
            else{
                flashWrong()
                results.append("Your selection: " + optionTwo.title(for: .normal)! + "--> Incorrect")
                if correctAnswers > longestStreak{
                    longestStreak = correctAnswers
                }
                correctAnswers = 0
            }
            updatePage()
        }
    }
    
    @IBAction func optionthreeClicked(_ sender: Any) {
        if !paused{
            if optionThree.title(for: .normal) == correctOption {
                results.append("Your selection: " + optionThree.title(for: .normal)! + "--> Correct")
                let new_score = Int(scoreLabel.text!)! + 1
                scoreLabel.text = String(new_score)
                correctAnswers+=1
                flashCorrect()


            }
            else{
                flashWrong()
                results.append("Your selection: " + optionThree.title(for: .normal)! + "--> Incorrect")
                if correctAnswers > longestStreak{
                    longestStreak = correctAnswers
                }
                correctAnswers = 0
            }
            updatePage()
        }
    }
    
    @IBAction func optionfourClicked(_ sender: Any) {
        if !paused{
            if optionFour.title(for: .normal) == correctOption {
                results.append("Your selection: " + optionFour.title(for: .normal)! + "--> Correct")
                let new_score = Int(scoreLabel.text!)! + 1
                scoreLabel.text = String(new_score)
                correctAnswers+=1
                flashCorrect()
            }
            else{
                flashWrong()
                results.append("Your selection: " + optionFour.title(for: .normal)! + "--> Incorrect")
                if correctAnswers > longestStreak{
                    longestStreak = correctAnswers
                }
                correctAnswers = 0

            }
            
            updatePage()
        }
    }
    
    
    @IBAction func restart(_ sender: Any) {
        self.performSegue(withIdentifier: "restart", sender: self)
    }
    
    @IBAction func viewStatistics(_ sender: Any) {
        self.performSegue(withIdentifier: "toStatisticsSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? StatisticsViewController else {return }
        vc.results = self.results
        vc.longestStreak = max(self.longestStreak, self.correctAnswers)
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
