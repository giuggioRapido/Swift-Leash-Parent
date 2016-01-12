//
//  ViewController.swift
//  Swift Digital Leash-Parent
//
//  Created by Chris on 1/12/16.
//  Copyright © 2016 Prince Fungus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var radiusField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func submit(sender: AnyObject) {
    }

}

