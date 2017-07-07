//
//  FavoriteViewController.swift
//  MengyanLi-Lab4
//
//  Created by LiMengyan on 10/18/16.
//  Copyright © 2016 LiMengyan. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var myTable: UITableView!
    
    let userDefaults:UserDefaults = UserDefaults.standard
    var myArray:[String]=[]
    //var newFavorite:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self

        // Do any additional setup after loading the view.
//        if (userDefaults.objectForKey("Favorite") != nil) {
//            print("Favorites found")
//            //print("\(userDefaults.objectForKey("Favorites")))")
//            newFavorite = userDefaults.objectForKey("Favorite") as! String
//            print("\(newFavorite)")
//            
//        } else {
//            print("Favorite not found")
//            userDefaults.setObject("Hit add button", forKey: "Favorite")
//        }
        
        //myArray.append(newFavorite)
        //userDefaults.setObject(myArray, forKey: "Favorites")

        if (userDefaults.object(forKey: "Favorites") != nil) {
            print("saved myArray found")
            if (userDefaults.object(forKey: "Favorites") is Array<String>) {
                myArray = userDefaults.stringArray(forKey: "Favorites")!
                print(myArray)
            }
        } else {
            print("create file myArray")
            //myArray.append(newFavorite)
//            myArray.append("sad")
//            myArray.append("Come on")
            userDefaults.set(myArray, forKey: "Favorites")
        }
        
        
        //save the data
        //NSUserDefaults.standardUserDefaults().setValue(myArray, forKey: "Favorites")

        self.myTable.reloadData()
        
        let added:[String] = []
        print(added)
        userDefaults.set(added, forKey: "AddedFavorites")
        tabBarController?.tabBar.items?[1].badgeValue = nil

        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //var myArray = ["Mary", "Billy", "Jane"]
    override func viewWillAppear(_ animated: Bool) {
        
        
        if (userDefaults.object(forKey: "Favorites") != nil) {
            print("saved myArray found")
            if (userDefaults.object(forKey: "Favorites") is Array<String>) {
                myArray = userDefaults.stringArray(forKey: "Favorites")!
                print(myArray)
            }
        } else {
            print("create file myArray")
            //myArray.append(newFavorite)
            //            myArray.append("sad")
            //            myArray.append("Come on")
            userDefaults.set(myArray, forKey: "Favorites")
        }
        myTable.reloadData()
        
        let added:[String] = []
        print(added)
        userDefaults.set(added, forKey: "AddedFavorites")
        tabBarController?.tabBar.items?[1].badgeValue = nil

    }
    
    
    
    
    
//    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "myCell")! as UITableViewCell
        
               
        //let myCell = UITableViewCell(style: .Default, reuseIdentifier: nil)
        
        myCell.textLabel!.text = myArray[indexPath.row]
        
        
        
        return myCell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myArray.remove(at: indexPath.row)
            myTable.reloadData()
            userDefaults.set(myArray, forKey: "Favorites")
//            if userDefaults.objectForKey("AddedFavorites") != nil {
//                var added = userDefaults.stringArrayForKey("AddedFavorites")!
//                if (!added.isEmpty) {
//                    added.removeAtIndex(indexPath.row)
//                }
//                userDefaults.setObject(added, forKey: "AddedFavorites")
//                print("saved removed: \(added)")
//            }

        }
    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
