//
//  ViewController.swift
//  Lab3
//
//  Created by LiMengyan on 9/27/16.
//  Copyright © 2016 LiMengyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var MyView: myView!
    
    //self.view.Button
    
    @IBAction func myUndo(sender: AnyObject) {
        if MyView.myDrawing?.path.count > 0 {
            MyView.myDrawing?.path.popLast()
        }
        

        
        //currDrawing?.myDrawing? = drawing(points: Points, path: Path)
        
        
        //        if previousDrawing.count > 0 {
        //            previousDrawing.removeLast()
        //        }
        
        //print("path number:\(currDrawing?.myDrawing?.path.count)")
        //print("points number:\(currDrawing?.myDrawing?.points.count)")
    }
    //
    @IBAction func myClear(sender: AnyObject) {
        MyView.myDrawing?.path.removeAll()
        
        //previousDrawing.removeAll()
    }
    
    
    //    @IBAction func setBlack(sender: AnyObject) {
    //        print("button clicked")
    //    }
    //
    
    @IBAction func widthChanged(sender: UISlider) {
        print("slider moved")
        let width = sender.value
        MyView.currWidth = 1 + 40 * CGFloat(width)
    }
    
    
    @IBAction func setColor(sender: UIButton) {
        let color = sender.backgroundColor
        MyView?.currColor = color!
        print("button clicked")
        
    }
    
    @IBAction func paperStyle(sender: AnyObject) {
        let color = UIColor.init(red: 1, green: 1, blue: 0, alpha: 0.3)
        if !(MyView.backgroundColor == color) {
            MyView.backgroundColor = color
        } else {
            MyView.backgroundColor = UIColor.clearColor()
        }
    }
    
    @IBAction func penStyle(sender: AnyObject) {
        MyView.setMarker = !(MyView.setMarker)
    }
    
    
    
    
    @IBOutlet weak var paperStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    






}