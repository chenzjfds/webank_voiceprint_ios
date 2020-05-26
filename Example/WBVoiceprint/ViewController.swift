//
//  ViewController.swift
//  VoiceprintDemo
//
//  Created by zhijunchen on 2020/5/18.
//  Copyright © 2020 webank. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    var demo=Demo.Shared
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        demo.test()
       
    }
    @IBAction func regist(sender: AnyObject) {
          demo.regist()
//         demo.showToast()
      }
    @IBAction func verify(sender: AnyObject) {
        demo.verify()
    }
    @IBAction func delete(sender: AnyObject) {
        demo.delete()
       }
    @IBAction func search(sender: AnyObject) {
           demo.search()
       }
}

