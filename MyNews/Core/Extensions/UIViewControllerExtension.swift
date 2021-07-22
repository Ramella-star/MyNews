//
//  UIViewControllerExtension.swift
//  MyNews
//
//  Created by Admin on 05.05.2021.
//

import UIKit

extension UIViewController {
    
    private static let blockUIAccessibilityIdentifier = "view_blockUI"
    
    public func showBlockUI() {
        let blockUI = BlockUIView()
        
        blockUI.accessibilityIdentifier = UIViewController.blockUIAccessibilityIdentifier
        view.addSubview(blockUI)
        let windowFrame = UIApplication.shared.keyWindow?.frame;
        let y = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height ?? 0)
        
         blockUI.frame = windowFrame ?? CGRect(x: 0, y:  y, width: view.frame.width, height: view.frame.height - 50)
        
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            blockUI.alpha = 1
        })
    }
    
    @objc public func hideBlockUI() {
        DispatchQueue.main.async {
            let blockUIViews = self.view.subviews.filter { $0.accessibilityIdentifier == UIViewController.blockUIAccessibilityIdentifier }
                    
            for blockUIView in blockUIViews {
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.5, animations: {
                        blockUIView.alpha = 0
                    }, completion: {
                        isCompleted in
                        if isCompleted { blockUIView.removeFromSuperview() }
                    })
                }
            }
        }
    }
    
    func showAlert(title: String = "", message: String = "", okHandler: ((UIAlertAction) -> ())? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: okHandler)
            alertController.addAction(action)
            alertController.overrideUserInterfaceStyle = ThemeManager.currentTheme().userInterfaceStyle
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
