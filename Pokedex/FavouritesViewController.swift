//
//  FavouritesViewController.swift
//  Pokedex
//
//  Created by Alexey Danilov on 07/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import Foundation
import UIKit

class FavouritesViewController: UICollectionViewController {
    
    var favourites = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Favourites"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let savedFavourites = defaults.object(forKey: "Favourites") as? [String] ?? [String]()
        
        if (savedFavourites != self.favourites) {
            self.favourites = savedFavourites
            self.collectionView?.reloadData()
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.favourites.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let pokemon = self.favourites[indexPath.row]
        
        if let imageView = cell.viewWithTag(1024) as? UIImageView {
            imageView.image = UIImage(named: pokemon)
        }
        
        return cell
    }
}
