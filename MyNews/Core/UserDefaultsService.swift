//
//  UserDefaultsService.swift
//  MyNews
//
//  Created by Admin on 02.05.2021.
//

import Foundation
///сервис для работы с локальной базой данных
public final class UserDefaultsService {
    
    private static let _selectedThemeKey = "n_selectedThemeKey"
    private static let _isAuthKey = "n_isAuthKey"
    private static let _userEmail = "n_userEmail"
    
    // MARK: - - Theme
    ///храним выбранную тему(Dark/Light)
    public static func saveSelectedThemeKey(themeKey: String?) {
        UserDefaults.standard.set(themeKey, forKey: _selectedThemeKey)
    }
    //получаем выбранную тему
    public static func getSelectedThemeKey() -> String? {
        return UserDefaults.standard.string(forKey: _selectedThemeKey)
    }
    
    // MARK: - - User
    ///сохраняем настройки пользователя при регистрации
    public static func setUser(user _user: String, password: String) {
        UserDefaults.standard.set(_user, forKey: _userEmail)
        UserDefaults.standard.set(password, forKey: _user)
        UserDefaults.standard.set(true, forKey: _isAuthKey)
    }
    ///получения пароля по ключу = почте пользователя
    public static func getPassword(user _user: String) -> String? {
        return UserDefaults.standard.string(forKey: _user)
    }
    ///сохранение почты авторизовавшегося пользователя
    public static func setUserEmail(email: String) {
        UserDefaults.standard.set(email, forKey: _userEmail)
        UserDefaults.standard.set(true, forKey: _isAuthKey)
    }
    ///получение почты
    public static func getUserEmail() -> String? {
        return UserDefaults.standard.string(forKey: _userEmail)
    }
    
    // MARK: - - Authorized
    ///сохранение ключа авторизации - авторизован(1)/неавторизован(1)
    public static func setAuthKey(authKey: Bool){
        UserDefaults.standard.set(authKey, forKey: _isAuthKey)
    }
    ///получение ключа авторизации
    public static func getAuthKey() -> Bool {
        
        let authKey = UserDefaults.standard.string(forKey: _isAuthKey)
        switch authKey {
        case "1":
        return true
        case "0":
            return false
        case .some:
            return false
        case .none:
            return false
        }
    }
}
