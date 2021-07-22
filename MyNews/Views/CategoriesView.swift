//
//  CategoriesView.swift
//  MyNews
//
//  Created by Admin on 02.05.2021.
//

import UIKit
///для отслеживания выбранной категории
protocol CategoriesDelegate: class {
    func scrollToCategory(index: Int)
}

class CategoriesView: UIView {
    
    @IBOutlet weak var tableView: UILabel!
    
    let cellId = "cellId2"
    weak var delegate : CategoriesDelegate?
    var selectedCategory: Categories? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ///назначаем первуюкатегорию выбранной
        selectedCategory = Categories.allCases.first
        setupView()
    }
    
    func setupView() {
        addSubview(collectionView)
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = UIColor.clear
        cv.bounces = false
        cv.dataSource = self
        cv.delegate = self
        cv.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredHorizontally)
        cv.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        return cv
    }()

}

extension CategoriesView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Categories.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCollectionViewCell
        let category = Categories.allCases[indexPath.item]
        cell.setCell(category: category.getName(), isSelected: category == selectedCategory)
        
       return cell
    }
    ///настройка размера ячеек
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let category = Categories.allCases[indexPath.item].getName()
        let size = category.size(withAttributes: [.font: UIFont.systemFont(ofSize: 18)])
        
        return CGSize(width: size.width , height: self.frame.height)
    }
    
    ///gри выборе категориb делегат отправляет мндекс выбранной категории в mainController, где перелистывается collectionView для отображения новостей с данной категорией
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = Categories.allCases[indexPath.item]
        delegate?.scrollToCategory(index: indexPath.item )
        
    }
    
}

public enum Categories: String, CaseIterable {
    case sports //= "Спорт"
    case politics //= "Политика"
    case entertainment //= "Развлечения"
    case science //= "Наука"
    case technology //= "Путешествия"
    case health //= "Здоровье"
    
    func getName() -> String {
        switch self {
        case .sports:
            return "CПОРТ"
        case .politics:
            return "ПОЛИТИКА"
        case .entertainment:
            return "РАЗВЛЕЧЕНИЯ"
        case .science:
            return "НАУКА"
        case .technology:
            return "ТЕХНОЛОГИИ"
        case .health:
            return "ЗДОРОВЬЕ"
        }
    }
    //business entertainment general health science sports technology
}
