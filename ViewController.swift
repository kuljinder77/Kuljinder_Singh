//
//  ViewController.swift
//  C0696764_Test1
//
//  Created by MacStudent on 2017-07-13.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func signin(_ sender: Any)
    
    {
        if(username.text == "admin" && password.text == "admin")
        {
            self.performSegue(withIdentifier: "next", sender: self)
        }
        else
        {
            let alert = UIAlertController(title: "Attention!!", message: "wrong Username or password", preferredStyle: .alert)
            
            var ok = UIAlertAction(title: "OK", style: .cancel , handler: nil)
            
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
        }

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "next")
        {
            let obj = segue.destination as! fetch
        }
        
        
    }

}

