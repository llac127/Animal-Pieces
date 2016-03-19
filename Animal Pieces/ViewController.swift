//
//  ViewController.swift
//  Animal Pieces
//
//  Created by Long Lac on 3/18/16.
//  Copyright © 2016 Tinyapps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var StartMario: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "PlayVC"
        {
            if let playVC = segue.destinationViewController as? PlayVC
            {

                playVC.toPlay = "MarioX"

            }
        }
    }

}

