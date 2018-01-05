//
//  ViewController.swift
//  TicTacToeLocal
//
//  Created by Barooah, Brandon N on 1/3/18.
//  Copyright © 2018 personal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var buttonCollection: [UIButton]!
    var activePlayer = 1
    var player1 = [Int]()
    var player2 = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func playGame(button:UIButton){
        
        if activePlayer == 1 {
            button.setTitle("X", for: .normal)
            button.backgroundColor = UIColor(red: 102/255, green: 250/255, blue: 51/255, alpha: 0.5)
            player1.append(button.tag)
            activePlayer = 2
            
        } else {
            button.setTitle("O", for: .normal)
            button.backgroundColor = UIColor(red: 32/255, green: 192/255, blue: 243/255, alpha: 0.5)
            player2.append(button.tag)
            activePlayer = 1
        }
        
        button.isEnabled = false
        if(!findWinner() && activePlayer == 2){
            autoPlayer()
        }
    }
    
    func findWinner() -> Bool{
        var winner = -1
        // Row 1
        if(player1.contains(1) && player1.contains(2) && player1.contains(3)){
            winner = 1
        }
        if(player2.contains(1) && player2.contains(2) && player2.contains(3)){
            winner = 2
        }
        // Row 2
        if(player1.contains(4) && player1.contains(5) && player1.contains(6)){
            winner = 1
        }
        if(player2.contains(4) && player2.contains(5) && player2.contains(6)){
            winner = 2
        }
        // Row 3
        if(player1.contains(7) && player1.contains(8) && player1.contains(9)){
            winner = 1
        }
        if(player2.contains(7) && player2.contains(8) && player2.contains(9)){
            winner = 2
        }
        // Col 1
        if(player1.contains(1) && player1.contains(4) && player1.contains(7)){
            winner = 1
        }
        if(player2.contains(1) && player2.contains(4) && player2.contains(7)){
            winner = 2
        }
        // Col 2
        if(player1.contains(2) && player1.contains(5) && player1.contains(8)){
            winner = 1
        }
        if(player2.contains(2) && player2.contains(5) && player2.contains(8)){
            winner = 2
        }
        // Col 3
        if(player1.contains(3) && player1.contains(6) && player1.contains(9)){
            winner = 1
        }
        if(player2.contains(3) && player2.contains(6) && player2.contains(9)){
            winner = 2
        }
        // Diagonols
        if(player1.contains(1) && player1.contains(5) && player1.contains(9)){
            winner = 1
        }
        if(player2.contains(1) && player2.contains(5) && player2.contains(9)){
            winner = 2
        }
        if(player1.contains(3) && player1.contains(5) && player1.contains(7)){
            winner = 1
        }
        if(player2.contains(3) && player2.contains(5) && player2.contains(7)){
            winner = 2
        }
        
        if(winner != -1){
            let alert = UIAlertController(title: "Winner!", message: "Player \(winner) won!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler:{(action) in
                self.playAgain()
                
            }))
          
            self.present(alert, animated: true, completion: nil)
            return true
        }
        // Check if any empty cells left
        var noEmpty = true
        for i in 1...9 {
            if(!player1.contains(i) && !player2.contains(i)){
                noEmpty = false
            }
        }
        if noEmpty {
            let alert = UIAlertController(title: "No Winner :(", message: "Would you like to play again?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler:{(action) in
                self.playAgain()
                
            }))
            self.present(alert, animated: true, completion: nil)
            return true
        }
        return false
    }
    
    func autoPlayer(){
        
        // Scan for empty cells
        var emptyCells = [Int]()
        for i in 1...9 {
            if(!player1.contains(i) && !player2.contains(i)){
                emptyCells.append(i)
            }
        }
        
        guard emptyCells.count > 0 else {
            return
        }
        
        let randIndex = arc4random_uniform(UInt32(emptyCells.count))
        let cellId = emptyCells[Int(randIndex)]
        let button = buttonCollection[cellId - 1]
        playGame(button: button)
    }
    
    func playAgain(){
        buttonCollection.forEach { (button) in
            button.isEnabled = true
            button.setTitle("", for: .normal)
            button.backgroundColor = UIColor.white
        }
        player1.removeAll()
        player2.removeAll()
        activePlayer = 1
    }
    
    @IBAction func buttonSelect(_ sender: Any) {
        
        if let button = sender as? UIButton {
            playGame(button: button)
        }
    }
    
}

