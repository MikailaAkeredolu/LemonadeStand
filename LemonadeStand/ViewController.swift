//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Mikaila Akeredolu on 2/2/15.
//  Copyright (c) 2015 MakerOfAppsDotCom. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    //OUTLETS
    
    //You have Labels
    @IBOutlet weak var moneySupplyCount: UILabel!
    
    @IBOutlet weak var lemonSupplyCount: UILabel!
    
    @IBOutlet weak var iceCubeSupplyCount: UILabel!
    
    //Step 1 & 2 Labels
    @IBOutlet weak var lemonPurchaseCount: UILabel!
    
    @IBOutlet weak var iceCubePurchaseCount: UILabel!
    
    @IBOutlet weak var lemonMixCount: UILabel!
    
    @IBOutlet weak var iceCubeMixCount: UILabel!
    
    
    //create global properties for supplies and price
    
    var supplies = Supplies(aMoney: 10, aLemon: 1, aIceCubes: 1) //using Supplies Struct initializer
    let price = Price()  //using Price Struct
    
    
    //create global properties for supplies and price
    
    //start purchasing supplies (+ -)
    var lemonsToPurchase = 0 //use to track the number of lemons we are purchasing
    var iceCubesToPurchase = 0 //use to track the number of iceCubes we are purchasing
    
    //start mixing lemonade (+ -)
    var lemonsToMix = 0 //use to track the number of lemons we are mixing
    var iceCubesToMix = 0 //use to track the number of iceCubes we are mixing
    
    
    
    
    //ACTIONS + & - buttons for step 1 & 2
    
    @IBAction func purchaseButtonLemonPressed(sender: UIButton) { //+ lemon $2
        
       //lemonsToPurchase = moneySupplyCount.text - "\(price.lemon)"
        
        if supplies.money >= price.lemon{ //constant value in Price struct
            
            lemonsToPurchase += 1 //add a lemon to purchase
            
            supplies.money -= price.lemon //take price of lemon from money
            
            //update amount of lemons/supplies
            supplies.lemon += 1
            
            updateMainView()
            
        }else{
            showAlertWithText(message: "You don,t have enough money")
            
        }
    }
    
    //Step 1 Purchase supplies such as Lemons and Icecubes
    
    @IBAction func purchaseButtonIceCubePressed(sender: UIButton) { //+ icecube $1
        
        
        if supplies.money >= price.iceCube{
            
            iceCubesToPurchase += 1
            
            supplies.money -= price.iceCube
            
            supplies.iceCubes += 1
            
            updateMainView()
            
        } else{
            showAlertWithText(header: "Error", message: "You don't have enough money")
            
        }
        
        
    }

    @IBAction func unpurchasedButtonLemonPressed(sender: UIButton) { // - lemon $2
   
        if lemonsToPurchase > 0 {
            lemonsToPurchase -= 1 //reduce lemons to purchase by 1
            supplies.money += price.lemon //get our money back
            supplies.lemon -= 1 //reduce supplies of lemon inventory
            updateMainView()
        }else{
            showAlertWithText(message: "You don't have anything to return")
        }
    
    
    }
    
    
    @IBAction func unpurchasedButtonIceCubePressed(sender: UIButton) { //- icecube $1
   
        if iceCubesToPurchase > 0{
            iceCubesToPurchase -= 1
            supplies.money += price.iceCube
            supplies.iceCubes -= 1
            updateMainView()
            
        }else{
            showAlertWithText(message:"You don't have anything to return")
            
        }
    
    
    }
    
    
    @IBAction func mixLemonButtonPressed(sender: UIButton) { // + lemons
    
        if supplies.lemon > 0 {
            
            lemonsToPurchase = 0 //lock mixture so user cannot change purchases
            
            supplies.lemon -= 1
            
            lemonsToMix += 1
            
            updateMainView()
            
        }else{
            showAlertWithText(message: "You don't have enough inventory")
            //if they do not have enough lemon

        }
    
    
    }
    
    
    //Step 2:Mix Lemons
    
    @IBAction func mixIceCubeButtonPressed(sender: UIButton) {//icecube +
        if supplies.iceCubes > 0 {
            iceCubesToPurchase = 0 //reset purchases to 0 so user cannot change supplies
            supplies.iceCubes -= 1 //take out 1 ice cube from supply
            iceCubesToMix += 1 //add 1 icecube to mix
            updateMainView()
            
        } else{
             showAlertWithText(message:"You don't have enough inventory")
    }
    
}
    
    
    @IBAction func unmixLemonButtonPressed(sender: UIButton) { //lemons -
   
        if lemonsToMix > 0{
            lemonsToPurchase = 0
            lemonsToMix -= 1
            supplies.lemon += 1
            updateMainView()
        }else{
            
              showAlertWithText(message:"You don't have anything to unmix")
        }
    
    
    }
    
    @IBAction func unmixIceCubeButtonPressed(sender: UIButton) { //icecubes -
        if iceCubesToMix > 0{
            iceCubesToPurchase = 0
            iceCubesToMix -= 1
            supplies.iceCubes += 1
            updateMainView()
        }else{
            showAlertWithText(message:"You don't have anything to unmix")
        }
    
    
    }
    
    
    
    //sttart day button
    @IBAction func startDayButtonPressed(sender: UIButton) {
        
       let customers = Int(arc4random_uniform(UInt32(11))) // //generate 10 customers randomly
        
        println("customers: \(customers)")
        
        if lemonsToMix == 0 || iceCubesToMix == 0{
            showAlertWithText(message: "You need to add 1 lemon and atleast 1 ice cube")
            
        }else {
            
            //if user adds atleast 1 lemonade and 1 ice cube
            let lemonadeRatio = Double (lemonsToMix) / Double(iceCubesToMix)
            
            for x in 0...customers{ // 1 - 10 random customers assign to x
                
                //generete 0 - 100 random
                let preference = Double(arc4random_uniform(UInt32(101))) / 100 // %100 or 1.
                
                if preference < 0.4  && lemonadeRatio > 1 {
                    supplies.money  += 1
                    println("paid")
                    
                }else if preference > 0.6 && lemonadeRatio < 1{
                     supplies.money  += 1
                      println("paid")
                    
                } else if preference <= 0.6 && preference >= 0.4 && lemonadeRatio == 1{
                     supplies.money  += 1
                      println("paid")
                    
                }else{
                    println("else statement evaluating")
                }
                
            }
            
            //clear tracking variables
            lemonsToPurchase = 0
            iceCubesToPurchase = 0
            lemonsToMix = 0
            iceCubesToMix = 0
            
            updateMainView()
            
            
        }
    }
    
    
    //HELPER FUNCTION TO UPDATE VIEW/labels BASED ON SUPPLIES PURCHASED AND MIXTURES USED
    
    func updateMainView()
    {
        //set labels to structs global   var supplies.structs (money or lemons or iceCb)
        
        moneySupplyCount.text = "$\(supplies.money)"
        lemonSupplyCount.text = "\(supplies.lemon) Lemon"
        iceCubeSupplyCount.text = "\(supplies.iceCubes) IceCubes"
        
        //set labels to global variable properties declared in VC.Swift File
        
        lemonPurchaseCount.text = "\(lemonsToPurchase)"
        iceCubePurchaseCount.text = "\(iceCubesToPurchase)"
        
        lemonMixCount.text = "\(lemonsToMix)"
        iceCubeMixCount.text = "\(iceCubesToMix)"
        
    }
    
    
    //HELPER FUNCTION TO ALERT

    func showAlertWithText(header:String = "warning",message:String)
    {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateMainView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

