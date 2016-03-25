//
//  PlayVC.swift
//  Animal Pieces
//
//  Created by Long Lac on 3/18/16.
//  Copyright © 2016 Tinyapps. All rights reserved.
//

import UIKit
import Foundation

class PlayVC: UIViewController
{
    
    var toPlay: String!
    var animal: Animal!
   // var block = [UIView]()
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    struct Letter
    {
        var letter: String
        var letterLbl: UILabel
        let letterPanRecognizer = UIPanGestureRecognizer()
    }
    
    struct BlockSet
    {
        var blockView = UIView()
        var actuallyChar: String!
    }
    
    
    var letters = [Letter]()
    var blockSet = [BlockSet]()
    
    var lastRotation = CGFloat()
    var marioImage = UIImageView()
    var imageView = UIImageView()
    var bodyImage = UIImageView()
    
    
    let pinchRec = UIPinchGestureRecognizer()
    let rotateRec = UIRotationGestureRecognizer()
    let panRec = UIPanGestureRecognizer()
    let marioRec = UIPanGestureRecognizer()
    let yoshiPinch = UIPinchGestureRecognizer()
    let rotateYoshi = UIRotationGestureRecognizer()
    let Apan = UIPanGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addBody()
        addCharacterBlocks()
        
        /*
        aLetter.text = "Test"
        aLetter.font = aLetter.font.fontWithSize(50)
        aLetter.center = CGPointMake(160, 284)
        view.addSubview(aLetter)*/
        
        pinchRec.addTarget(self, action: "scaleImage:")
        rotateRec.addTarget(self, action: "rotatedView:")
        panRec.addTarget(self, action: "handlePan:")
        marioRec.addTarget(self, action: "handlePan:")
        yoshiPinch.addTarget(self, action: "scaleImage:")
        rotateYoshi.addTarget(self, action: "rotatedView:")
        Apan.addTarget(self, action: "handlePan:")
        
        //aLetter.userInteractionEnabled = true
        //aLetter.addGestureRecognizer(Apan)
        
        marioImage.image = UIImage(named: "mario")
        marioImage.userInteractionEnabled = true
        marioImage.multipleTouchEnabled = true

        marioImage.frame = CGRect(x: randomX(), y: randomY(), width: 193, height: 261)
        view.addSubview(marioImage)
        
        marioImage.addGestureRecognizer(pinchRec)
        marioImage.addGestureRecognizer(rotateRec)
        marioImage.addGestureRecognizer(marioRec)
        
        
        imageView.image = UIImage(named: "Yoshi")
        imageView.userInteractionEnabled = true
        imageView.multipleTouchEnabled = true
        
        imageView.frame = CGRect(x: randomX(), y: randomY(), width: 125, height: 182)
        //imageView.frame = CGRect()
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageView.addGestureRecognizer(panRec)
        imageView.addGestureRecognizer(rotateYoshi)
        imageView.addGestureRecognizer(yoshiPinch)
        
        //imageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        //imageView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        
        //let horizontalConstraint = imageView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        //let verticalConstraint = imageView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor)
       // let widthConstraint = imageView.widthAnchor.constraintEqualToAnchor(nil, constant: 100)
       // let heightConstraint = imageView.heightAnchor.constraintEqualToAnchor(nil, constant: 100)
       // NSLayoutConstraint.activateConstraints([horizontalConstraint, verticalConstraint])
        
        /*
        let horizontalConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
        view.addConstraint(horizontalConstraint)
        
        let verticalConstraint = NSLayoutConstraint(item: imageView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
        view.addConstraint(verticalConstraint)
    */
        
        
       // print(screenSize.width)
       // print(screenSize.height)
      
        
    }
    
    func randomX() -> Int
    {
        return Int(arc4random_uniform(UInt32(screenSize.width) - 50))
    }
    func randomY() -> Int
    {
        return Int(arc4random_uniform(UInt32(screenSize.height) - 50))
    }
    
    func addCharacterBlocks()
    {
        let blockwidth = screenSize.width * 0.10
        
        let stackView   = UIStackView()
        stackView.axis  = UILayoutConstraintAxis.Horizontal
        stackView.distribution  = UIStackViewDistribution.EqualSpacing
        stackView.alignment = UIStackViewAlignment.Center
        stackView.spacing   = 30
        
        for i in 0..<animal.printname().characters.count
        {
            
            var tempBlockSet = BlockSet()
            tempBlockSet.blockView.backgroundColor = UIColor.grayColor()
            tempBlockSet.blockView.layer.cornerRadius=3
            tempBlockSet.blockView.layer.borderWidth=2
            tempBlockSet.blockView.heightAnchor.constraintEqualToConstant(blockwidth).active = true
            tempBlockSet.blockView.widthAnchor.constraintEqualToConstant(blockwidth).active = true
            
            let tempname = animal.printname()
            let counter = tempname.startIndex.advancedBy(i)
            tempBlockSet.actuallyChar = String(tempname[counter])
            //print("Setting Block char to: \(tempBlockSet.actuallyChar)")
            
            /*let tempblock = UIView()
            tempblock.backgroundColor=UIColor.grayColor()
            tempblock.layer.cornerRadius=3
            tempblock.layer.borderWidth=2
            tempblock.heightAnchor.constraintEqualToConstant(blockwidth).active = true
            tempblock.widthAnchor.constraintEqualToConstant(blockwidth).active = true*/
            
            blockSet.append(tempBlockSet)
            stackView.addArrangedSubview(tempBlockSet.blockView)
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.view.addSubview(stackView)
        
        //Constraints
        stackView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        //stackView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        let pinTop = NSLayoutConstraint(item: stackView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 100)
        NSLayoutConstraint.activateConstraints([pinTop])
        
        
        var index = 0
        for character in animal.printname().characters
        {
            //print(character)

            
            let tempLabel = UILabel(frame: CGRectMake(CGFloat(randomX()), CGFloat(randomY()), 100, 100))
            
            tempLabel.text = String(character)
            tempLabel.font = tempLabel.font.fontWithSize(50)
            view.addSubview(tempLabel)
            let tempLetter = Letter(letter: String(character), letterLbl: tempLabel)
            
            tempLetter.letterLbl.userInteractionEnabled = true
            tempLetter.letterLbl.addGestureRecognizer(tempLetter.letterPanRecognizer)
            tempLetter.letterPanRecognizer.addTarget(self, action: "panLetter:")
            letters.append(tempLetter)
            
            index += 1
        }


    }
    
    
    func addBody()
    {
        //print(animal.printBody)
        bodyImage.image = UIImage(named: animal.printBody )
        bodyImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bodyImage)
        bodyImage.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        bodyImage.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        bodyImage.contentMode = UIViewContentMode.ScaleAspectFit
        let horizonalContraints = NSLayoutConstraint(item: bodyImage , attribute: .LeadingMargin, relatedBy: .Equal, toItem: view, attribute: .LeadingMargin, multiplier: 1.0, constant: 40)
        let horizonal2Contraints = NSLayoutConstraint(item: bodyImage, attribute: .TrailingMargin, relatedBy: .Equal, toItem: view,  attribute: .TrailingMargin, multiplier: 1.0, constant: -40)
        let pinTop = NSLayoutConstraint(item: bodyImage, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 100)
        NSLayoutConstraint.activateConstraints([horizonalContraints, horizonal2Contraints, pinTop])
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
    
    func panLetter(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
        //print("Checking for Match")

            
        if recognizer.state == .Ended
        {
            //print("Ended")
            //print(recognizer.view)
            let endedPoint = recognizer.locationInView(self.view)
            //print("Ended Point: \(endedPoint)")
            
            let temp: UILabel = (recognizer.view as? UILabel)!
            //print("Grabbing Text: \(temp.text!)")
            
            for testblock in blockSet
            {
                let tempframe = testblock.blockView.superview?.convertRect(testblock.blockView.frame, toView: nil )
                //print("Blocks arrays: \(testblock.blockView.frame)")
                //print("Blocks arrays: \(tempframe)")
                //aView.superview?.convertPoint(aView.frame.origin, toView: nil)
                if CGRectContainsPoint(tempframe!, endedPoint)
                {
                    if temp.text == testblock.actuallyChar
                    {
                        //print("Correct Match!")
                        temp.userInteractionEnabled = false
                        temp.translatesAutoresizingMaskIntoConstraints = false;
                        //bodyImage.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
                        //bodyImage.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
                        temp.centerXAnchor.constraintEqualToAnchor(testblock.blockView.centerXAnchor).active = true
                        temp.centerYAnchor.constraintEqualToAnchor(testblock.blockView.centerYAnchor).active = true
                    }
                }
            }


            
        }
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