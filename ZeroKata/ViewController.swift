//
//  ViewController.swift
//  ZeroKata
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 Evgenii Onopchenko. All rights reserved.
//

import UIKit

var player1Name = ""
var player2Name = ""

class ViewController: UIViewController {

    @IBOutlet weak var textPlayer1: UITextField!
    @IBOutlet weak var textPlayer2: UITextField!
    
    @IBAction func actionStart(_ sender: Any) {
        player1Name = textPlayer1.text!
        player2Name = textPlayer2.text!
        performSegue(withIdentifier: "segueStart", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

