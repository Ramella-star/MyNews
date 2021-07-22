//
//  Theme.swift
//  MyNews
//
//  Created by Admin on 02.05.2021.
//

import UIKit
///перечисление для установки темы приложению
enum Theme: String {
    case light, dark
    var backgroundColor: UIColor {
        switch self {
        case .light:
            return .white
        case .dark:
            return .black
        }
    }
    
    var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
        case .light:
            return UIUserInterfaceStyle.light
        case .dark:
            return UIUserInterfaceStyle.dark
        }
    }
    
    var barStyle: UIBarStyle {
      switch self {
      case .light:
        return .default
      case .dark:
        return .black
      }
    }
    
    var textColor: UIColor {
        switch self {
        case .light:
            return .black
        case .dark:
            return .white
        }
    }
}


struct ThemeManager {
    ///получение текущей темы из локальной БД
    static func currentTheme() -> Theme {
        if let storedTheme = UserDefaultsService.getSelectedThemeKey() {
            return Theme(rawValue: storedTheme) ?? .light
        } else {
            return .light
        }
    }
    ///применение темы
    static func applyTheme(theme: Theme) {
        UserDefaultsService.saveSelectedThemeKey(themeKey: theme.rawValue)
        
        BackgroundView.appearance().backgroundColor = theme.backgroundColor
        UITableView.appearance().backgroundColor = theme.backgroundColor
        UILabel.appearance().textColor = theme.textColor
        UIButton.appearance().tintColor = theme.textColor
        UICollectionView.appearance().backgroundColor = theme.backgroundColor
        UISearchBar.appearance().tintColor = theme.textColor
        
        UITextField.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.3)
        UITextField.appearance().textColor = theme.textColor
        
        UINavigationBar.appearance().barTintColor = theme.backgroundColor
        UINavigationBar.appearance().barStyle = theme.barStyle
        UINavigationBar.appearance().tintColor = theme.textColor
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().isTranslucent = true
        
        UIActivityIndicatorView.appearance().color = theme.textColor
    }
}
