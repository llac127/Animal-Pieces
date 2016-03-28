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
    let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)

    var toPlay: String!
    var animal: Animal!
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
        var filled = false
    }
    
    var letters = [Letter]()
    var blockSet = [BlockSet]()
    
    var lastRotation = CGFloat()
    var marioImage = UIImageView()
    var imageView = UIImageView()
    var bodyImage = UIImageView()
    var bodyParts = [UIImageView]()
    
    //let rotateRec = UIRotationGestureRecognizer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImage.image = UIImage(named: "bg1")
        self.view.insertSubview(backgroundImage, atIndex: 0)
        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFill
        
        addBody()
        
        addParts()
        addCharacterBlocks()
      
        print(screenSize)
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
        stackView.distribution  = UIStackViewDistribution.FillEqually
        stackView.alignment = UIStackViewAlignment.Center
        stackView.spacing   = 15
        
        for i in 0..<animal.printname().characters.count
        {
            
            var tempBlockSet = BlockSet()
            tempBlockSet.blockView.backgroundColor = UIColor.greenColor()
            tempBlockSet.blockView.alpha = 0.2
            tempBlockSet.blockView.layer.cornerRadius=3
            tempBlockSet.blockView.layer.borderWidth=1
            tempBlockSet.blockView.heightAnchor.constraintEqualToConstant(blockwidth).active = true
            tempBlockSet.blockView.widthAnchor.constraintEqualToConstant(blockwidth).active = true
            
            let tempname = animal.printname()
            let counter = tempname.startIndex.advancedBy(i)
            tempBlockSet.actuallyChar = String(tempname[counter])
            
            blockSet.append(tempBlockSet)
            stackView.addArrangedSubview(tempBlockSet.blockView)
        }
        
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        
        self.view.addSubview(stackView)
        
        //Constraints
        stackView.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        //stackView.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
        let pinTop = NSLayoutConstraint(item: stackView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: screenSize.height * 0.10)
        NSLayoutConstraint.activateConstraints([pinTop])
        
        
        var index = 0
        for character in animal.printname().characters
        {
            //print(character)

            
            let tempLabel = UILabel(frame: CGRectMake(CGFloat(randomX()), CGFloat(randomY()), 60, 60))
            tempLabel.text = String(character)
            //tempLabel.font = tempLabel.font.fontWithSize(CGFloat(screenSize.width * 0.06))
            //tempLabel.font = UIFont(name: "Chalkboard SE", size: screenSize.width * 0.08)
            let myAttribute = [ NSFontAttributeName: UIFont(name: "GillSans-Bold", size: screenSize.width * 0.08)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
            
            let myString = NSMutableAttributedString(string: String(character), attributes: myAttribute )
            
            myString.addAttribute(NSStrokeColorAttributeName, value: UIColor.blueColor(), range:  NSRange(location: 0, length: 1))
            myString.addAttribute(NSStrokeWidthAttributeName, value: -3, range: NSRange(location: 0, length: 1))
            
            tempLabel.attributedText = myString
            view.addSubview(tempLabel)
            let tempLetter = Letter(letter: String(character), letterLbl: tempLabel)
            
            tempLetter.letterLbl.userInteractionEnabled = true
            tempLetter.letterLbl.addGestureRecognizer(tempLetter.letterPanRecognizer)
            tempLetter.letterPanRecognizer.addTarget(self, action: #selector(PlayVC.panLetter(_:)))
            letters.append(tempLetter)
            
            index += 1
        }


    }
    
    func addParts()
    {
        var partSize = 100
        if screenSize.height == 1024.0
        {
            partSize = 200
        }
        
        var index = 1
        for parts in animal.getParts()
        {
            //print(parts)
            
            if index == 4
            {
                index += 1
                view.bringSubviewToFront(bodyImage)
            }
            
            let tempPart:UIImageView = UIImageView()
            tempPart.image = UIImage(named: parts)
            tempPart.frame = CGRect(x: randomX(), y: randomY(), width: partSize , height: partSize)
            tempPart.contentMode = UIViewContentMode.ScaleAspectFit
            //tempPart.translatesAutoresizingMaskIntoConstraints = false
            //view.addSubview(tempPart)
            //print("index: \(index)")
            view.insertSubview(tempPart, atIndex: index)
            view.bringSubviewToFront(tempPart)
            bodyParts.append(tempPart)
            
            let panParts = UIPanGestureRecognizer()
            let pinchParts = UIPinchGestureRecognizer()
            let rotateParts = UIRotationGestureRecognizer()
            
            panParts.addTarget(self, action: #selector(PlayVC.handlePan(_:)))
            pinchParts.addTarget(self, action: #selector(PlayVC.scaleImage(_:)))
            rotateParts.addTarget(self, action: #selector(PlayVC.rotatedView(_:)))

            
            tempPart.userInteractionEnabled = true
            tempPart.multipleTouchEnabled = true
            
            tempPart.addGestureRecognizer(panParts)
            tempPart.addGestureRecognizer(pinchParts)
            //tempPart.addGestureRecognizer(rotateParts)
            
            index += 1
            
        }
    }
    func addBody()
    {
        //print(animal.printBody)
        let bodyPadding = screenSize.height * 0.10
        
        bodyImage.image = UIImage(named: animal.printBody )
        bodyImage.translatesAutoresizingMaskIntoConstraints = false
    
        view.insertSubview(bodyImage, atIndex: 4)
        bodyImage.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        if screenSize.height != 1024.0
        {
            bodyImage.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
        }
        else
        {
            let verticalContraints = NSLayoutConstraint(item: bodyImage, attribute: .Bottom , relatedBy: .Equal, toItem: view,  attribute: .Bottom, multiplier: 1.0, constant: 100)
             NSLayoutConstraint.activateConstraints([verticalContraints])
        }
        bodyImage.contentMode = UIViewContentMode.ScaleAspectFit
        let horizonalContraints = NSLayoutConstraint(item: bodyImage , attribute: .LeadingMargin, relatedBy: .Equal, toItem: view, attribute: .LeadingMargin, multiplier: 1.0, constant: bodyPadding)
        let horizonal2Contraints = NSLayoutConstraint(item: bodyImage, attribute: .TrailingMargin, relatedBy: .Equal, toItem: view,  attribute: .TrailingMargin, multiplier: 1.0, constant: -bodyPadding)
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
        if let bringtofront: UILabel = (recognizer.view as? UILabel)!
        {
            self.view.bringSubviewToFront(bringtofront)
        }
        
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
            
            var i = 0
            for testblock in blockSet
            {
                let tempframe = testblock.blockView.superview?.convertRect(testblock.blockView.frame, toView: nil )
                //print("Blocks color: \(testblock.blockView.backgroundColor)")
                //print("Filled? : \(testblock.filled)")
                //aView.superview?.convertPoint(aView.frame.origin, toView: nil)
                if CGRectContainsPoint(tempframe!, endedPoint)
                {
                    if temp.text == testblock.actuallyChar && !testblock.filled
                    {
                        //print("Correct Match!")
                        temp.userInteractionEnabled = false
                        temp.translatesAutoresizingMaskIntoConstraints = false;
                        //bodyImage.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
                        //bodyImage.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor).active = true
                        temp.centerXAnchor.constraintEqualToAnchor(testblock.blockView.centerXAnchor).active = true
                        temp.centerYAnchor.constraintEqualToAnchor(testblock.blockView.centerYAnchor).active = true
                        testblock.blockView.backgroundColor = UIColor.yellowColor()
                        testblock.blockView.alpha = 0.9
                        testblock.blockView.layer.borderColor = UIColor(red:0/255.0, green:225/255.0, blue:0/255.0, alpha: 0.5).CGColor
                        blockSet[i].filled = true
                    }
                }
                i += 1
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
        sender.locationInView(sender.view)
        let currentTrans = sender.view!.transform
        let newTrans = CGAffineTransformRotate(currentTrans, rotation)
        sender.view!.transform = newTrans
        lastRotation = sender.rotation
    }
    

}