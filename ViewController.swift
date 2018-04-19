//
//  ViewController.swift
//  Scrum Board
//
//  Created by Chris Chang on 17/04/2018.
//  Copyright © 2018 Chris Chang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableview: UITableView!
    
    var tasks: [Task] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "todoCell")
        
        cell?.textLabel?.text = self.tasks[indexPath.row].title
        
        return cell!
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
    }

    @IBAction func onClickNewToDo(_ sender: Any) {
        let alert = UIAlertController(title: "Scrum Board", message: "write a new todo below.", preferredStyle: .alert)
        
        alert.addTextField()
        alert.textFields![0].placeholder = "Add a new task to do here."
        //alert.textFields![0].layer.cornerRadius = 15
        
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textFld = alert?.textFields![0]
            self.tasks.append(Task(title: (textFld?.text!)!, section: .ToDo))
            print(self.tasks)
            self.tableview.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    


}

enum Section {
    case ToDo
    case InProgress
    case Done
}

class Task {
    var title: String?
    var section: Section?
    
    init(title: String, section: Section) {
        self.title = title
        self.section = section
    }
}
