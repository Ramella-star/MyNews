//
//  BlockUIView.swift
//  MyNews
//
//  Created by Admin on 10.05.2021.
//

import UIKit
///loading View наследуется от BackgroundView для поддержания темы
class BlockUIView: BackgroundView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initial()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initial()
    }
    
    func initial() {
        setupViews()
    }
    
    private func setupViews(){
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        setupConstraints()
    }
    
    let activityIndicator : UIActivityIndicatorView = {
        let uActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 2, y: 2)
        uActivityIndicator.transform = transform
        uActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return uActivityIndicator
    }()
    
    func setupConstraints() {
        //News header
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalToConstant: 200),
            activityIndicator.widthAnchor.constraint(equalTo: heightAnchor)
        ])
        
    }

}
