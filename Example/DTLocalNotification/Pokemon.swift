//
//  Pokemon.swift
//  DTLocalNotification_Example
//
//  Created by Admin on 01/03/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

enum Pokemon {
    case pikachu
    case charmander
    case bullbasaur
    case abra
    case eevee
    case jigglypuff
    case rattata
    case snorlax
    case squirtle
    
    var name: String {
        switch self {
        case .pikachu: return "Pikachu"
        case .charmander: return "Charmander"
        case .bullbasaur: return "Bullbasaur"
        case .abra: return "Abra"
        case .eevee: return "Eevee"
        case .jigglypuff: return "Jigglypuff"
        case .rattata: return "Rattata"
        case .snorlax: return "Snorlax"
        case .squirtle: return "Squirtle"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .pikachu: return UIImage(named: "pikachu")
        case .charmander: return UIImage(named: "charmander")
        case .bullbasaur: return UIImage(named: "bullbasaur")
        case .abra: return UIImage(named: "abra")
        case .eevee: return UIImage(named: "eevee")
        case .jigglypuff: return UIImage(named: "jigglypuff")
        case .rattata: return UIImage(named: "rattata")
        case .snorlax: return UIImage(named: "snorlax")
        case .squirtle: return UIImage(named: "squirtle")
        }
    }
    
    var dialog: String {
        return "Hello everyone! My name is \(self.name)!"
    }
}
