//
//  ViewController.swift
//  Scrum Board
//
//  Created by Chris Chang on 17/04/2018.
//  Copyright © 2018 Chris Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onClickNewToDo(_ sender: Any) {
        let alert = UIAlertController(title: "Add a new ToDo", message: "add your task here", preferredStyle: .alert)
        
        alert.addTextField()
        alert.textFields![0].placeholder = "Add a New ToDo"
        //alert.textFields![0].layer.cornerRadius = 15
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textFld = alert?.textFields![0]
            print(textFld?.text)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}

