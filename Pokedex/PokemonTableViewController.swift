//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Field Employee on 12/13/20.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    @IBOutlet var pokemonTableView: UITableView!
    var pokemonResults: [PokemonResults] = []
    var pokemon: [Pokemon] = []
    var pokemonNames:[String] = []
//    var pokemonName: [Pokemon.results.name] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPokemon()
    }
    
    func getNames() {
        for i in self.pokemon {
            self.pokemonNames.append(i.name)
            print("line 46 pokemonNames \(self.pokemonNames)")
        }
    }
    
    func getPokemon() {
        URLSession.shared.dataTask(with:
        URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=20")!)
        { (data, response, error) in
          guard let data = data else {
            print("no data found")
            return
          }
            let group = DispatchGroup()
            group.enter()
          do {
            let results = try JSONDecoder().decode(PokemonResults.self, from: data)
            self.pokemon.append(contentsOf: results.results)
            print("var pokemon\(self.pokemon)")
            print("pokemon.count returns \(self.pokemonResults)")
            self.getNames()
          } catch {
            print("There was an error")
            group.leave()
          }
        }.resume()
    }

    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(self.pokemonNames.count)
        return 20
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
//        cell.textLabel?.text = self.pokemonNames[indexPath.row]
        cell.textLabel?.text = "My Quote"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPokemon = self.pokemonNames[indexPath.row]
        performSegue(withIdentifier: "moveToPokemonDetail", sender: selectedPokemon)
    }
        
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let pokemonViewController = segue.destination
            as? PokemonDetailViewController{
            if let selectedPokemon = sender as? String {
                pokemonViewController.title = selectedPokemon
            }
        }
    }
}



//    Old code below
//    private func getPokemon() {
//        //create the url with NSURL
//        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")! //change the url
//        //create the session object
//        let session = URLSession.shared
//        //now create the URLRequest object using the url object
//        let request = URLRequest(url: url)
//        //create dataTask using the session object to send data to the server
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
//            guard error == nil else {
//                return
//            }
//            guard let data = data else {
//                return
//            }
//            do {
//                //create json object from data
//                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                    print(json)
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        } )
//        task.resume()
//    }
