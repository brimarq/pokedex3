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
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name
    }
    
    @IBAction func backBtnPressed(_ sender: UIButton) {
        // Dismiss this VC when back button is pressed to return to prev VC.
        dismiss(animated: true, completion: nil)
    }
    

}
