//
//  Pokemon.swift
//  Pokedex
//
//  Created by Field Employee on 12/14/20.


import Foundation

struct PokemonResults: Decodable {
  let results: [Pokemon]
}
struct Pokemon: Decodable {
  let name: String
  let url: URL
    
//    init(from decoder: Decoder) throws {
//        let container
//    }
}




