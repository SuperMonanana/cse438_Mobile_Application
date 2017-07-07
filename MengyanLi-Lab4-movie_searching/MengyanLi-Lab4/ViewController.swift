//
//  ViewController.swift
//  MengyanLi-Lab4
//
//  Created by LiMengyan on 10/17/16.
//  Copyright © 2016 LiMengyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
    UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate {
    
    
    @IBOutlet weak var mySearch: UISearchBar!
    
    @IBOutlet weak var movieCollection: UICollectionView!
    
    //var movies=["National Treasure","Harry Potter"]
    var movies:[movie] = []
    let defaultUrl = "http://vignette3.wikia.nocookie.net/canadians-vs-vampires/images/a/a4/Not_available_icon.jpg/revision/latest?cb=20130403054528"

    
    var imageArray:[UIImage] = []
    var added: [String] = []
    let userDefaults:UserDefaults = UserDefaults.standard
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.movieCollection.dataSource = self
        self.movieCollection.delegate = self
        self.mySearch.delegate = self
        
        InitializeSpinner()
        
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
    
    
    //COLLECTIONVIEW STUFF
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 1
//        
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //print ("in cell for item at row \(indexPath.row) and section \(indexPath.section) ")
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movie", for: indexPath) as! MyCollectionViewCell
//        let cell:myCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("movie", forIndexPath: indexPath) as! myCollectionCell
        
        cell.backgroundColor = UIColor.green
        
        cell.poster?.image = self.imageArray[indexPath.row]
        //cell.title?.text = self.movies[indexPath.row]
        cell.title?.text = self.movies[indexPath.row].name
        
        return cell
    }
    
    //show details
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: self)
        //loadingSpinner()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"
        {
            
            let indexPaths = self.movieCollection!.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as IndexPath
            
            let vc = segue.destination as! NewViewController
            
            vc.image = self.imageArray[indexPath.row]
            vc.title = self.movies[indexPath.row].name
           // vc.title = self.movies[indexPath.row]
            let id = self.movies[indexPath.row].id
            
            let tempjson = getJSON("http://www.omdbapi.com/?i=\(id)&y=&plot=short&r=json")
            //print(tempjson)
            
            vc.year = "Released: " + self.movies[indexPath.row].year
            vc.rating = "Rating: " + tempjson["imdbRating"].stringValue
            vc.director = "Director: " + tempjson["Director"].stringValue
            //loadingEndSpinner()
        }
    }
    
    
    let wait = UIActivityIndicatorView(frame:CGRect(x:0,y:0,width: 50,height: 50))
    func InitializeSpinner() {
        wait.color = UIColor.black
        //wait.backgroundColor=UIColor.blueColor()
        wait.hidesWhenStopped = true
       
        wait.center = self.view.center
        self.view.addSubview(wait)
        
    }
    func loadingSpinner() {
        //wait.hidden = false
        wait.startAnimating()
    }
    func loadingEndSpinner() {
        //wait.hidden = true
        wait.stopAnimating()
    }
    
    //Search staff
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        loadingSpinner()
        mySearch.resignFirstResponder()
        self.movies.removeAll(keepingCapacity: false)
        self.imageArray.removeAll()
        //if (!(mySearch.text?.isEmpty)!) {
        let search = mySearch.text!
        
        
        //print(search)
        
        let json = getJSON("http://www.omdbapi.com/?s=\(search)&r=json")
        //print(json)
        
        //print(json["Search"].count)
        for result in json["Search"].arrayValue {
            //print(result)
                let name = result["Title"].stringValue
                //let description = result["Plot"].stringValue
                let year = result["Year"].stringValue
                let url = result["Poster"].stringValue
                //let cast = result["Actors"].stringValue
                //let director = result["Director"].stringValue
                let id = result["imdbID"].stringValue
                movies.append(movie(url: url,name: name, year: year,id:id))
//

        }

        
        let json2 = getJSON("http://www.omdbapi.com/?s=\(search)&page=2&r=json")
        //print(json["Search"].count)
        for result in json2["Search"].arrayValue {
            let name = result["Title"].stringValue
            //let description = result["Plot"].stringValue
            let year = result["Year"].stringValue
            let url = result["Poster"].stringValue
            //let cast = result["Actors"].stringValue
            //let director = result["Director"].stringValue
            let id = result["imdbID"].stringValue
            
            movies.append(movie(url: url,name: name, year: year,id:id))
            
        }

        
        func cacheImages() {
            for item in movies{
                if let url = URL(string :item.url) {
                    if let data = try? Data(contentsOf: url) {
                        let image = UIImage(data: data)
                        imageArray.append(image!)
                    } else {
                        let temp = URL(string: defaultUrl)
                        let data = try? Data(contentsOf: temp!)
                        let image = UIImage(data: data!)
                        imageArray.append(image!)
                       
                    }
                } else {
                    let temp = URL(string: defaultUrl)
                    let data = try? Data(contentsOf: temp!)
                    let image = UIImage(data: data!)
                    imageArray.append(image!)
                }
                
            }
            
        }

        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).async{
            //self.loadingEndSpinner()
            cacheImages()
            
            DispatchQueue.main.async {
                //self.view.addSubview(self.view1)
                self.loadingEndSpinner()
                
                self.movieCollection.reloadData()
                
                //self.movieCollection.reloadData()
                if self.movies.count == 0 {
                    let alertController = UIAlertController(title: "No results", message: "No movies found with input title", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "ok", style: .default, handler: {action in})
                    alertController.addAction(okAction)
                    self.present(alertController, animated:true, completion: nil)

                }
                self.mySearch.resignFirstResponder()
            
//            for subview in self.view.subviews {
//                if subview.tag == 1000 {
//                    subview.removeFromSuperview()
//                }
//            }
            }
        }

    }
    

    
    fileprivate func getJSON(_ url: String) -> JSON {
        
        if let nsurl = URL(string: url){
            if let data = try? Data(contentsOf: nsurl) {
                let json = JSON(data: data)
                return json
            } else {
                return nil
            }
        } else {
            return nil
        }
        
    }

    
}



