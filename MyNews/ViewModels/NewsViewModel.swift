//
//  NewsViewModel.swift
//  MyNews
//
//  Created by Admin on 02.05.2021.
//

import Foundation

struct NewsViewModel {
    
    let news: News
    
    var author: String {
        return news.author ?? "Unknown"
    }
    
    var title: String {
        return news.title ?? ""
    }
    
    var description: String {
        return news.description ?? ""
    }
    
    var url: String {
        return news.url ?? ""
    }
    
    var urlToImage: String {
        return news.urlToImage ?? "https://www.kindpng.com/imgv/mmRiJJ_transparent-potted-plants-png-indoor-small-plant-png/"
    }
    
}

struct AllNewsViewModel {
    
    let news: [NewsViewModel]?
    
    let category: String
    
}

