//
//  ViewController.swift
//  Pokedex3
//
//  Created by Brian Marquis on 7/19/17.
//  Copyright © 2017 brimarq. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewDelegate, UICollectionViewDataSource and UICollectionViewDelegateFlowLayout protocols added here: this class will be the delegate, hold the data for, and set & modify the layout for the collection view.
    
    // Connect the collection view to the view controller (after creating this line, switch to the storyboard, right-click on the View Controller in the tree display and click-drag collection to the CollectionView on the storyboard).
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Assign the delegate and data source to self
        collection.dataSource = self
        collection.delegate = self
        
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
            print(rows) // check in console to make sure this is working.
            
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
            //
            let poke = pokemon[indexPath.row]
            cell.configureCell(poke) // calls the function created in PokeCell.swift
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
    
    
}


