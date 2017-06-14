//
//  ViewController.swift
//  ZeroKata
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 Evgenii Onopchenko, Alexandr Li, Nishant. All rights reserved.
//

import UIKit

var player1Name = ""
var player2Name = ""
var bestPlayerName = "Your name can be here"
var highScore = 0

class ViewController: UIViewController {

    @IBOutlet weak var textPlayer1: UITextField!
    @IBOutlet weak var textPlayer2: UITextField!
    @IBOutlet weak var bestPlayerlbl: UILabel!
    @IBOutlet weak var highScorelbl: UILabel!

    
    @IBAction func actionStart(_ sender: Any) {
        player1Name = textPlayer1.text!
        player2Name = textPlayer2.text!
        performSegue(withIdentifier: "segueStart", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let highScoreDefault = Foundation.UserDefaults.standard
        if (highScoreDefault.value(forKey: "highScore") != nil){
        highScore = highScoreDefault.value(forKey: "highScore") as! Int
        }
        if (highScoreDefault.value(forKey: "bestPlayer") != nil){
        bestPlayerName = highScoreDefault.value(forKey: "bestPlayer") as! String
        }
        highScorelbl.text = String(highScore)
        bestPlayerlbl.text = bestPlayerName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

