//
//  UICollectionViewDataSourceMethods.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 10/7/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

//MARK: - UICollectionView Data Source Methods
extension SettingsLauncher: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return settings.count
     }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewCellId, for: indexPath) as! SettingsCell
           
           cell.setting = settings[indexPath.item]
                  
           return cell
       }
}
