//
//  ViewController.swift
//  Lab1
//
//  Created by LiMengyan on 6/15/16.
//  Copyright © 2016 LiMengyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBOutlet weak var originalPrice: UITextField!
    
    @IBOutlet weak var discount: UITextField!
    
    @IBOutlet weak var tax: UITextField!
    
    @IBOutlet weak var finalPrice: UILabel!
    
    
    
   
    
    
    @IBAction func inputChanged(sender: UITextField) {
        var priceValue : Double = 0.0
        if let priceText = originalPrice.text {
            if let priceDouble = Double(priceText) {
                priceValue = priceDouble
            } else {
                priceValue = -1.0
            }
        }
        
        var discountValue : Double = 0.0
        if let discText = discount.text {
            if let discountDouble = Double(discText) {
                discountValue = discountDouble
            } else {
                discountValue = -1.0
            }
        }

        var taxValue : Double = 0.0
        if let taxText = tax.text {
            if let taxDouble = Double(taxText) {
                taxValue = taxDouble
            } else {
                taxValue = -1.0
            }
        }

       
        var finalprice = 0.0
        var displayText = "Please input valid numbers in each fields"
        finalPrice.text = displayText
        finalPrice.textColor = UIColor.blackColor()
        
        
        if priceValue >= 0 && (discountValue >= 0 && discountValue <= 100) && taxValue >= 0 {
            
            finalprice = priceValue * (100 - discountValue) * (100 + taxValue) / 10000
            if discountValue < 50 {
                displayText = "$\(String(format: "%.2f", finalprice))"
                view.backgroundColor = UIColor.whiteColor()
                finalPrice.textColor = UIColor.blackColor()
            } else {
                view.backgroundColor = UIColor.yellowColor()
                displayText = "Great Deal! $\(String(format: "%.2f", finalprice))"
                finalPrice.textColor = UIColor.redColor()
            }
          
            finalPrice.text = displayText
        
        }
        
        switch sender.tag {
        case 0:
            if priceValue < 0 {
                originalPrice.backgroundColor = UIColor.redColor()
            } else {
                originalPrice.backgroundColor = UIColor.greenColor()
            }
            discount.backgroundColor = UIColor.whiteColor()
            tax.backgroundColor =  UIColor.whiteColor()
        case 1:
            if discountValue < 0 || discountValue > 100 {
                discount.backgroundColor = UIColor.redColor()
            } else {
                discount.backgroundColor = UIColor.greenColor()
            }
            originalPrice.backgroundColor = UIColor.whiteColor()
            tax.backgroundColor =  UIColor.whiteColor()

        case 2:
            if taxValue < 0 {
                tax.backgroundColor = UIColor.redColor()
            } else {
                tax.backgroundColor = UIColor.greenColor()
            }
            discount.backgroundColor = UIColor.whiteColor()
            originalPrice.backgroundColor =  UIColor.whiteColor()
            
        default:
            fatalError("unknown tag assignment")
        }
        
    }


}

    

    
   
    
    
    
    
