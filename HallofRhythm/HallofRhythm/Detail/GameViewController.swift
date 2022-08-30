//
//  GameViewController.swift
//  HallofRhythm
//
//  Created by HWANG-C-K on 2022/08/30.
//

import UIKit

class GameViewController: UIViewController {

    var gameName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = gameName
    }
}
