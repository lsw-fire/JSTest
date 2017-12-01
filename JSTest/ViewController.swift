//
//  ViewController.swift
//  JSTest
//
//  Created by Li Shi Wei on 22/09/2017.
//  Copyright © 2017 Li Shi Wei. All rights reserved.
//

import UIKit
import JavaScriptCore
import core

class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    let jsContext = JSContext()
    
    let dateFormatter = DateFormatter()
   
    @IBOutlet weak var hexagramPartView: HexagramPartView!
    
    @IBOutlet weak var testFrameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        // Do any additional setup after loading the view, typically from a nib.
        let path = Bundle.main.path(forResource: "Calendar", ofType: "js")
        let contentData = FileManager.default.contents(atPath: path!)
        let content = String(data: contentData!, encoding: String.Encoding.utf8)
        
        jsContext?.evaluateScript(content)
        
        let script = "paiYue(2017)"
        
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
        
      
        
        var listJie = Array<(String,String)?>()
        var listQi = Array<(String,String)?>()
        var listLunar = Array<(String,String)?>()
        
        for a in array! {
            
            if !a.isEmpty {
                let part1 = a.components(separatedBy: "/2")[0]
                let part1Array = part1.components(separatedBy: "/1")
                let s1 = part1Array[0]
                let s2 = part1Array[1]
                let s3 = a.components(separatedBy: "/2")[1]
                
                let jie = buildSolarTerm(str: s1)
                let qi = buildSolarTerm(str: s2)
                let lunar = buildSolarTerm(str: s3)
                
                listJie.append(jie)
                listQi.append(qi)
                listLunar.append(lunar)
            }
            
            //doAnimation()
            doAnimationExt()
        }
        
        let hexagram = HexagramBuilder.createHexagramBy(dateTime: Date())
        
        //let date20168170130 = Date(year: 2016, month: 8, day: 17, hour: 13, min: 30, second: 00)
        //let tHexagram = HexagramBuilder.createHexagramBy(dateTime: date20168170130)
        print(hexagram?.0.defaultValue.name,hexagram?.1.defaultValue.name)
        textView.text =  result?.toString()
    
        let birthdayHexagram = Date(year: 1955, month: 8, day: 20, hour: 6, min: 05, second: 00)
        let h = HexagramBuilder.createHexagramBy(dateTime: birthdayHexagram, isBirthday: true)
        
        print(h?.0.defaultValue.name,h?.1.defaultValue.name)
        
        hexagramPartView.hexagramName = "蛊"
        
        let rect = CGRect(x: 0, y: 0, width: 200, height: 100)
        let testH = HexagramPartView(frame: rect)
        self.view.addSubview(testH)
        
        //self.testFrameView.setNeedsLayout()
        //self.testFrameView.layoutIfNeeded()
    }
    
    func buildSolarTerm(str:String) -> (String,String)? {
        if let range = str.range(of: " ") {
            //let startPos = s1.distance(from: s1.startIndex, to: range.lowerBound)
            //let endPos = s1.distance(from: s1.startIndex, to: range.upperBound)
            //print(startPos, endPos)

            let name = str.substring(to: range.lowerBound)
            let dateStr = str.substring(from: range.upperBound)
            //let date = dateFormatter.date(from: dateStr)
            
            //print(dateFormatter.string(from: date!))
            print(name)
            
            return(name,dateStr)
        }
        return nil
    }
            //print(da

    //    func handleJavaScriptArray(value:JSValue) -> Void {
    //        guard let array: [String] = value.toArray() else {
    //            print("error")
    //        }
    //
    //
    //    }
    
    override func viewDidLayoutSubviews() {
        //DispatchQueue.main.async {
            //print(self.view.frame)
        
       
        print(self.testFrameView.frame)
        //}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AppUtility.lockOrientation(.portrait)
        // Or to rotate and lock
         //AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    
    var imgAngle = 0
    func doAnimation() {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.duration = 5
        animation.isAdditive = true
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.fromValue = NSNumber(value: imgAngle.degreesToRadians)
        animation.toValue = NSNumber(value: (imgAngle + 90).degreesToRadians)
        self.hexagramPartView.layer.add(animation, forKey: "90rotation")
        
        imgAngle += 90
        if imgAngle > 270 {
            imgAngle = 0
        }
    }
    
    func doAnimationExt() {
        let zRotationKeyPath = "transform.rotation.z"
        //let currentAngle = self.hexagramPartView.layer.value(forKeyPath: zRotationKeyPath) as! CGFloat
        let angleToAdd = CGFloat(Double.pi * 2)
        //self.hexagramPartView.layer.setValue((currentAngle + angleToAdd), forKey: zRotationKeyPath)
        
        let animation = CABasicAnimation(keyPath: zRotationKeyPath)
        animation.duration = 5
        animation.toValue = 0
        animation.byValue = angleToAdd
        
        self.hexagramPartView.layer.add(animation, forKey: "90rotation")
        
        
    }
}

extension BinaryInteger {
    var degreesToRadians: Float { return Float(Int(self)) * .pi / 180 }
}

extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
