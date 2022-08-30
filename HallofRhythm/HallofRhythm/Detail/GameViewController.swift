//
//  GameViewController.swift
//  HallofRhythm
//
//  Created by HWANG-C-K on 2022/08/30.
//

import UIKit

class GameViewController: UIViewController {

    var gameName: String?
    var imageArray: [UIImage]?
    
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.image = imageArray![0]
        
        navigationItem.title = gameName
        
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier:0.5),
            self.imageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier:0.5)
        ])
    }
}
