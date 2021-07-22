//
//  NetworkManager.swift
//  MyNews
//
//  Created by Admin on 02.05.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    let imageCache = NSCache < NSString, NSData > ()
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseUrlString = "https://newsapi.org/v2/"
    private let USTopHeadline = "top-headlines"
    ///Метод получения всех категрий
    func getCategoriesNews(searchString: String?, complition: @escaping ([CategoriesNews]?) -> ()) {
        var news: [CategoriesNews] = []
        var requestCount = 0///переменная для отслеживания кол-ва запросов
        /// цикл для отправки запроса для каждой категории
        for category in Categories.allCases {
            let urlString = "\(baseUrlString)\(USTopHeadline)?apiKey=\(API_Key.key)"
            guard let url = URL(string: urlString) else {
                return
            }
            ///параметры для запросов
            let params: [String: String] = ["country": "ru",
                                            "category": category.rawValue,
                                            "q": searchString ?? ""]
            ///используем библиотеку Alamofire
            AF.request(url, parameters: params)
                .validate()
                ///сериализируем ответ в модель NewsEnvelope
                .responseDecodable (of: NewsEnvelope.self ) {response in
                    ///проверяем ответ
                    switch response.result{
                    ///при успешном ответе
                    case .success(let value):
                        ///добавляем новость с ее категорией в массив
                        news.append(CategoriesNews(category: category.rawValue, news: value.articles ?? []))
                        ///при ошибке не добавляем новость
                    case .failure(let error):
                        print(error.responseCode, error.errorDescription)
                        //complition(nil)
                    }
                    requestCount += 1
                    ///если кол-во запросов равно кол-ву категрий вызывается колбек и массив новостей отправляется во ViewModel, если все запросы были неуспешными, отправляется пустой массив
                    if requestCount == Categories.allCases.count {
                        complition(news)
                    }
                }
        }
    }
    
    ///метод получения картинки по url
    func getImage(urlString: String, completion: @escaping (Data?) -> Void) {
        ///проверка на наличие в кэше
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            
            completion(cachedImage as Data)
            
        } else {
            ///если в кэще нет, получаем по url и заносим в кэш
            guard let url = URL(string: urlString ), let data = try? Data(contentsOf: url) else { return }
            self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
            
            completion(data)
        }
    }    
}

