//
//  SettingsCell.swift
//  NewTable
//
//  Created by Ilija Mihajlovic on 10/4/19.
//  Copyright © 2019 Ilija Mihajlovic. All rights reserved.
//

import UIKit

final class SettingsCell: UICollectionViewCell {
    
    var setting: SettingsControllerModel? {
        didSet {
            nameLabel.text = setting?.name
            nameLabel.textColor = UIColor.darkGray
            
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = UIColor.mainAppOrange
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let iconImageView: UIImageView = {
          let imageView = UIImageView()
        imageView.image = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
          imageView.contentMode = .scaleAspectFill
          imageView.translatesAutoresizingMaskIntoConstraints = false
          return imageView
      }()
    
    
    //Higlight  Cell
       override var isHighlighted: Bool {
           didSet {
               
              backgroundColor =  isHighlighted ? UIColor.mainAppOrange: UIColor.white
               nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.darkGray
              iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.systemOrange
           }
       }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubView()
        setupConstraints() 
        
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
    fileprivate func addSubView() {
           [nameLabel, iconImageView].forEach{addSubview($0)}
           
       }
    
    //MARK: - Constraints
    fileprivate func setupConstraints() {
        nameLabel.anchor(top: nil, bottom: nil, leading: iconImageView.trailingAnchor, trailing: nil, padding: .init(top: 5, left: 5, bottom: 0, right: 0), size: .init(width: 70, height: 40))
        
        iconImageView.anchor(top: topAnchor, bottom: nil, leading: leadingAnchor, trailing: nameLabel.leadingAnchor, padding: .init(top: 6, left: 11, bottom: 12, right: 7), size: .init(width: 35, height: 33))
        }
    
}
