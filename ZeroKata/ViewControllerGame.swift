//
//  ViewControllerGame.swift
//  ZeroKata
//
//  Created by Admin on 11.06.17.
//  Copyright © 2017 Evgenii Onopchenko. All rights reserved.
//

import UIKit

class ViewControllerGame: UIViewController {

    @IBOutlet weak var labelPlayer1: UILabel!
    @IBOutlet weak var labelPlayer2: UILabel!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var buttonReplay: UIButton!
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
    var kataScore = 0                               // 
    var zeroScore = 0                               //
    
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
                        kataScore += 1
                        labelPlayer1Score.text = String(kataScore)
                    }
                    else if(cellState[c[0]] == Player.zero.rawValue) {
                        imageResult.image = UIImage(named: "button-zero.png")
                        zeroScore += 1
                        labelPlayer2Score.text = String(zeroScore)
                    }
                    
                    buttonReplay.isHidden = false
                    
                    gameOver = true
                    
                    return
                }
            }
            
            // check for draw (all cells are occupied)
            gameOver = true
            for c in cellState {
                if c == 0 {
                    gameOver = false
                    return
                }
            }
            
            buttonReplay.isHidden = false
            labelResult.isHidden = false
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
        labelResult.isHidden = true
        imageResult.image = UIImage(named: "")
        
        // reset button pictures
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControlState())
        }
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
