//
//  NewsViewCell.swift
//  MyNews
//
//  Created by Admin on 02.05.2021.
//

import UIKit
///ячейка новости с заголовком и картинкой
class NewsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    
    public var news: NewsViewModel? {
        didSet {
            self.newsTitle.text = news?.title ?? ""
            ///получение картинки
            NetworkManager.shared.getImage(urlString: news?.urlToImage ?? "") { (data) in
                
                guard let data = data else {return}
                DispatchQueue.main.async {
                    
                    self.newsImage.image = UIImage(data: data)
                    
                }
                
            }
        }
    }
    
}

