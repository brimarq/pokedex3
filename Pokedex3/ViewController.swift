//
//  ViewController.swift
//  Pokedex3
//
//  Created by Brian Marquis on 7/19/17.
//  Copyright © 2017 brimarq. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    // UICollectionViewDelegate, UICollectionViewDataSource and UICollectionViewDelegateFlowLayout protocols added here: this class will be the delegate, hold the data for, and set & modify the layout for the collection view.
    
    // Connect the collection view to the view controller
    @IBOutlet weak var collection: UICollectionView!
    // Connect the search bar to the view controller
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign the dataSource and delegates to self
        collection.dataSource = self
        collection.delegate = self
        searchBar.delegate = self
        
        // Change the text of the keyboard return key to "Done" for the searchBar function.
        searchBar.returnKeyType = UIReturnKeyType.done
        
        parsePokemonCSV()
        initAudio()
        
    }
    
    // Ready audio and setup music player
    func initAudio() {
        
        // Set path to the music file
        let path = Bundle.main.path(forResource: "music", ofType: "mp3")!
        
        // Create an AudioPlayer - use do-catch, since it can throw an error.
        do {
            musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func parsePokemonCSV() {
        
        // Set the path to the pokemon.csv file
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")! // Ok to force-unwrap this, because we know the file exists.
        
        // Since the parser can throw an error, use a do-catch statement
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            //print(rows) // check in console to make sure this is working.
            
            // Grab the data from each csv row
            for row in rows {
                let pokeID = Int(row["id"]!)!
                let name = row["identifier"]!
                
                // create a pokemon object, "poke", for each of those
                let poke = Pokemon(name: name, pokedexID: pokeID)
                
                // attatch each poke to the pokemon array above
                pokemon.append(poke)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    // This memory-friendly func sets-up and dequeues the cells on screen dynamically instead of loading all of the cells at once
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if inSearchMode {
                
                // In searchMode, use the filtered pokemon list
                poke = filteredPokemon[indexPath.row]
                cell.configureCell(poke) // calls the function created in PokeCell.swift
                
            } else {
                
                // When not in searchMode, use the unfiltered pokemon list
                poke = pokemon[indexPath.row]
                cell.configureCell(poke) // calls the function created in PokeCell.swift
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    // This func will execute when a cell is tapped.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke: Pokemon!
        
        // Account for the search mode option
        if inSearchMode {
            poke = filteredPokemon[indexPath.row]
        } else {
            poke = pokemon[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
    }
    
    // This func sets the number of items/objects in the collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
            return filteredPokemon.count
        }
        return pokemon.count
    }
    
    // This func sets the number of sections in the collection view
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // This func sets the size of the cells in the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    // Music play/pause button
    @IBAction func musicBtnPressed(_ sender: UIButton) {
        
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.4
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }
    
    // Removes keyboard when the search button is tapped.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        // When not in search mode (nothing in, or all text removed from searchBar)
        if searchBar.text == nil || searchBar.text == "" {
            
            inSearchMode = false
            
            // Repopulate the collection view with the original list
            collection.reloadData()
            
            // Remove keyboard when nothing is in the search bar
            view.endEditing(true)
            
        } else {
            
            inSearchMode = true
            
            // Put content of searchBar entry as lowercased text into constant "lower"
            let lower = searchBar.text!.lowercased()
            
            // Create a filtered pokemon list from the original pokemon list based on whether the entered search bar text is included within the range of the original names. The $0 is a placeholder for each item in the array.
            filteredPokemon = pokemon.filter({$0.name.range(of: lower) != nil})
            
            // Repopulate the collection view with the filtered results
            collection.reloadData()
        }
    }
    
    // Prepare the data to be sent via the segue before it occurs
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon {
                    
                    // Set the pokemon var in the destination VC to the contents of poke var from this VC.
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    
    
}


