//
//  PokemonDetailVC.swift
//  Pokedex3
//
//  Created by Brian Marquis on 7/21/17.
//  Copyright © 2017 brimarq. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    // var to receive data from poke in ViewController
    var pokemon: Pokemon!

    @IBOutlet weak var nameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
    }

}
