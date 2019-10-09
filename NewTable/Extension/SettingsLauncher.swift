//
//  SettingsLauncher.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 10/4/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

final class SettingsLauncher: NSObject {
    
    //Singleton
    static let shared = SettingsLauncher()
    
    //MARK: - Properties
    let blurredView = UIView()
    let cellHeight: CGFloat = 58
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let settings: [SettingsControllerModel] = {
        return [
            SettingsControllerModel(name: "Send", imageName: "send"),
            SettingsControllerModel(name: "Get", imageName: "get"),
            SettingsControllerModel(name: "Sort", imageName: "sort"),
            SettingsControllerModel(name: "Cancel", imageName: "cancel")
        ]
    }()
    
    override init() {
        super.init()
        setupCollectionView()
    }
    
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: collectionViewCellId)
    }
    
    @objc func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blurredView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blurredView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissSettingsLauncherView)))
            
            window.addSubview(blurredView)
            window.addSubview(collectionView)
            
            //Make Hight of slide menu dynamic
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blurredView.frame = window.frame
            blurredView.alpha = 0
            
            //Implement an ease out curve
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blurredView.alpha = 1
                
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
            }, completion: nil)
            
        }
        
    }
    
    @objc func handleDismissSettingsLauncherView() {
        UIView.animate(withDuration: 0.5) {
            self.blurredView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    
    
    
    
    
    
    
    
}
