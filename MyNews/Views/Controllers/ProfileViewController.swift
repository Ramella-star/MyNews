//
//  ProfileViewController.swift
//  MyNews
//
//  Created by Admin on 02.05.2021.
//

import UIKit
///контроллер профиля пользователя с возможностью войти/выйти и сменой темы
class ProfileViewController: UIViewController {

    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var logOutBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.switch.isOn = ThemeManager.currentTheme() == Theme.dark
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        ///проверка авторизован ли пользователь
        let key = UserDefaultsService.getAuthKey()
        ///если да - показываем данные пользователя, скрываем кнопку Войти и показываем кнопку Выйти
        userView.isHidden = !key
        logOutBtn.isHidden = !key
        logInBtn.isHidden = key
        email.text = UserDefaultsService.getUserEmail()
    }
    ///метод изменения темы
    @IBAction func changeTheme(_ sender: UISwitch) {
        let theme = sender.isOn ? Theme.dark : .light
        ThemeManager.applyTheme(theme: theme)
        themeSettings()
    }
    ///кнопка выйти
    @IBAction func logOutBtnClick(_ sender: Any) {
        UserDefaultsService.setAuthKey(authKey: false)
        self.showAlert(title: "", message: "Вы вышли", okHandler: {_ in
            ///перенаправляет на первый контроллер в стеке(MainViewControlelr)
            self.navigationController?.popToRootViewController(animated: true)
        })
    }
    ///обновляет view при переклюении темы
    func themeSettings() {
        let windows = UIApplication.shared.windows
        for window in windows {
            for view in window.subviews {
                view.removeFromSuperview()
                window.addSubview(view)
            }
        }
    }
}
