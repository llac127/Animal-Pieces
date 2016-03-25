//
//  Animal.swift
//  Animal Pieces
//
//  Created by Long Lac on 3/20/16.
//  Copyright © 2016 Tinyapps. All rights reserved.
//

import Foundation
import UIKit

class Animal
{
    private var name: String!
    private var body: String!
    
    private var parts: [String]?
    
    
    init(name: String, body: String )
    {
        self.name = name
        self.body = body
    }
    
    func addParts(parts: [String])
    {
        self.parts = parts

    }
    
    func printname() -> String
    {
        return self.name
    }
    
    var printBody: String
    {
        return body
    }
    
}