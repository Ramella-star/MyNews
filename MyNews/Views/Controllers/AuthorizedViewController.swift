//
//  AuthorizedViewController.swift
//  MyNews
//
//  Created by Admin on 05.05.2021.
//

import UIKit
///контроллер аутентификации или регистрации
class AuthorizedViewController: UIViewController {

    @IBOutlet weak var passwordTextField: DSTextField!
    @IBOutlet weak var emailTextField: DSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    ///метод для скрытия клавиатуры при нажатии в любую область экрана
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    ///нажатие кнопки Зарегистрироваться
    @IBAction func checkInBtnClick(_ sender: Any) {
        ///првоерка полей на наличие значений
        if let password = passwordTextField.text, let email = emailTextField.text  {
            UserDefaultsService.setUser(user: email.lowercased(), password: password)
            self.showAlert(title: "", message: "Вы зарегистрировались", okHandler: { _ in
                ///редирект на первый контроллер стека(MainViewController) при нажатии кнопки ОК
                self.navigationController?.popToRootViewController(animated: true)
            })
        }else {///неудачная попытка зарегистрироваться
            self.showAlert(title: "", message: "Неправильный email или пароль", okHandler: nil)
        }
    }
    ///нажатие кнопки Войти
    @IBAction func logInBtnClick(_ sender: Any) {
        ///проверка на корректность почты, наличие пароля в локальной БД(UserDegaults) для данной и почты и соовадение введенного пароля с паролем из БД
        if let password = passwordTextField.text, let email = emailTextField.text ,let userPassword = UserDefaultsService.getPassword(user: email) , password == userPassword {
            UserDefaultsService.setUserEmail(email: email)
            self.showAlert(title: "", message: "Вы вошли", okHandler: { _ in
                self.navigationController?.popToRootViewController(animated: true)
            })
        }else {///неудачная попытка входа
            self.showAlert(title: "", message: "Неправильный email или пароль", okHandler: nil)
        }
    }
}
