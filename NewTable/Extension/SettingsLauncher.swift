//
//  SettingsLauncher.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 10/4/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let blurredView = UIView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    let settings: [SettingsControllerModel] = {
        return [
        SettingsControllerModel(name: "Send", imageName: "send"),
        SettingsControllerModel(name: "Get", imageName: "get"),
        SettingsControllerModel(name: "Sort", imageName: "sort"),
        SettingsControllerModel(name: "Cancel", imageName: "cancel")
            
        ]
    }()
    
    @objc func showSettings() {
        
        if let window = UIApplication.shared.keyWindow {
                
                blurredView.backgroundColor = UIColor(white: 0, alpha: 0.5)
                
                blurredView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
                
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
    
    @objc fileprivate func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blurredView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        
        cell.setting = settings[indexPath.item]
               
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleDismiss()
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            self.blurredView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
            
        }) { (_ ) in
            
            //Present scene after completion
            let setting = self.settings[indexPath.item]
            
            if setting.name != "Cancel" {
                
                switch indexPath.item {
                    
                case 0 :
                    HomeController.shared.sendMessage()
                    
                case 1:
                    HomeController.shared.getJSONDataAndCheckForPossibleErrors()
                    
                case 2:
                    HomeController.shared.sortTableViewbyUsername()
                    
                default:
                    break
                }
                
            }
            
        }
        
    }
    
       
    
    
    override init() {
        super.init()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
    
}
