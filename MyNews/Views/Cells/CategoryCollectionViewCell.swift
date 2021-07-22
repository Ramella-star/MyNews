//
//  CategoryCollectionViewCell.swift
//  MyNews
//
//  Created by Admin on 03.05.2021.
//

import UIKit
///ячейка названий категорий
class CategoryCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            categoryLabel.alpha = isSelected ? 1 : 0.5
        }
    }
    
    func setCell(category: String, isSelected: Bool) {
        setupView()
        categoryLabel.text = category
    }
    
    private let categoryLabel: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.alpha = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    } ()
    
    func setupView() {
        addSubview(categoryLabel)
        setupConstraints()
        
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        
        ])
    }
}
