//
//  drawing.swift
//  MengyanLi-Lab3
//
//  Created by LiMengyan on 9/26/16.
//  Copyright © 2016 LiMengyan. All rights reserved.
//

import UIKit


struct drawing {
    
    //var points: [CGPoint]
    var path: [PATH]
    var width: CGFloat
    
    init(path: [PATH],width:CGFloat) {
    //init(points:[CGPoint]) {
        //self.points = points
        self.path = path
        self.width = width
    }

    
    
}
