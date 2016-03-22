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
    var animal: Animal!
    
    @IBOutlet weak var nameLbl: UILabel!
    //@IBOutlet weak var marioImage: UIImageView!
    
    var lastRotation = CGFloat()
    var marioImage = UIImageView()
    var imageView = UIImageView()
    
    let pinchRec = UIPinchGestureRecognizer()
    let rotateRec = UIRotationGestureRecognizer()
    let panRec = UIPanGestureRecognizer()
    let marioRec = UIPanGestureRecognizer()
    let yoshiPinch = UIPinchGestureRecognizer()
    let rotateYoshi = UIRotationGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        nameLbl.text = animal.printname()
        
        pinchRec.addTarget(self, action: "scaleImage:")
        rotateRec.addTarget(self, action: "rotatedView:")
        panRec.addTarget(self, action: "handlePan:")
        marioRec.addTarget(self, action: "handlePan:")
        yoshiPinch.addTarget(self, action: "scaleImage:")
        rotateYoshi.addTarget(self, action: "rotatedView:")
        
        marioImage.image = UIImage(named: "mario")
        marioImage.userInteractionEnabled = true
        marioImage.multipleTouchEnabled = true

        marioImage.frame = CGRect(x: 150, y: 150, width: 193, height: 261)
        view.addSubview(marioImage)
        
        marioImage.addGestureRecognizer(pinchRec)
        marioImage.addGestureRecognizer(rotateRec)
        marioImage.addGestureRecognizer(marioRec)
        
        
        imageView.image = UIImage(named: "Yoshi")
        imageView.userInteractionEnabled = true
        imageView.multipleTouchEnabled = true
        
        imageView.frame = CGRect(x: 0, y: 0, width: 125, height: 182)
        view.addSubview(imageView)
        
        imageView.addGestureRecognizer(panRec)
        imageView.addGestureRecognizer(rotateYoshi)
        imageView.addGestureRecognizer(yoshiPinch)

    }
    
    
    @IBAction func backPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    @IBAction func scaleImage(sender: UIPinchGestureRecognizer) {
        //self.view.bringSubviewToFront(sender)
        sender.view!.transform = CGAffineTransformScale(sender.view!.transform, sender.scale, sender.scale)
        sender.scale = 1.0
    }
    
    func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }

    func rotatedView(sender:UIRotationGestureRecognizer)
    {
        var lastRotation = CGFloat()
        //self.view.bringSubviewToFront(marioImage)
        if(sender.state == UIGestureRecognizerState.Ended){
            lastRotation = 0.0;
        }
        let rotation = 0.0 - (lastRotation - sender.rotation)
        rotateRec.locationInView(sender.view)
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