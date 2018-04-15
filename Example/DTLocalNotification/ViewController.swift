//
//  ViewController.swift
//  DTLocalNotification
//
//  Created by tungvoduc on 02/27/2018.
//  Copyright (c) 2018 tungvoduc. All rights reserved.
//

import UIKit
import DTLocalNotification

class ViewController: UITableViewController {
    override init(style: UITableViewStyle) {
        super.init(style: style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    enum Section: Int {
        case customView1 = 0
        case customView2
        case customController
        
        var title: String? {
            switch self {
            case .customView1:
                return "Custom view 1"
            case .customView2:
                return "Custom view 2"
            case .customController:
                return "Custom controller"
            }
        }
    }
    
    let pokemons: [Section: [Pokemon]] = [
        Section.customView1: [
            Pokemon.pikachu,
            Pokemon.charmander,
            Pokemon.bullbasaur
        ],
        Section.customView2: [
            Pokemon.abra,
            Pokemon.eevee,
            Pokemon.jigglypuff
        ],
        Section.customController: [
            Pokemon.rattata,
            Pokemon.snorlax,
            Pokemon.squirtle
        ]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        title = "Pokemons"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return pokemons.keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonsAtSection(section).count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Section(rawValue: section)?.title
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        let pokemon: Pokemon = pokemons[Section(rawValue: indexPath.section)!]![indexPath.row]
        
        cell.imageView?.image = pokemon.image
        cell.textLabel?.text = pokemon.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let pokemon = pokemonAtIndexPath(indexPath)
        
        if indexPath.section == 0 {
            let view = SimpleNotificationView.notificationView()
            view.setName(pokemon.name)
            view.setImage(pokemon.image)
            view.setDescription(pokemon.dialog)
            
            let notification = DTLocalNotification(view: view)
            
            if indexPath.row == 0 {
                view.insertShadow(color: UIColor.black, opacity: 0.15, radius: 5, offset: CGSize(width: 0, height: 1))
                notification.style.height = SimpleNotificationView.defaultHeight
            }
            else if indexPath.row == 1 {
                view.insertShadow(color: UIColor.black, opacity: 0.15, radius: 5, offset: CGSize(width: 0, height: 1))
                notification.showingTime = 0
                notification.style.height = SimpleNotificationView.defaultHeight
            }
            else {
                // view.safeAreaTopConstraint.constant = 15 - UIEdgeInsets.safeAreaInset.top
                view.insertShadow(color: UIColor.black, opacity: 0.3, radius: 15, offset: CGSize.zero)
                view.shadowView.layer.cornerRadius = 10
                view.shadowView.layer.masksToBounds = true
                
                notification.style.leftInset = 10
                notification.style.rightInset = 10
                notification.style.height = SimpleNotificationView.defaultHeight - UIEdgeInsets.safeAreaInset.top + 10
                notification.style.topInset = 10 + UIEdgeInsets.safeAreaInset.top
            }
            
            DTInteractiveLocalNotificationPresenter.shared.showNotification(notification, completion: nil)
        }
        else if indexPath.section == 1 {
            let view = SecondNotificationView.notificationView()
            view.setName(pokemon.name)
            view.setImage(pokemon.image)
            view.setDescription(pokemon.dialog)
            
            let notification = DTLocalNotification(view: view)
            
            if indexPath.row == 0 {
                view.insertShadow(color: UIColor.black, opacity: 0.15, radius: 5, offset: CGSize(width: 0, height: 1))
                
                notification.style.leftInset = 0
                notification.style.rightInset = 0
                notification.style.height = SecondNotificationView.defaultHeight
                notification.style.topInset = 0
            }
            else if indexPath.row == 1 {
                view.insertShadow(color: UIColor.black, opacity: 0.15, radius: 5, offset: CGSize(width: 0, height: 1))
                notification.showingTime = 0
                notification.style.height = SecondNotificationView.defaultHeight
            }
            else {
                view.insertShadow(color: UIColor.black, opacity: 0.3, radius: 15, offset: CGSize.zero)
                view.shadowView.layer.cornerRadius = 10
                view.shadowView.layer.masksToBounds = true
                
                notification.style.leftInset = 10
                notification.style.rightInset = 10
                notification.style.height = SecondNotificationView.defaultHeight - UIEdgeInsets.safeAreaInset.top + 10
                notification.style.topInset = 10 + UIEdgeInsets.safeAreaInset.top
            }
            
            DTInteractiveLocalNotificationPresenter.shared.showNotification(notification, completion: nil)
        }
        else {
            let viewController = CustomLocalNotificationViewController(pokemon: pokemon)
            let notification = DTLocalNotification(viewController: viewController)
            notification.style.height = SecondNotificationView.defaultHeight - UIEdgeInsets.safeAreaInset.top + 10
            
            if indexPath.row == 1 {
                notification.showingTime = 0
            }
            
            DTInteractiveLocalNotificationPresenter.shared.showNotification(notification, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // Pokemons
    private func pokemonsAtSection(_ section: Int) -> [Pokemon] {
        return pokemons[Section(rawValue: section)!]!
    }
    
    private func pokemonAtIndexPath(_ indexPath: IndexPath) -> Pokemon {
        return pokemons[Section(rawValue: indexPath.section)!]![indexPath.row]
    }
}

//MARK: CustomTableViewCell
class CustomTableViewCell: UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageViewDimension: CGFloat = 30
        imageView?.frame = CGRect(x: 15, y: (frame.height - imageViewDimension)/2, width: imageViewDimension, height: imageViewDimension)
        imageView?.contentMode = UIViewContentMode.scaleAspectFit
        textLabel?.frame.origin.x = 15 + imageViewDimension + 15
    }
}
