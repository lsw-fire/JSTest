//
//  FlipView.swift
//  JSTest
//
//  Created by Li Shi Wei on 06/12/2017.
//  Copyright © 2017 Li Shi Wei. All rights reserved.
//

import UIKit

class FlipView: UIView {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        self.filpImageAnimation(tag: 0)
        
        self.imageViewFlip.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
         self.imageViewFlip.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
         self.imageViewFlip.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
         self.imageViewFlip.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    func createImageView(imageName:String, tag:Int) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.tag = tag
        return imageView
    }
    
    var imageViewFlip : UIImageView!
    
    func filpImageAnimation(tag: Int) {
        
        let transitionOptions = UIViewAnimationOptions.transitionFlipFromLeft
        
        UIView.transition(with: self, duration: 0.5, options: transitionOptions, animations: {
            
            if let v = self.imageViewFlip{
                v.removeFromSuperview()
            }
            if tag == 0 {
                self.imageViewFlip = self.createImageView(imageName: "yi-word", tag: 0)
            }else{
                self.imageViewFlip = self.createImageView(imageName: "yi-dragon", tag: 1)
            }
            self.addSubview(self.imageViewFlip)
            
            self.imageViewFlip.translatesAutoresizingMaskIntoConstraints = false
            self.imageViewFlip.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            self.imageViewFlip.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            self.imageViewFlip.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            self.imageViewFlip.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            
            }, completion: {finished in print(finished)})
    }
    
}
