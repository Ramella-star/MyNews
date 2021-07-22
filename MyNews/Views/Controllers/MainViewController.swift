//
//  ViewController.swift
//  MyNews
//
//  Created by Admin on 02.05.2021.
//

import UIKit
import SafariServices

///класс для настройки темы
class BackgroundView: UIView {}
///основной контроллер с лентой новостей(collection View) и поисковой строкой (searchBar)
class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var categoriesBar: CategoriesView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let categoryCellID = "categoryCell"
    var viewModel = NewsListViewModel()
    var news: [AllNewsViewModel] = []
    var firstNews: [AllNewsViewModel] = []
    var findedNews: [AllNewsViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ///присваиваем view с названием всех категорий delegate (CategoriesDelegate) для отслеживания выбранной категории
        categoriesBar.delegate = self
        ///изменение названия кнопки searchBar'a
        let uiButton = searchBar.value(forKey: "cancelButton") as! UIButton
        uiButton.setTitle("Назад", for: .normal)
        ///В качестве параметра поисковой строки отправляем текст поискового запроса
        fetchNews(searchBar.text)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        
        navigationController?.navigationBar.isHidden = true
    }
    
    ///метод для скрытия клавиатуры при нажатии в любую область экрана
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    
    func fetchNews(_ searchString: String?) {
        showBlockUI()///показываем loading View
        viewModel.getCategoriesNews(searchString: searchString, completion: { news in
            ///проверка на ошибки при запросах
            guard let data = news else {
                self.showAlert(title: "Error", message: "Ошибка соединения", okHandler: nil)
                ///скрытие  loading View
                self.hideBlockUI()
                return
            }
            ///проверка на наличие новостей
            if data.count == 0 {
                self.showAlert(title: "Error", message: "Нет данных", okHandler: nil)
            }
            self.hideBlockUI()
            
            ///если параметр поиска пустой, записываем данные в переменную firstNews для дальнейшего использования при нажатии кнопки "Назад"
            if searchString != nil {
                self.findedNews = data
            } else {
                self.firstNews = data
            }
            
            self.news = data
            
            ///обновляем collectionView
            self.collectionView.isHidden = false
            self.collectionView.reloadData()
        })
    }
}
///наследуем  протокол CategoriesDelegate для перелистывания страниц при изменении категории
extension MainViewController: CategoriesDelegate {
    ///передаем индекс страницы
    func scrollToCategory(index: Int) {
        self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
    }
}
///наследуем  протокол NewsDelegate для открытия новостей при нажатии на ячейку новости
extension MainViewController: NewsDelegate {
    ///передаем url для открытия в Сафари
    func openNews(url: URL) {
        let config = SFSafariViewController.Configuration()
        let SafariViewController = SFSafariViewController(url: url, configuration: config)
        SafariViewController.modalPresentationStyle = .formSheet
        present(SafariViewController, animated: true)
    }
}
///для отслеживания действий с SearchBar
extension MainViewController: UISearchBarDelegate {
    ///метод, срабатывающий при нажатии кнопки Search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //вызываем метод, отправляющий запрос и отправляем текст из searchBar
        fetchNews(searchBar.text)
    }
    ///метод, срабатывающий при нажатии кнопки "Отмена"
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        ///проверяем текст searchBar'a. Если он пустой и ранее поиск не совершался, не выполняем никаких действий
        if searchBar.text != "" && findedNews.count != 0{
            ///если поиск ранее совершался, подставляем в  параметр новостей данные из первичного запроса
            self.news = firstNews
            self.findedNews = []
            searchBar.text = ""
            ///обновляем collectionView для отображения новых данных
            collectionView.reloadData()
        }
    }
}
///для управления данными и дествиями в collectionView
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    ///устанавливаем количество страниц = количеству категорий
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Categories.allCases.count 
    }
    ///инициализируем ячейки для каждой категории
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellID, for: indexPath) as! CategoryNewsCollectionViewCell
        ///выбираем из массива новостей новости с нужной категорией
        let news = self.news.first {$0.category == Categories.allCases[indexPath.item].rawValue}
        ///отправляем новости в ячейку
        cell.setCell(data: news?.news)
        //присваиваем ячейке делегат(NewsDelegate) для отслеживания выбранной новости и открытия в браузере
        cell.delegate = self
        
        return cell
    }
    ///настройка размера ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}

