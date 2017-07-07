//
//  NewViewController.swift
//  MengyanLi-Lab4
//
//  Created by LiMengyan on 10/18/16.
//  Copyright © 2016 LiMengyan. All rights reserved.
//

import UIKit
import Social

class NewViewController: UIViewController {

    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var releaseLabel: UILabel!
    
    @IBOutlet weak var directorLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    let userDefaults = UserDefaults.standard

    var image = UIImage()
    var year = String()
    var director = String()
    var rating = String()
    var favorites:[String] = []
    var added:[String] = []
    //var newAddedCount = Int()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //newAddedCount = 0
        self.poster.image = self.image
        self.releaseLabel.text = self.year
        self.directorLabel.text = self.director
        self.ratingLabel.text = self.rating
        
        // Do any additional setup after loading the view.
        if (userDefaults.object(forKey: "Favorites") != nil) {
            print("saved favorite found")
            if (userDefaults.object(forKey: "Favorites") is Array<String>) {
                favorites = userDefaults.stringArray(forKey: "Favorites")!
                if favorites.contains(self.title!){
                    button.setTitle("Remove from Favorites", for: UIControlState())
                } else {
                    button.setTitle("Add to Favorites", for: UIControlState())
                }
                userDefaults.set(favorites, forKey: "Favorites")
                
            }
        } else {
            //print("create favorite")
            //favorites.append(self.title!)
            userDefaults.set(favorites, forKey: "Favorites")
        }
        
        if (userDefaults.object(forKey: "AddedFavorites") != nil) {
            if (userDefaults.object(forKey: "AddedFavorites") is Array<String>) {
                //print("new page: \(added)")
                added = userDefaults.stringArray(forKey: "AddedFavorites")!
                //added.append(self.title!)
                //userDefaults.setObject(added, forKey: "AddedFavorites")
                if added.count != 0 {
                    tabBarController?.tabBar.items?[1].badgeValue = "\(added.count)"
                } else {
                    tabBarController?.tabBar.items?[1].badgeValue = nil
                }
            }
        } else {
            //print("create favorite")
            //added.append(self.title!)
            userDefaults.set(added, forKey: "AddedFavorites")
            tabBarController?.tabBar.items?[1].badgeValue = nil
            
        }


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func addButtonClicked(_ sender: AnyObject) {

        if !favorites.contains(self.title!) {
            //newAddedCount += 1
            favorites.append(self.title!)
            userDefaults.set(favorites, forKey: "Favorites")
            //print("\(userDefaults.objectForKey("Favorites")))")
            button.setTitle("Remove from Favorites", for: UIControlState())
            
            
            added.append(self.title!)
            userDefaults.set(added, forKey: "AddedFavorites")
            print(added)
            tabBarController?.tabBar.items?[1].badgeValue = "\(added.count)"
            
            

        } else {
            favorites.remove(at: favorites.index(of: self.title!)!)
            userDefaults.set(favorites, forKey: "Favorites")
            
            let alertController = UIAlertController(title: "Removed", message: "Removed successfully", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default, handler: {action in})
            alertController.addAction(okAction)
            self.present(alertController, animated:true, completion: nil)
    
            added = userDefaults.stringArray(forKey: "AddedFavorites")!
            if added.contains(self.title!) {
                
                added.remove(at: added.index(of: self.title!)!)
                userDefaults.set(added, forKey: "AddedFavorites")
                
                if added.count != 0 {
                    tabBarController?.tabBar.items?[1].badgeValue = "\(added.count)"
                } else {
                    tabBarController?.tabBar.items?[1].badgeValue = nil
                }
                print("\(added.count)")
            }

           // print("\(userDefaults.objectForKey("Favorites")))")
            button.setTitle("Add to Favorites", for: UIControlState())

        }
        
    }
    
    @IBAction func share2Facebook(_ sender: AnyObject) {
        post(toService: SLServiceTypeFacebook)
    }
    func post(toService service: String) {
        if(SLComposeViewController.isAvailable(forServiceType: service)) {
            let socialController = SLComposeViewController(forServiceType: service)
                socialController?.setInitialText("#\(self.title!)(from Mengyan's movie app)")
                socialController?.add(self.image)
            //            socialController.addURL(someNSURLInstance)
            self.present(socialController!, animated: true, completion: nil)
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
