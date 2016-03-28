//
//  AnimalCell.swift
//  Animal Pieces
//
//  Created by Long Lac on 3/27/16.
//  Copyright © 2016 Tinyapps. All rights reserved.
//

import Foundation
import UIKit

class AnimalCell: UICollectionViewCell
{
    @IBOutlet weak var thumbimg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var animal: Animal!
    
    func configureCell(animal: Animal)
    {
        self.animal = animal
        
        nameLbl.text = self.animal.printname()
        thumbimg.image = UIImage(named: self.animal.printname())
        
    }
    
}