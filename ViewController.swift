//
//  ViewController.swift
//  assignment3
//
//  Created by Mehta, Khushali on 3/28/16.
//  Copyright © 2016 Mehta, Khushali. All rights reserved.
//

import UIKit

class ViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
    var ipRange = iprange()
    @IBOutlet weak var iptext: UITextField!
    
    @IBOutlet weak var netbits: UITextField!
    
    @IBOutlet weak var viewallip: UITableView!
    
    var disp = [String]()
    
    @IBAction func calculate(sender: UIButton) {
        calculate()
        viewallip.reloadData()
        
       }
    
    
    
    // validating the ip field and netmask bits
    func calculate()
    {
        if iptext != "" && netbits != ""
        {
            
            // let net = String(netbits.text!)
            
            let loc = iptext.text!.componentsSeparatedByString(".")
            let validate = checknetmaskbits(netbits.text!)
            if loc.count == 4 && validate == true
            {
                let ip1 = Int(loc[0])
                let ip2 = Int(loc[1])
                let ip3 = Int(loc[2])
                let ip4 = Int(loc[3])
                let netmask = Int(netbits.text!)!
                if netmask < 16 || netmask > 32 || ip1 < 0 || ip1 > 256 || ip2 < 0 || ip2 > 256 || ip3 < 0 || ip3 > 256 || ip4 < 0 || ip4 > 256
                {
                    let alert = UIAlertView(title: "ERROR", message: "Enter valid information" , delegate: nil, cancelButtonTitle: "Dismiss")
                    alert.show()
                    
                }
                else
                {
                    if netmask == 32
                    {
                        let display = ipRange.perform(UInt8(ip1!), UInt8(ip2!), UInt8(ip3!) , UInt8(ip4!), netmask)
                        let alert = UIAlertView(title: "Range", message: "First IP : \(display.from) \n Last IP: \(display.from) \n Subnet Mask: \(display.subnetmask)", delegate: nil, cancelButtonTitle: "OK")
                        disp = display.rangear
                        alert.show()
                        
                    }
                    else
                    {
                    // diplay first IP, last IP and subnet mask in an alert box
                    let display = ipRange.perform(UInt8(ip1!), UInt8(ip2!), UInt8(ip3!) , UInt8(ip4!), netmask)
                    let alert = UIAlertView(title: "Range", message: "First IP : \(display.from) \n Last IP: \(display.to) \n Subnet Mask: \(display.subnetmask)", delegate: nil, cancelButtonTitle: "OK")
                    disp = display.rangear
                    alert.show()
                    }
                    
                }
            }
            else
            {
                let alert = UIAlertView(title: "ERROR", message: "Enter valid information", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
        }
        else
        {
            let alert = UIAlertView(title: "ERROR", message: "Enter valid information", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }

    }
    // tableview function
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "IP Addresses"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return disp.count
    }
   
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let contactIdentifier = "IPRange"
        let cell = tableView.dequeueReusableCellWithIdentifier(contactIdentifier, forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = self.disp[indexPath.row]
      
        return cell
    }

    override func viewDidLoad() {
        self.viewallip.dataSource = self
        self.viewallip.delegate = self
        self.iptext.delegate = self
        self.netbits.delegate = self
        
        iptext.becomeFirstResponder()
        super.viewDidLoad()
        
    
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        iptext.resignFirstResponder()
        netbits.resignFirstResponder()
        self.view.endEditing(true)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == iptext{
            textField.resignFirstResponder()
        }
        if textField == netbits{
            textField.resignFirstResponder()
        }
        return true
    }
    // Not allowing any punctuation and albhabets except numbers and .
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if (string.characters.count == 0) {
            return true
        }
        let _acceptableCharacters = "0123456789."
        let cs = NSCharacterSet(charactersInString: _acceptableCharacters)
        let filtered = string.componentsSeparatedByCharactersInSet(cs).filter {!$0.isEmpty }
        let str = filtered.joinWithSeparator("")
        
        return (string != str)
    }
    // validation function for netmask bits
    func checknetmaskbits(ipInput: String) -> Bool {
        let ipRegx = "^([0-9][0-9])$"
        let p = NSPredicate(format: "SELF MATCHES %@", ipRegx)
        let res = p.evaluateWithObject(ipInput)
        return res
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

