//
//  NewsListViewModel.swift
//  MyNews
//
//  Created by Admin on 02.05.2021.
//

import Foundation

class NewsListViewModel {
    
    var newsVM = [NewsViewModel] ()
    var categoriesNewsVM = [AllNewsViewModel] ()
    
    let reuseID = "News"
    
    func getCategoriesNews(searchString: String?, completion: @escaping ([AllNewsViewModel]?) -> Void) {
        ///вызываем метод сервиса для получения новостей по категориям
        NetworkManager.shared.getCategoriesNews(searchString: searchString, complition: { (News) in
            ///ответ проверяем на наличие новостей
            guard let News = News else {
                completion(nil)
                return                
            }
            ///сериализируем массив новостей из серверной модели в модель ViewModel
            let news = News.map {
                (news) -> AllNewsViewModel in
                AllNewsViewModel(news: news.news.map(NewsViewModel.init), category: news.category)
                
              }
            ///вызываем колбэк для отправки новостей в контроллер
            DispatchQueue.main.async {
                self.categoriesNewsVM = news
                completion(news)
            }
            
        })
    }
    
}
