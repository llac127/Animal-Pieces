//
//  ViewController.swift
//  Animal Pieces
//
//  Created by Long Lac on 3/18/16.
//  Copyright © 2016 Tinyapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cat = Animal(name: "CAT", body: "cat_body")
    let dog = Animal(name: "DOG", body: "dog_body")

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    let dogpart = ["dog_tail", "dog_left_ear", "dog_right_ear", "dog_mouth", "dog_eyes", "dog_nose", "dog_tongue", "dog_hair" ]
       dog.addParts(dogpart)
    let catpart = ["cat_left_ear", "cat_right_ear", "cat_tail", "cat_mouth", "cat_eyes", "cat_nose", "cat_whiskers"]
        cat.addParts(catpart)
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

