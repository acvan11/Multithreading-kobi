//
//  ViewController.swift
//  Multithreading827
//
//  Created by mac on 9/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let tableView = UITableView()

    let one = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    let two = [Int](11...19)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMain()
        
    }
    
    
    private func setupMain() {
        
        title = "Multithreading Examples"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        
        view.addSubview(tableView) //add to view before setting the constraints
        
        //Programmatic constraints - are not actived by default
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),       tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
            ])
        
        //Either way is fine - same functionality
//        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false // I'm going to create constraints programatically
    }

}


extension MainViewController: UITableViewDataSource {
    
    //how many rows to produce
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    //renders individual row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! // reusable cell
        
        // check if cell is nil or not, and if it is, instantiate a new cell, if not, reuuse
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        }
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Sync Tasks on Background Thread"
            cell.detailTextLabel?.text = "Synchronize tasks using GCD"
        case 1:
            cell.textLabel?.text = "Async Tasks on Background Thread"
            cell.detailTextLabel?.text = "Execute Asynchronous Tasks on the Background Thread"
        case 2:
            cell.textLabel?.text = "Create Deadlock"
            cell.detailTextLabel?.text = "Two Threads waiting on the same resourece"
        case 3:
            cell.textLabel?.text = "Dispatch Barrier"
            cell.detailTextLabel?.text = "Create sync point in between async tasks"
        case 4:
            cell.textLabel?.text = "Dispatch Group"
            cell.detailTextLabel?.text = "Be notified whenever all groups have left for completion"
        case 5:
            cell.textLabel?.text = "Dispatch Semaphore"
            cell.detailTextLabel?.text = "Controls amount of threads that can access a resource"
        default:
            break
        }
        
        
        return cell
    }
    
}


extension MainViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            doSyncTasks()
        case 1:
            doAsyncTasks()
        case 2:
            createDeadlock()
        case 3:
            doDispatchBarrier()
        case 4:
            doDispatchGroup()
        case 5:
            doDispatchSemaphore()
        default:
            break
        }
    }
    
    
}

