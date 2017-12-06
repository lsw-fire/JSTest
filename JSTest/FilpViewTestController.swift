//
//  FilpViewTestController.swift
//  JSTest
//
//  Created by Li Shi Wei on 06/12/2017.
//  Copyright © 2017 Li Shi Wei. All rights reserved.
//

import UIKit

class FilpViewTestController: UIViewController {

    
    @IBOutlet weak var flipView: FlipView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //DispatchQueue.main.async {
            self.flipView.isUserInteractionEnabled = true
            self.flipView.imageViewFlip.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.filpViewAnimate(recognizer:)))
            self.flipView.addGestureRecognizer(tap)
        //}
        
       

    }

    
    func filpViewAnimate(recognizer: UITapGestureRecognizer) {
        let tag = flipView.imageViewFlip.tag == 0 ? 1 : 0
        flipView.filpImageAnimation(tag: tag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
