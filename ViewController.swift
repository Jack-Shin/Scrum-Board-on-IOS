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
    
    var tasks: [Task] = []
    var showingTasks: [Task] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showingTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "todoCell")
        
        cell?.textLabel?.text = self.showingTasks[indexPath.row].title
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .normal, title: "DELETE", handler: {(ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            
            let index = self.getRealIndexwithIndexRow(idx: indexPath.row)
            self.tasks.remove(at: index)
            self.makeShowingTasks(sec: self.getSectionFromSegmtd())
            self.tableview.reloadData()
            
        })
        
        //deleteAction.image = UIImage(named: "tick")
        deleteAction.backgroundColor = .red
        
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if self.getSectionFromSegmtd() != .Done {
            let nextAction = UIContextualAction(style: .normal, title: "NEXT", handler: {(ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
                
                let index = self.getRealIndexwithIndexRow(idx: indexPath.row)
                
                switch self.getSectionFromSegmtd() {
                case .ToDo:
                    self.tasks[index].section = .InProgress
                    break
                case .InProgress:
                    self.tasks[index].section = .Done
                    break
                default:
                    break
                    
                }
                self.makeShowingTasks(sec: self.getSectionFromSegmtd())
                self.tableview.reloadData()
                
            })
            
            //nextAction.image = UIImage(named: "tick")
            nextAction.backgroundColor = .purple
            
            
            return UISwipeActionsConfiguration(actions: [nextAction])
        }
        
        return UISwipeActionsConfiguration(actions: [])
        
    }
    
    func getRealIndexwithIndexRow(idx: Int) -> Int {
        let index = self.tasks.index(where: {(task) -> Bool in
            let showingTasksTid = self.showingTasks[idx].tid
            return task.tid == showingTasksTid
        })
        
        return index!
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1.0)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
        
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
            
            
            if (textFld?.text!)!.isEmpty{
                let emptyAlert = UIAlertController(title: "Scrum Board", message: "Please write at least one letter.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK, Sorry", style: .default, handler: nil)
                emptyAlert.addAction(defaultAction)
                self.present(emptyAlert, animated: true, completion: nil)
            }
            else {
                self.tasks.append(Task(title: (textFld?.text!)!, section: .ToDo))
                for x in self.tasks {
                    print(x.tid!)
                }
                print("-----")
                self.makeShowingTasks(sec: self.getSectionFromSegmtd())
                self.tableview.reloadData()
            }
            
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

var lastId: Int = 0
class Task {
    var title: String?
    var section: Section?
    var tid: String?
    
    init(title: String, section: Section) {
        self.title = title
        self.section = section
        self.tid = "TID-" + String(lastId + 1) + "-SCRUM" // => TID-212-SCRUM
        lastId = lastId + 1
    }
}
