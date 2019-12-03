//
//  MainViewController+Extension.swift
//  Multithreading827
//
//  Created by mac on 9/17/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

extension MainViewController {
    
    
    /* MARK: GCD - Grand Central Dispatch - Multithreading
     
     In IOS dev - we have 4 threads - 2 background/ 2 main threads
     Thread is the context in which you do work, and the queue holds work items to be done
     
     Sync vs Async - sync will NOT continue execution until work items are done, async will continue and do more work
     concurrent vs serial - concurrent is simultaneous, serial is one at time
     
     Use background thread for large amounts of work - downloading data, or expensive tasks
     Use Main Thread for UI changes/updates
     
     */
    
    //MARK: Sync tasks
    
    func doSyncTasks() {
        
        //With sync - you have predicatability but you lose performance
        
        for num in one {
            DispatchQueue.global().sync {
                print(num)
            }
        }
        
        for num in two {
            DispatchQueue.global().sync {
                print(num)
            }
        }
    }
    
    //MARK: Async Tasks
    
    func doAsyncTasks() {
        
        //Async - you lose predicatability but gain performance - CPU choses which tasks to execute in what order - optimized
        
        for num in one {
            DispatchQueue.global().async {
                print(num)
            }
        }
        
        
        for num in two {
            DispatchQueue.global().async {
                print(num)
            }
        }
    }
    
    //MARK: Deadlock
    //two threads waiting on a single resource
    
    func createDeadlock() {
        
        
        DispatchQueue.main.async {
            //sync must wait for the outer block to be done
            if Thread.isMainThread { // check to see if you are on the main thread before using main sync
                DispatchQueue.main.sync {
                    //never use sync whenever you are already on the main thread
                    print("Done Sync Tasks")
                }
            }
        }
    }
    
    
    //MARK: Dispatch Barrier
    
    //used to make a synchronization in between async tasks
    
    func doDispatchBarrier() {
        
        let concurrent = DispatchQueue(label: "concurrent", attributes: .concurrent)
        
        for num in one {
            concurrent.async {
                print(num)
            }
        }
        
        //Dispatch Barrier - creates sync point
        concurrent.async(flags: .barrier) {
            print("----------Sync Tasks------------")
        }
        
        
        for num in two {
            concurrent.async {
                print(num)
            }
            
        }
    }
    
    
    //MARK: Dispatch Group
    
    func doDispatchGroup() {
        
        //you can enter a group before work item and leave whenever the item is finished and be notified whenever all groups have left
        //enter and leave MUST be 1 to 1 relationship
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        for num in one {
            print(num)
        }
        dispatchGroup.leave()
        
        dispatchGroup.enter()
        for num in two {
            print(num)
        }
        dispatchGroup.leave()
        
        
        dispatchGroup.notify(queue: .main) {
            print("All Numbers Have Printed")
        }
    }
    
    
    //MARK: Dispatch Semaphores
    
    func doDispatchSemaphore() {
        
        /* Qualities Of Service - in order by priority
        1. UserInteractive
        2. UserInitiated
        3. default
        4. utility
        5. background
        */
        
        //controls the amount of threads that can access a resource at one time
        let semaphor = DispatchSemaphore(value: 1)
        
        let kidOne = DispatchQueue.global(qos: .userInitiated)
        let kidTwo = DispatchQueue.main
        let kidThree = DispatchQueue.global(qos: .background)
        
        
        kidTwo.async {
            print("Kid Two Is Waiting...")
            semaphor.wait() // decrease the count
            print("Kid Two is Playing")
            print("--------2--------")
            sleep(2)
            semaphor.signal() // increase the count - free up access to the resource
            print("Kid Two is done playing")
        }
        
        kidThree.async {
            print("Kid Three Is Waiting...")
            semaphor.wait() // decrease the count
            print("Kid Three is Playing")
            print("--------3--------")
            sleep(2)
            semaphor.signal() // increase the count - free up access to the resource
            print("Kid Three is done playing")
        }
        
        kidOne.async {
            print("Kid One Is Waiting...")
            semaphor.wait() // decrease the count
            print("Kid One is Playing")
            print("--------1--------")
            sleep(2)
            semaphor.signal() // increase the count - free up access to the resource
            print("Kid One is done playing")
        }
        

        
    }
    
    
}
