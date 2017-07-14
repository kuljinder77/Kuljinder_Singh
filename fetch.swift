//
//  fetch.swift
//  C0696764_Test1
//
//  Created by MacStudent on 2017-07-13.
//  Copyright © 2017 MacStudent. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class fetch : UIViewController , UITableViewDelegate ,UITableViewDataSource
{
    var count = 0 ;
    var user: [NSManagedObject] = []

    @IBOutlet weak var table: UITableView!
        @IBAction func fetch(_ sender: Any)
    
    {
        fetchdata()
        self.table.reloadData();
        
        
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 ;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let u = user[indexPath.row] as! Users
        cell.textLabel?.text = u.name
        
        count = indexPath.row;
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let u = user[indexPath.row] as! Users
        count = indexPath.row ;
        let alert = UIAlertController(title: "User", message: "Name :"+" "+u.name!+" "+"  Address :"+" "+u.address!, preferredStyle: .alert)
        
        var ok = UIAlertAction(title: "OK", style: .cancel , handler: nil)
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)

    }
    
    func fetchdata(){
        
        
        let session   = URLSession.shared
        let urlString = "https://api.randomuser.me/"
        let request   = NSURLRequest(url: NSURL(string: urlString)! as URL)
        let task      = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            NSLog("Success")
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:AnyObject]
            } catch {
                print("Could not parse the data as JSON: \(data!)")
                return
            }
            
            
            let results =  parsedResult["results"] as! [AnyObject]
            print(results[0]["cell"])
            
            
            let r1 = results[0] as! [String:AnyObject]
            print(r1["cell"]!)
            
            print(r1["email"]!)
            
            
            print(r1["location"]?["city"]!)
            
            let email = r1["email"] as! String
            print(email)
            
            
            let imageUrl = r1["picture"]?["large"] as! String;
            
            print(imageUrl)
            
            
            /////////////insertion/////////
            
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            // 1
            let managedContext =
                appDelegate.persistentContainer.viewContext
            // 2
            let entity =
                NSEntityDescription.entity(forEntityName: "Users",
                                           in: managedContext)!
            let emp = NSManagedObject(entity: entity,
                                      insertInto: managedContext)
            // 3
            
            var a = r1["name"]?["title"]! as! String;
            var b = r1["name"]?["first"]! as! String;
            var c = r1["name"]?["last"]! as! String;
            var name = a+" "+b+" "+c;
            
            
            
            var a1 = r1["location"]?["street"]! as! String;
            var a2 = r1["location"]?["city"]! as! String;
            var a3 = r1["location"]?["state"]! as! String;
            
            var address = a1+" "+a2+" "+a3;
            
            let gender = r1["gender"]
            
            var username = r1["login"]?["username"]! as! String;
            
            var password = r1["login"]?["password"]! as! String;
            
            var phone = r1["cell"]! as! String;
            
            
            
        
            emp.setValue(name, forKeyPath: "name")
            emp.setValue(gender, forKeyPath: "gender")
            emp.setValue(address, forKeyPath: "address")
            emp.setValue(username, forKeyPath: "password")
            emp.setValue(password, forKeyPath: "username")
            emp.setValue(Int(phone), forKeyPath: "phone")
            
            // 4
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            //2
            let fetchRequest =
                NSFetchRequest<NSManagedObject>(entityName: "Users")
            //3
                        do {
                self.user = try managedContext.fetch(fetchRequest)
                
                for m in self.user
                {
                    let s = m as! Users
                    print("Name \(s.name)")
                    
                  print(" \(s.username)")
                   print(" \(s.password)")
                    
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }

            
            
            
        }
        task.resume()
        
    }
    

    
    

}
