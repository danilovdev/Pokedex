//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Alexey Danilov on 04/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UITableViewController {
    
    var pokemon: Pokemon!
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var name: UILabel!
    
    @IBOutlet var type: UILabel!
    
    @IBOutlet var summary: UILabel!
    
    @IBOutlet var evolution: UILabel!
    
    @IBOutlet var toggleFavourites: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.pokemon.name
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        let readMore = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(readMoreTapped))
        self.navigationItem.rightBarButtonItems = [share, readMore]
        
        
        self.imageView.image = UIImage(named: self.pokemon.name)
        self.name.text = self.pokemon.name.uppercased()
        self.type.text = self.pokemon.type
        self.summary.text = self.pokemon.summary
        if self.pokemon.evolutions.count > 0 {
            self.evolution.text = "\(self.pokemon.name) > " + self.pokemon.evolutions.joined(separator: " > ")
        } else {
            self.evolution.text = self.pokemon.name
        }
        
        self.setFavouritesLabel()
    }
    
    @objc func shareTapped() {
        let items: [Any] = [self.pokemon.summary, self.imageView.image!]
        let vc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(vc, animated: true)
    }
    
    @objc func readMoreTapped() {
        if let url = URL(string: "http://pokemondb.net/pokedex/\(self.pokemon.name)") {
            let vc = SFSafariViewController(url: url)
            self.present(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return UITableViewAutomaticDimension
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    func setFavouritesLabel() {
        let ud = UserDefaults.standard
        let favourites = ud.object(forKey: "Favourites") as? [String] ?? [String]()
        if favourites.contains(self.pokemon.name) {
            self.toggleFavourites.text = "Remove from favourites"
        } else {
            self.toggleFavourites.text = "Add to favourites"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row == 5 else { return }
        
          tableView.deselectRow(at: indexPath, animated: true)
        
        let defaults = UserDefaults.standard
        var favourites = defaults.object(forKey: "Favourites") as? [String] ?? [String]()
        
        if let index = favourites.index(of: self.pokemon.name) {
            favourites.remove(at: index)
        } else {
            favourites.append(self.pokemon.name)
        }
        
        defaults.set(favourites, forKey: "Favourites")
        self.setFavouritesLabel()
    }

}
