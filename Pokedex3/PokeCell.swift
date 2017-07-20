//
//  PokeCell.swift
//  Pokedex3
//
//  Created by Brian Marquis on 7/19/17.
//  Copyright © 2017 brimarq. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    // Create rounded corners on cells
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Each view has a layer level that can be used to modify its display
        layer.cornerRadius = 5.0
    }
    
    func configureCell(_ pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexID)")
    }
}
