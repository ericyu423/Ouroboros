//
//  MainTabBarController.swift
//  Ouroboros
//
//  Created by eric yu on 5/26/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc1: UINavigationController = {
           let vc = MainViewController()
            vc.view.backgroundColor = .white
            
            let nc = UINavigationController(rootViewController: vc)
            //nc.tabBarItem.selectedImage = #imageLiteral(resourceName: "eye_selected")
            
            nc.tabBarItem.image = #imageLiteral(resourceName: "eye_unselected")
            return nc
        }()
        
        let nc2: UINavigationController = {
            
            let vc = SettingsViewController()
            vc.view.backgroundColor = .blue
            
            let nc = UINavigationController(rootViewController: vc)
            // nc.tabBarItem.selectedImage = #imageLiteral(resourceName: "graph_selected")
            nc.tabBarItem.image  = #imageLiteral(resourceName: "graph_uneslected")
            
            return nc
        }()
        
        let nc3: UINavigationController = {
            
            let vc = SettingsViewController()
            vc.view.backgroundColor = .yellow
            
            let nc = UINavigationController(rootViewController: vc)
            
            //SettingsTableViewController(style: UITableViewStyle.grouped)
            
            //nc.tabBarItem.selectedImage = #imageLiteral(resourceName: "gear_selected")
            nc.tabBarItem.image  = #imageLiteral(resourceName: "gear_unselected")
            
            return nc
        }()
        
        
        
        tabBar.tintColor = .black
        
        viewControllers = [nc1,nc2,nc3]
        
        
    }
    
}
