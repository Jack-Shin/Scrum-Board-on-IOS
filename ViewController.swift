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
    
    @IBOutlet weak var segmtd: UISegmentedControl!
    
    var tasks: [Task] = [Task(title: "ABC", section: .InProgress), Task(title: "DEF", section: .Done)]
    var showingTasks: [Task] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showingTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "todoCell")
        
        cell?.textLabel?.text = self.showingTasks[indexPath.row].title
        
        return cell!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
        makeShowingTasks(sec: .ToDo)
        
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
            self.makeShowingTasks(sec: self.getSectionFromSegmtd())
            self.tableview.reloadData()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getSectionFromSegmtd() -> Section{
        var section: Section?
        switch segmtd.selectedSegmentIndex {
        case 0:
            section = .ToDo
            break
        case 1:
            section = .InProgress
            break
        case 2:
            section = .Done
            break
            
        default:
            print("There are some error")
        }
        return section!
    }
    
    func makeShowingTasks(sec: Section) {
        showingTasks.removeAll()
        for x in tasks {
            if x.section == sec {
                showingTasks.append(x)
            }
        }
    }
    
    @IBAction func onClickSegmtd(_ sender: Any) {
        switch segmtd.selectedSegmentIndex {
        case 0:
            makeShowingTasks(sec: .ToDo)
            break
        case 1:
            makeShowingTasks(sec: .InProgress)
            break
        case 2:
            makeShowingTasks(sec: .Done)
            break
        default:
            print("There are some errors")
        }
        self.tableview.reloadData()
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
