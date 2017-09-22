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

        textView.text = ""
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

