//
//  Models.swift
//  MyNews
//
//  Created by Admin on 02.05.2021.
//

import Foundation
///модель приходящая с сервера
struct News: Decodable {
    
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    let url: String?
    
}

struct NewsEnvelope: Decodable {
    
    let status: String?
    let code: String?
    let message: String?
    let totalResults: Int?
    let articles: [News]?
    
}

struct CategoriesNews {
    let category: String
    let news: [News]
}
