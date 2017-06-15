//
//  ViewControllerGame.swift
//  ZeroKata
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 Evgenii Onopchenko, Alexandr Li, Nishant. All rights reserved.
//

import UIKit
import Social
import MessageUI

var winner = 0
var player1Score = 0
var player2Score = 0

class ViewControllerGame: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet weak var labelPlayer1: UILabel!
    @IBOutlet weak var labelPlayer2: UILabel!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var buttonReplay: UIButton!
    @IBOutlet weak var buttonShareTwitter: UIButton!
    @IBOutlet weak var buttonShareSMS: UIButton!
    @IBOutlet weak var imageResult: UIImageView!
    @IBOutlet weak var labelPlayer1Score: UILabel!
    @IBOutlet weak var labelPlayer2Score: UILabel!
    
    // player list
    enum Player: Int {
        case kata = 1
        case zero = 2
    }
    
    var player = Player.kata                        // current player
    var cellState = [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ]   // state of game cells
    var gameOver = false                            // game over flag
    let highScoreDefault = Foundation.UserDefaults.standard
    
    // winning combinations
    let winningCombination = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]]
    
    @IBAction func actionTap(_ sender: Any) {
        // check, whether the game is over
        if gameOver == true {
            return
        }
        
        // check whether the cell is free at the moment
        if cellState[(sender as! UIButton).tag - 1] == 0 {
            
            // if cell is free, mark it as occupied
            cellState[(sender as! UIButton).tag - 1] = player.rawValue
            
            // choose a picture to put on the game field and animate it
            if (player == .kata) {
                (sender as AnyObject).setImage(UIImage(named: "button-kata.png"), for: UIControlState())
                player = .zero
            }
                
            else if (player == .zero) {
                (sender as AnyObject).setImage(UIImage(named: "button-zero.png"), for: UIControlState())
                player = .kata
            }
            
            UIView.animate(
                withDuration: 0.5, animations: {
                    (sender as! UIButton).transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            },
                completion: {
                    _ in UIView.animate(withDuration: 0.5) {
                        (sender as! UIButton).transform = CGAffineTransform.identity
                    }
            }
            )
            
            // check, whether there is a condition of game completion
            for c in winningCombination {
                
                // check for 3 same symbols in a row
                if((cellState[c[0]] != 0) &&
                    (cellState[c[0]] == cellState[c[1]]) &&
                    (cellState[c[1]] == cellState[c[2]])) {
                    
                    // output a winning message
                    if(cellState[c[0]] == Player.kata.rawValue) {
                        imageResult.image = UIImage(named: "button-kata.png")
                        player1Score += 1
                        winner = 1
                        labelPlayer1Score.text = String(player1Score)
                        if (player1Score > highScore) {
                            highScore = player1Score
                            highScoreDefault.set(highScore, forKey: "highScore")
                            highScoreDefault.set(player1Name, forKey: "bestPlayer")
                            highScoreDefault.synchronize()
                        }
                    }
                    else if(cellState[c[0]] == Player.zero.rawValue) {
                        imageResult.image = UIImage(named: "button-zero.png")
                        player2Score += 1
                        winner = 2
                        labelPlayer2Score.text = String(player2Score)
                        if (player2Score > highScore) {
                            highScore = player2Score
                            highScoreDefault.set(highScore, forKey: "highScore")
                            highScoreDefault.set(player2Name, forKey: "bestPlayer")
                            highScoreDefault.synchronize()
                        }
                    }
                    
                    gameOver = true
                    
                    break
                }
            }
            
            if gameOver == false {
                // check for draw (all cells are occupied)
                gameOver = true
                for c in cellState {
                    if c == 0 {
                        gameOver = false
                        return
                    }
                }
                labelResult.isHidden = false
                winner = 0
            }
            
            if gameOver == true {
                buttonReplay.isHidden = false
                buttonShareTwitter.isHidden = false
                buttonShareSMS.isHidden = false
            
                performSegue(withIdentifier: "segueScoretable", sender: self)
            }
        }
    }
    
    @IBAction func actionReplay(_ sender: Any) {
        // reset game cells state
        cellState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        // allow access to the game field
        gameOver = false
        
        // select default player
        player = Player.kata
        
        // hide play again button and and winning player button
        buttonReplay.isHidden = true
        buttonShareTwitter.isHidden = true
        buttonShareSMS.isHidden = true
        labelResult.isHidden = true
        imageResult.image = UIImage(named: "")
        
        // reset button pictures
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControlState())
        }
    }
    
    @IBAction func ShareTwitter(_ sender: Any) {
        
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            
            let twitter:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitter.setInitialText("Hey! We've just played ZeroKata. It was awesome!👍👍👍 \(player1Name) scored \(player1Score) and \(player2Name) scored \(player2Score).")
            self.present(twitter, animated: true, completion: nil)
        }
        else{
            
            let alert = UIAlertController(title: "Accounts", message: "Please log into your twitter account within the settings", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func shareSMS(_ sender: Any) {
        
        if MFMessageComposeViewController.canSendText(){
            
            let message:MFMessageComposeViewController = MFMessageComposeViewController()
            
            message.messageComposeDelegate = self
            
            message.recipients = nil
            message.body = "Hey! We've just played ZeroKata. It was awesome!👍👍👍 \(player1Name) scored \(player1Score) and \(player2Name) scored \(player2Score)."
            
            self.present(message, animated: true, completion: nil)
        }
        else{
            
            let alert = UIAlertController(title: "Warning", message: "This device can not send SMS messages", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        labelPlayer1.text = player1Name
        labelPlayer2.text = player2Name
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
