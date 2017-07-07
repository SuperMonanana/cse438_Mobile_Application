//
//  PATH.swift
//  MengyanLi-Lab3
//
//  Created by LiMengyan on 9/28/16.
//  Copyright © 2016 LiMengyan. All rights reserved.
//

import UIKit

struct PATH {
    var line: UIBezierPath
    var width:CGFloat
    var color:UIColor
    var setToMarker: Bool
    
    init(line: UIBezierPath,width: CGFloat,color:UIColor,setToMarker: Bool) {
        self.line = line
        self.width = width
        self.color = color
        self.setToMarker = setToMarker
    }
}