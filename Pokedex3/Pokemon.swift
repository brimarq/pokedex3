//
//  Pokemon.swift
//  Pokedex3
//
//  Created by Brian Marquis on 7/19/17.
//  Copyright © 2017 brimarq. All rights reserved.
//

import Foundation

// Class that stores all of the info for each pokemon
class Pokemon {
    
    // properties
    private var _name: String!
    private var _pokedexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
    // getters
    var name: String {
        return _name
    }
    
    var pokedexID: Int {
        return _pokedexID
    }
    
    // Init each pokemon object
    init(name: String, pokedexID: Int) {
        
        // setters
        self._name = name
        self._pokedexID = pokedexID
    }
}
