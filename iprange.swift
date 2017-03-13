//
//  iprange.swift
//  assignment3
//
//  Created by Mehta, Khushali on 3/29/16.
//  Copyright © 2016 Mehta, Khushali. All rights reserved.
//

import Foundation

class iprange
{
    var ip1: UInt8
    var ip2: UInt8
    var ip3: UInt8
    var ip4: UInt8
    var netmask: Int
    
// initialization
    init()
    {
        ip1 = 0
        ip2 = 0
        ip3 = 0
        ip4 = 0
        netmask = 0
    }
    // calculation for first ip and last ip
    func perform(ip1:UInt8,_ ip2:UInt8,_ ip3:UInt8,_ ip4:UInt8,_ netmask:Int) -> (rangear:[String],from:String,to:String,subnetmask:String)
    {
        let max = 32
        var disp = [String]()
        

        let subnet_0 = String(count: netmask , repeatedValue: Character("1"))
        
        let subnet_1 = String(count:(max - netmask), repeatedValue: Character("0"))
        
        let subnet = subnet_0 + subnet_1
        
        
        let sub1 = subnet.substringWithRange(Range(start: subnet.startIndex, end: subnet.startIndex.advancedBy(8)))
        let sub2 = subnet.substringWithRange(Range(start: subnet.startIndex.advancedBy(8), end: subnet.startIndex.advancedBy(16)))
        let sub3 = subnet.substringWithRange(Range(start: subnet.startIndex.advancedBy(16), end: subnet.startIndex.advancedBy(24)))
        let sub4 = subnet.substringWithRange(Range(start: subnet.startIndex.advancedBy(24), end: subnet.startIndex.advancedBy(32)))
        
        let a1 = UInt8(strtoul(sub1,nil,2))
        let a2 = UInt8(strtoul(sub2,nil,2))
        let a3 = UInt8(strtoul(sub3,nil,2))
        let a4 = UInt8(strtoul(sub4,nil,2))
        //print("\(a1).\(a2).\(a3).\(a4)")
        
        let firstip1 = ip1 & a1
        let firstip2 = ip2 & a2
        let firstip3 = ip3 & a3
        var firstip4 = ip4 & a4
        
        let lastip1 = ip1 | ~a1
        let lastip2 = ip2 | ~a2
        let lastip3 = ip3 | ~a3
        var lastip4 = ip4 | ~a4
        
        if netmask != 32
        {
            if firstip4 == 0
            {
                firstip4 = UInt8(1)
            }
            if lastip4 == 255
            {
                lastip4 = UInt8(254)
            }

        }

        

        
        let first_ip = "\(firstip1).\(firstip2).\(firstip3).\(firstip4)"
        print("first ip \(first_ip)")
        let last_ip = "\(lastip1).\(lastip2).\(lastip3).\(lastip4)"
        print("last ip \(last_ip)")
        let subnetmask = "\(a1).\(a2).\(a3).\(a4)"
        print("Subnet Mask \(subnetmask)")
        
       
        let part1 = Int(firstip1)
        let part2 = Int(firstip2)
        let part3 = Int(firstip3)
        let part4 = Int(firstip4)
        
        
        
        let part2_1 = Int(lastip1)
        let part2_2 = Int(lastip2)
        let part2_3 = Int(lastip3)
        let part2_4 = Int(lastip4)
        
        // appending ip address in the range to an array
        var ipaddr = ""
        for var i = part1; i <= part2_1 ; i++
        {
            for var j = part2; j <= part2_2 ; j++
            {
                for var k = part3; k <= part2_3; k++
                {
                    for var l = part4; l <= part2_4; l++
                    {
                        ipaddr = "\(i).\(j).\(k).\(l)"
                        disp.append(ipaddr)
                    }
                }
            }
        }
        

    return (disp,first_ip,last_ip,subnetmask)
    
    }
   }
