//
//  PlayVC.swift
//  Animal Pieces
//
//  Created by Long Lac on 3/18/16.
//  Copyright © 2016 Tinyapps. All rights reserved.
//

import UIKit

class PlayVC: UIViewController
{
    
    var toPlay: String!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var marioImage: UIImageView!
    
    var lastRotation = CGFloat()
    
    let pinchRec = UIPinchGestureRecognizer()
    let rotateRec = UIRotationGestureRecognizer()
    let panRec = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        nameLbl.text = toPlay
        
        pinchRec.addTarget(self, action: "scaleImage:")
        rotateRec.addTarget(self, action: "rotatedView:")
        panRec.addTarget(self, action: "draggedView:")
        
        marioImage.addGestureRecognizer(pinchRec)
        marioImage.addGestureRecognizer(rotateRec)
        marioImage.addGestureRecognizer(panRec)

    }
    
    
    @IBAction func backPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    @IBAction func scaleImage(sender: UIPinchGestureRecognizer) {
        self.view.bringSubviewToFront(marioImage)
        sender.view!.transform = CGAffineTransformScale(sender.view!.transform, sender.scale, sender.scale)
        sender.scale = 1.0
    }

    func rotatedView(sender:UIRotationGestureRecognizer)
    {
        var lastRotation = CGFloat()
        self.view.bringSubviewToFront(marioImage)
        if(sender.state == UIGestureRecognizerState.Ended){
            lastRotation = 0.0;
        }
        let rotation = 0.0 - (lastRotation - sender.rotation)
        rotateRec.locationInView(marioImage)
        let currentTrans = sender.view!.transform
        let newTrans = CGAffineTransformRotate(currentTrans, rotation)
        sender.view!.transform = newTrans
        lastRotation = sender.rotation
    }
    
    
    func draggedView(sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(sender.view!)
        let translation = sender.translationInView(self.view)
        sender.view!.center = CGPointMake(sender.view!.center.x + translation.x, sender.view!.center.y + translation.y)
        sender.setTranslation(CGPointZero, inView: self.view)
    }
    



}