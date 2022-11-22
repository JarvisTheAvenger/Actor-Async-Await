//
//  ViewController.swift
//  MediumThreading
//
//  Created by Rahul on 18/11/22.
//

import UIKit

/*
 class AppleStore {
     let location: String
     var stock = 2000

     init(location: String) {
         self.location = location
     }

     func sell(value: Int) {
         print("\(location): start transaction process...")
         if self.stock > value {
             // sleeping for some time, simulating server process
             Thread.sleep(forTimeInterval: Double.random(in: 0...1))
             self.stock -= value
             print("\(location): \(value) has been sold")
             print("current balance is \(self.stock)")
             if self.stock < 0 {
                 print("there is a stock issue")
             }
         } else {
             print("\(location): Can't sell due to insufficent balance")
         }
     }
 }
 */


actor AppleStore {
    let location: String
    var stock = 2000
    nonisolated var openTime : Date  {
        Date()
    }

    init(location: String) {
        self.location = location
    }

    func sell(value: Int) {
        print("\(location): start transaction process...")
        if self.stock > value {
            // sleeping for some time, simulating server process
            Thread.sleep(forTimeInterval: Double.random(in: 0...1))
            self.stock -= value
            print("\(location): \(value) has been sold")
            print("current balance is \(self.stock)")
            if self.stock < 0 {
                print("there is a stock issue")
            }
        } else {
            print("\(location): Can't sell due to insufficent balance")
        }
    }
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let appleStoreIndia = AppleStore(location: "India")

        let queue1 = DispatchQueue(label: "sellQueue1")
        let queue2 = DispatchQueue(label: "sellQueue2")

        queue1.async {
            Task {
                await appleStoreIndia.sell(value: 1000)
            }
        }

        queue2.async {
            Task {
                await appleStoreIndia.sell(value: 1500)
            }
        }

    }

}

