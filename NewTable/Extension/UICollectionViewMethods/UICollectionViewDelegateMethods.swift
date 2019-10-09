//
//  UICollectionViewDelegateMethods.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 10/7/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

//MARK: - UITableView Delegate Methods

extension SettingsLauncher: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: collectionView.frame.width, height: cellHeight)
     }
    
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 0
     }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        SettingsLauncher.shared.handleDismissSettingsLauncherView()
        
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
    
}
