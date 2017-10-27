//
//  ViewController.swift
//  JSTest
//
//  Created by Li Shi Wei on 22/09/2017.
//  Copyright © 2017 Li Shi Wei. All rights reserved.
//

import UIKit
import JavaScriptCore

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    let jsContext = JSContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "Calendar", ofType: "js")
        let contentData = FileManager.default.contents(atPath: path!)
        let content = String(data: contentData!, encoding: String.Encoding.utf8)
        
        jsContext?.evaluateScript(content)
        
        let script = "paiYue(2000)"
        
        let result = jsContext?.evaluateScript(script);
        
        let array = result?.toString().components(separatedBy: "|")
        
        let concurrentQueue = DispatchQueue(label: "lsw.identifier.c", attributes: .concurrent)
        
        for counter in 0 ..< 100{
            concurrentQueue.async {
                //let uuid = Identifier.sharedInstance.UUID
                //print("uuid: \(counter) \(#file) \(uuid)")
                print("uuid: \(counter) \(#file)")
            }
        }
        
        var list = Array<String>()
        
        for a in array! {
            
            if !a.isEmpty {
                let part1 = a.components(separatedBy: "/2")[0]
                let part1Array = part1.components(separatedBy: "/1")
                let s1 = part1Array[0]
                let s2 = part1Array[1]
                let s3 = a.components(separatedBy: "/2")[1]
                
                list.append(s1)
                list.append(s2)
                list.append(s3)
            }
            
        }
        
        textView.text =  result?.toString()
    }
    
    //    func handleJavaScriptArray(value:JSValue) -> Void {
    //        guard let array: [String] = value.toArray() else {
    //            print("error")
    //        }
    //
    //
    //    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

