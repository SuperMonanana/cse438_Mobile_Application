//
//  myView.swift
//  MengyanLi-Lab3
//
//  Created by LiMengyan on 9/26/16.
//  Copyright © 2016 LiMengyan. All rights reserved.
//

import UIKit

class myView: UIView {
    
    var currDrawingPoint = CGPointZero
    //var previousDrawing = [myView?]()
    //var endPoint = CGPointZero
    //var currDrawing: myView? = nil
    var Points = [CGPoint]()
    var Path = [PATH]()
    var currWidth:CGFloat = 5
    var currColor=UIColor.blackColor()
    var setMarker:Bool = false
    
    var myDrawing:drawing? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        //let path = UIBezierPath()
        
        
       
        if  myDrawing?.path.count > 0{
            for previouspath in (myDrawing?.path)! {
                previouspath.color.set()
                previouspath.line.lineWidth = previouspath.width
                if previouspath.setToMarker == false {
                    previouspath.line.lineCapStyle = .Round
                    previouspath.line.lineJoinStyle = .Round
                }
                previouspath.line.stroke()
            }
 
        } 
        if Points.count > 2{
            let currPath = createQuadPath(Points)
            //myDrawing?.path.append(currPath)
            print("path number:\(myDrawing!.path.count)")
            //print("points number:\(myDrawing!.points.count)")

            
            self.currColor.set()
            currPath.lineWidth = myDrawing!.width
            if !(self.setMarker == true) {
                currPath.lineCapStyle = .Round
                currPath.lineJoinStyle = .Round
            }
            currPath.stroke()
        }
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        
        let touchPoint = (touches.first)!.locationInView(self) as CGPoint
        print ("the start point is \(touchPoint)")
        
        currDrawingPoint = touchPoint
        Points.append(currDrawingPoint)
        Points.append(currDrawingPoint)
        
        //print("check start point\(Points.count)")
        if !(myDrawing == nil)  {
            if Path.count > myDrawing!.path.count {
                Path = myDrawing!.path
                print("\(Path.count)")
                print("\(myDrawing?.path.count)")
            }
        }
        
        self.myDrawing = drawing(path:Path, width: currWidth)
        //self.backgroundColor = UIColor.clearColor()
        
        
        //print("current drawing points when touch began:\(currDrawing!.myDrawing!.points.count)")
        //print("previous stored path when touch began:\(currDrawing!.myDrawing!.path.count)")
        
        //self.view.addSubview(currDrawing!)
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchPoint = (touches.first)!.locationInView(self) as CGPoint
        //print ("Moving \(touchPoint)")
        
        Points.append(touchPoint)
        //myDrawing!.points = Points
        setNeedsDisplay()
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touchPoint = (touches.first)!.locationInView(self) as CGPoint
        
        
        //        currDrawing!.myDrawing!.points.append(touchPoint)
        //        currDrawingPoint = touchPoint
        
        Points.append(touchPoint)
        //myDrawing!.points = Points
        let line = self.createQuadPath(Points)
        let path = PATH(line: line,width: currWidth,color: currColor,setToMarker: setMarker)
        
        Path.append(path)
        Points.removeAll()
        myDrawing = drawing(path: Path, width: currWidth)
        
        //print("current drawing points when touch ended:\(currDrawing!.myDrawing!.points.count)")
        //print("previous stored path when touch ended:\(currDrawing!.myDrawing!.path.count)")
        
        
    }    
    private func findMidpoint(firstPoint: CGPoint, secondPoint: CGPoint) -> CGPoint {
        // implement this function here
        var midPoint = CGPointZero
        midPoint.x = (firstPoint.x + secondPoint.x)/2
        midPoint.y = (firstPoint.y + secondPoint.y)/2
        return midPoint
    }
    
    func createQuadPath(arrayOfPoints: [CGPoint]) -> UIBezierPath {
        let newPath = UIBezierPath()
        let firstLocation = arrayOfPoints[0]
        newPath.moveToPoint(firstLocation)
        let secondLocation = arrayOfPoints[1]
        let firstMidpoint = findMidpoint(firstLocation, secondPoint: secondLocation)
        newPath.addLineToPoint(firstMidpoint)
        for index in 1 ..< arrayOfPoints.count-1 {
            let currentLocation = arrayOfPoints[index]
            let nextLocation = arrayOfPoints[index + 1]
            let midpoint = findMidpoint(currentLocation, secondPoint: nextLocation)
            newPath.addQuadCurveToPoint(midpoint, controlPoint: currentLocation)
        }
        let lastLocation = arrayOfPoints.last
        newPath.addLineToPoint(lastLocation!)
        return newPath
    }
    

}
