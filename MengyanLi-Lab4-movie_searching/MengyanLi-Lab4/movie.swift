//
//  movie.swift
//  MengyanLi-Lab4
//
//  Created by LiMengyan on 10/18/16.
//  Copyright © 2016 LiMengyan. All rights reserved.
//

import UIKit


class movie {
    
    var url:String
    var name: String
    var year: String
    //var image: UIImage
    var id: String
    
    init (url:String, name:String, year:String,id:String){
        self.url = url
        self.name = name
        self.year = year
        //self.description = description
        //self.image = image
        //self.rating = rating
        //self.director = director
        self.id = id
    }
}
