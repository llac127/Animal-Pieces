//
//  ViewController.swift
//  Animal Pieces
//
//  Created by Long Lac on 3/18/16.
//  Copyright © 2016 Tinyapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    
    @IBOutlet weak var collection: UICollectionView!
    
    var animal = [Animal]()
    
    let dog = Animal(name: "DOG", body: "dog_body")
    let cat = Animal(name: "CAT", body: "cat_body")
    

    //let screenSize: CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collection.delegate = self
        collection.dataSource = self

        
    let dogpart = ["dog_tail", "dog_left_ear", "dog_right_ear", "dog_mouth", "dog_eyes", "dog_nose", "dog_tongue", "dog_hair" ]
       dog.addParts(dogpart)
    let catpart = ["cat_left_ear", "cat_right_ear", "cat_tail", "cat_mouth", "cat_eyes", "cat_nose", "cat_whiskers"]
        cat.addParts(catpart)
        
        //print(screenSize)
        
        animal.append(dog)
        animal.append(cat)
        
        
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animal.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let ani: Animal!
        

            ani = animal[indexPath.row]
        //print("Starting new VC")
        performSegueWithIdentifier("PlayVC", sender: ani)
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier( "AnimalCell", forIndexPath: indexPath) as? AnimalCell
        {
            
            let ani: Animal!

            ani = animal[indexPath.row]
            cell.configureCell(ani)
            return cell
        }
        else
        {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @IBAction func catPressed(sender: UIButton) {
        self.performSegueWithIdentifier("PlayVC", sender: cat)
    }
    @IBAction func dogPressed(sender: UIButton) {
        self.performSegueWithIdentifier("PlayVC", sender: dog)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "PlayVC"
        {
            if let playVC = segue.destinationViewController as? PlayVC
            {
                //playVC.toPlay = mario.printname()
                if let ani = sender as? Animal
                {
                    playVC.animal = ani 
                }
            }
        }
    }

}

