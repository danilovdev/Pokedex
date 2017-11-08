//
//  ViewController.swift
//  Pokedex
//
//  Created by Alexey Danilov on 04/11/2017.
//  Copyright © 2017 DanilovDev. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var pokedex = [Pokemon]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Pokedex"
        
        self.pokedex.append(Pokemon(name: "Pidgey", type: "Normal / Flying", summary: "Pidgey is pure XP gold", evolutions: ["Pidgeotto", "Pidgeot"]))
        self.pokedex.append(Pokemon(name: "Spearow", type: "Normal / Flying", summary: "Spearow is remarkably angry", evolutions: ["Fearow"]))
        self.pokedex.append(Pokemon(name: "Jynx", type: "Psychic", summary: "Will cast a spell on you", evolutions: []))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokedex.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pokemon = self.pokedex[indexPath.row]
        cell.textLabel?.text = pokemon.name
        cell.detailTextLabel?.text = pokemon.type
        cell.imageView?.image = UIImage(named: "\(pokemon.name)-Thumb")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            vc.pokemon = self.pokedex[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

