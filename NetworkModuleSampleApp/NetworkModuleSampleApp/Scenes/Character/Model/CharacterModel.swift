//
//  CharacterModel.swift
//  NetworkModuleSampleApp


import Foundation

struct CharacterModel: Identifiable {
    var id: Int?
    var name, status, species, gender: String?
    var hair: String?
    var alias: [String]?
    var origin: String?
    var abilities: [String]?
    var imageURL: String?
}
