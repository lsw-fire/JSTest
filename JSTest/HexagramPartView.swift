//
//  HexagramPartView.swift
//  JSTest
//
//  Created by Li Shi Wei on 07/11/2017.
//  Copyright © 2017 Li Shi Wei. All rights reserved.
//

import UIKit
import core

class HexagramPartView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    var hexagramName:String?{
        didSet{
            let defaultHexagram = defaultHexagramList.first {
                model in
                return model.name == hexagramName
            }
            
            if let h = defaultHexagram{
                lbHexagramName?.text = h.name

                let lowerLines : [EnumLineType] = h.lowerPart.lines.reversed()
                for i in 3...5{
                    let lType = lowerLines[i - 3]
                    arrayView[i].image = getImageBy(lineType: lType)
                }
                let upperLines : [EnumLineType] = h.upperPart.lines.reversed()
                for i in 0...2{
                    let lType = upperLines[i]
                    arrayView[i].image = getImageBy(lineType: lType)
                }
            }
        }
    }
    
    func getImageBy(lineType: EnumLineType) -> UIImage? {
        var img : UIImage? = UIImage(named:"laoyin.png")
        switch lineType {
        case .LaoYang:
            img = img?.maskWithColor(color: UIColor.black)
            break
        case .LaoYin:
            img = img?.maskWithColor(color: UIColor.gray)
            break
        case .Yang:
            img = img?.maskWithColor(color: UIColor.red)
            break
        case .Yin:
            img = img?.maskWithColor(color: UIColor.green)
            break
        }
        return img
    }
    
    func setup() {
        
        let leftPart = setupLeftPart()
        let rightPart = setupRightPart()
        
        let viewArray = [leftPart,rightPart]
        
        let sv = UIStackView(arrangedSubviews: viewArray)
        sv.alignment = UIStackViewAlignment.fill
        sv.distribution = UIStackViewDistribution.fill
        sv.axis = UILayoutConstraintAxis.horizontal
        //sv.spacing = CGFloat(10)
        
        sv.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sv)
        
        leftPart.translatesAutoresizingMaskIntoConstraints = false
        rightPart.translatesAutoresizingMaskIntoConstraints = false
        rightPart.widthAnchor.constraint(equalTo: leftPart.widthAnchor, multiplier: 2).isActive = true
        
        self.topAnchor.constraint(equalTo: sv.topAnchor, constant: -5).isActive = true
        self.bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: 5).isActive = true
        self.leftAnchor.constraint(equalTo: sv.leftAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: sv.rightAnchor).isActive = true
        
        //self.backgroundColor = UIColor.lightGray
    }
    
    fileprivate var lbHexagramName: UILabel?
    fileprivate var lbTitleName: UILabel?
    func setupLeftPart() -> UIStackView {
        
        lbHexagramName = UILabel()
        if let lb = lbHexagramName{
            lb.text = ""
            lb.font = UIFont.systemFont(ofSize: 25)
            lb.textAlignment = .center
        }
        lbTitleName = UILabel()
        if let tLb = lbTitleName {
            tLb.font = UIFont.systemFont(ofSize:15)
            tLb.numberOfLines = 2
            tLb.text = "主卦"
            tLb.textAlignment = .center
        }
        
        let view = UIStackView(arrangedSubviews: [lbHexagramName!,lbTitleName!])
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .fillEqually
        
       
        
        
        
        
        return view
    }
    
    override func draw(_ rect: CGRect) {
        
        
        
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.beginPath()
        ctx?.move(to: CGPoint(x: (lbHexagramName?.frame.origin.x)!, y: (lbHexagramName?.frame.origin.y)! + (lbHexagramName?.frame.height)!))
        ctx?.addLine(to: CGPoint(x: (lbHexagramName?.frame.origin.x)! + (lbHexagramName?.frame.width)!, y: (lbHexagramName?.frame.origin.y)! + (lbHexagramName?.frame.height)!))
        ctx?.setLineWidth(1)
        ctx?.setStrokeColor(UIColor.red.cgColor)
        ctx?.closePath()
        ctx?.strokePath()
    }
    
    fileprivate var arrayView = Array<UIImageView>()
    func setupRightPart() -> UIStackView{
        for _ in 0...5 {
            let line = UIImageView()
            line.image = UIImage(named:"laoyin.png")
            line.contentMode = .scaleAspectFit
            arrayView.append(line)
        }
        
        let sv = UIStackView(arrangedSubviews: arrayView)
        
        sv.alignment = UIStackViewAlignment.trailing
        sv.distribution = UIStackViewDistribution.fillEqually
        sv.axis = UILayoutConstraintAxis.vertical
        sv.spacing = CGFloat(8)
        
        //sv.centerXAnchor.constraint(equalTo: sv.centerXAnchor).isActive = true
        
        return sv
    }
    
}

extension UIImage {
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
}
