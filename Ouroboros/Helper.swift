//
//  Helper.swift
//  Ouroboros
//
//  Created by eric yu on 5/26/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit
enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone // iPhone and iPod touch style UI
    case pad // iPad style UI
    
    /*
     UIDevice.current.userInterfaceIdiom == .pad
     UIDevice.current.userInterfaceIdiom == .phone
     UIDevice.current.userInterfaceIdiom == .unspecified
     
     switch UIDevice.current.userInterfaceIdiom {
     case .phone:
     // It's an iPhone
     case .pad:
     // It's an iPad
     case .unspecified:
     // 
     }
     */
}

enum TableType: Int{
    case morning = 0
    case day
    case night
}


extension TimeInterval {
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60)
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
