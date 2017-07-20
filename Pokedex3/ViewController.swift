//
//  ViewController.swift
//  Pokedex3
//
//  Created by Brian Marquis on 7/19/17.
//  Copyright © 2017 brimarq. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDelegate, UICollectionViewDataSource and UICollectionViewDelegateFlowLayout protocols added here: this class will be the delegate, hold the data for, and set & modify the layout for the collection view.
    
    // Connect the collection view to the view controller (after creating this line, switch to the storyboard, right-click on the View Controller in the tree display and click-drag collection to the CollectionView on the storyboard).
    @IBOutlet weak var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign the delegate and data source to self
        collection.dataSource = self
        collection.delegate = self
        
    }
    
    // This memory-friendly func sets-up and dequeues the cells on screen dynamically instead of loading all of the cells at once
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            // Get the cell images dynamically by pokedexID
            let pokemon = Pokemon(name: "Pokemon", pokedexID: indexPath.row)
            cell.configureCell(pokemon: pokemon) // calls the function created in PokeCell.swift
            
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    // This func will execute when a cell is tapped.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    // This func sets the number of items/objects in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    // This func sets the number of sections in the collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // This func sets the size of the cells in the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
}


