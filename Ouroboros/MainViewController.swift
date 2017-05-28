//
//  ViewController.swift
//  Ouroboros
//
//  Created by eric yu on 5/26/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController,MainTableViewControllerDelegate{
    
    
    fileprivate var tableViewContainer = UIView()
    fileprivate var bottomViewContainer = UIView()
    fileprivate var clockView = ClockView()
    
    fileprivate var tableViewController = MainTableViewController()
    fileprivate var segmentController = UISegmentedControl()
    
    fileprivate var tableViewBottomAnchor: NSLayoutConstraint!
    fileprivate var tableViewHeightAnchor: NSLayoutConstraint!
    fileprivate var tableViewUnTappedConstant: CGFloat = 0
    fileprivate var tableViewTappedConstant: CGFloat {
        return -((view.frame.height/2) - (view.frame.height / 2) * 1/2)
    }
    fileprivate var isTableTapped:Bool = false
    
    
    fileprivate let goldenRatio :CGFloat = 34/55
    fileprivate let goldenRatioR :CGFloat = 55/34
 
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomViewContainer.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(viewTapped)))
         bottomViewContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
        
        InitializedSubViewControllers()
    
    }
    func viewTapped(){
        
        //if .ipad or already tapped don't do anything
        guard UIDevice.current.userInterfaceIdiom != .pad else {return}
        
        isTableTapped = false
        
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            //self.tableViewHeightAnchor.constant = self.startButton.frame.height
            self.tableViewHeightAnchor.constant = self.view.frame.width * self.goldenRatio
            self.view.layoutIfNeeded()
         
            
        }, completion: nil)
        
        
    }
    func tableTapped(){
        
        guard UIDevice.current.userInterfaceIdiom != .pad else {return}
        
        
        guard !isTableTapped else {return}
        
        isTableTapped = true
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 1,
                       options: .curveEaseIn,
                       animations: {
                       // self.tableViewHeightAnchor.constant = self.view.bounds.width * self.goldenRatio * 2
                        
                        self.tableViewHeightAnchor.constant = self.view.bounds.width * self.goldenRatio * 1.5
                        
                        
                        
                        
                       /* let bottomContainerHeight = self.bottomViewContainer.bounds.height - self.view.bounds.width * self.goldenRatioR
                        
                    
                        if bottomContainerHeight < self.startButtonHeightConstraint.constant {
                            
                            self.startButtonHeightConstraint.constant = bottomContainerHeight
                        }*/
                        
                        
                        self.view.layoutIfNeeded()
                   
                        
        },completion: nil)

        
    }
    
    func segmentControllerTapped(_ sender: UISegmentedControl){
        
        if let type = TableType(rawValue: sender.selectedSegmentIndex) {
            switch type {
            case .morning:
                //switch table Mourning Routine
                break
            case .night:
                //switch table Night Routine
                break
            case .day:
                //Maybe in the future
                break
            }
        }
    }

    
    func InitializedSubViewControllers(){
     
        view.addSubview(tableViewContainer)
        tableViewContainer.layer.cornerRadius = 5
        tableViewContainer.layer.masksToBounds = true
        tableViewContainerLayoutWithConstraintVariable()
        
        tableViewController.delegate = self
        
        tableViewContainer.addSubview(tableViewController.view)
        tableViewController.view.anchorToViewEdeges(parentView: tableViewContainer)

        segmentController.insertSegment(withTitle: "Morning", at: 0, animated: true)
        segmentController.insertSegment(withTitle: "Night", at: 1, animated: true)
        segmentController.tintColor = .orange
        segmentController.selectedSegmentIndex = 0
        segmentController.addTarget(self, action: #selector(segmentControllerTapped), for: .valueChanged)
        
        view.addSubview(bottomViewContainer)
        bottomViewContainer.anchor(top: tableViewContainer.bottomAnchor, left: view.leftAnchor, bottom: bottomLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
      
       // bottomViewContainer.backgroundColor = .blue //for test only
        //clockView.anchorToViewEdeges(parentView: bottomViewContainer)//for test only, there will be 3 clocks
        
       
        bottomViewContainer.addSubview(clockView)
        
        clockView.backgroundColor = .white
        clockView.anchor(top: bottomViewContainer.topAnchor, left: nil, bottom: nil, right: nil, paddingTop:50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 300)
        
        clockView.centerXAnchor.constraint(equalTo: bottomViewContainer.centerXAnchor, constant: 0).isActive = true
        clockView.centerYAnchor.constraint(equalTo: bottomViewContainer.centerYAnchor, constant: 0).isActive = true
        
        //clockView.startUpdates()
        
    }
    func tableViewContainerLayoutWithConstraintVariable(){
   
        tableViewContainer.translatesAutoresizingMaskIntoConstraints = false
        tableViewContainer.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        tableViewHeightAnchor = tableViewContainer.heightAnchor.constraint(equalToConstant: view.frame.width * goldenRatio)
        tableViewHeightAnchor.isActive = true
        
        tableViewContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableViewContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    
    
    }

    
    func layoutSubViewControllers(){
        
       
        
        
        
       
        
    }



}

