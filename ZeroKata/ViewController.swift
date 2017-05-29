//
//  ViewController.swift
//  Zero Kata
//
//  Created by Nishant, Alex, E on 18/05/2017.
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
    
    enum Player: Int {
        case cross = 1
        case nought = 2
    }
    
    var player = Player.cross;
    var cellState = [ 0, 0, 0, 0, 0, 0, 0, 0, 0 ];
    let winningCombination = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        [0, 4, 8], [2, 4, 6]];
    var gameOver = false;
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func action(_ sender: AnyObject)
    {
        if((cellState[(sender as! UIButton).tag] == 0) && (gameOver == false)) {
            
            cellState[(sender as! UIButton).tag] = player.rawValue
            
            if (player == .cross) {
                
                (sender as AnyObject).setImage(UIImage(named: "Cross.png"), for: UIControlState());
                
                player = .nought;
            }
                
            else if (player == .nought) {
                (sender as AnyObject).setImage(UIImage(named: "Nought.png"), for: UIControlState());
                player = .cross;
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
            
            for c in winningCombination {
                if((cellState[c[0]] != 0) &&
                    (cellState[c[0]] == cellState[c[1]]) &&
                    (cellState[c[1]] == cellState[c[2]])) {
                    
                    if(cellState[c[0]] == Player.cross.rawValue) {
                        label.text = "Cross has won!";
                    }
                    else if(cellState[c[0]] == Player.nought.rawValue) {
                        label.text = "Nought has won!";
                    }
                    
                    gameOver = true;
                }
            }
        }
    }
    
    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBAction func playAgain(_ sender: AnyObject)
    {
//        stateOfGame = [0, 0, 0, 0, 0, 0, 0, 0, 0]
//        gameActiveState = true
//        activePlayer = 1
//        
//        playAgainButton.isHidden = true
//        label.isHidden = true
//        
//        for i in 1...9
//        {
//            let button = view.viewWithTag(i) as! UIButton
//            button.setImage(nil, for: UIControlState())
//        }
    }
    
    
    
}

