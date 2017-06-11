//
//  LaunchViewController.swift
//  ZeroKata
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 Alexandr Li. All rights reserved.
//

import UIKit

var player1Name = ""
var player2Name = ""

class LaunchViewController: UIViewController {

    @IBOutlet weak var player1Text: UITextField!
    @IBOutlet weak var player2Text: UITextField!
    
    @IBAction func startAction(_ sender: UIButton) {
        if (player1Text.text != "") && (player2Text.text != "") {
            player1Name = player1Text.text!
            player2Name = player2Text.text!
            performSegue(withIdentifier: "launchSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
