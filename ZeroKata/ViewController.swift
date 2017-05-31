//
//  ViewController.swift
//  Zero Kata
//
//  Created by Nishant, Alex, E on 01/06/2017.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // player list
    enum Player: Int {
        case kata = 1
        case zero = 2
    }
    
    var player = Player.kata                       // current player
    var cellState = [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ]   // state of game cells
    var gameOver = false                            // game over flag
    
    // winning combinations
    let winningCombination = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]]
    
    @IBOutlet weak var label: UILabel!              // winning player label
    @IBOutlet weak var playAgainButton: UIButton!   // play again button
    
    // game field tap action handler
    @IBAction func action(_ sender: AnyObject)
    {
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
                (sender as AnyObject).setImage(UIImage(named: "Kata.png"), for: UIControlState())
                player = .zero
            }
            
            else if (player == .zero) {
                (sender as AnyObject).setImage(UIImage(named: "Zero.png"), for: UIControlState())
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
                        label.text = "KATA HAS WON!"
                    }
                    else if(cellState[c[0]] == Player.zero.rawValue) {
                        label.text = "ZERO HAS WON!"
                    }
                    
                    playAgainButton.isHidden = false
                    label.isHidden = false
                    
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
            
            label.text = "IT'S A DRAW!"
            
            playAgainButton.isHidden = false
            label.isHidden = false
        }
    }
    
    // play again tap action handler
    @IBAction func playAgain(_ sender: AnyObject)
    {
        // reset game cells state
        cellState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        // allow access to the game field
        gameOver = false
        
        // select default player
        player = Player.kata
        
        // hide play again button and and winning player button
        playAgainButton.isHidden = true
        label.isHidden = true
        
        // reset button pictures
        for i in 1...9 {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControlState())
        }
    }
}

