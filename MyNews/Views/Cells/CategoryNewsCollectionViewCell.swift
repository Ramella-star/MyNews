//
//  categoryNewsCollectionViewCell.swift
//  MyNews
//
//  Created by Admin on 02.05.2021.
//

import UIKit

protocol NewsDelegate: class {
    func openNews(url: URL)
}
///ячека collectionView с tableView, в которой отображаются новости выбранной категории
class CategoryNewsCollectionViewCell: UICollectionViewCell{
  
    @IBOutlet weak var tableView: UITableView!
    
    var news: [NewsViewModel]!
    var delegate: NewsDelegate!
    let cellID = "cell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        news = []
    }
    
    override func layoutSubviews() {
        ///скрывает все пустые ячейки
        tableView.tableFooterView = BackgroundView()
    }
    
    func setCell(data: [NewsViewModel]?) {
       
        self.news = data ?? []
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CategoryNewsCollectionViewCell: UITableViewDelegate, UITableViewDataSource{
    ///устанавливаем колич-во новостей = полученным данным при инициализации
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    ///передаем в каждую ячейку новость соответствующую ее порядковому номеру
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? NewsTableViewCell
        cell?.news = news[indexPath.row]
        
        return cell ?? UITableViewCell()
    }
    ///вызывает при выборе ячейки новости
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let a = self.news[indexPath.item]
        
        guard let url = URL(string: a.url) else {
            return
        }
        ///вызываем метод делегата для последующего открытия новости в боаузере
        delegate.openNews(url: url)
    }
}
