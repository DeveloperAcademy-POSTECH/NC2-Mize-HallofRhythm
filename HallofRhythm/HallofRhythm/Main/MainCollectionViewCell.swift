//
//  MainCollectionViewCell.swift
//  HallofRhythm
//
//  Created by HWANG-C-K on 2022/08/29.
//

import Foundation
import UIKit

//CollectionView의 Cell 구성
final class mainImageCell: UICollectionViewCell {
    static let id = "mainImageCell"
    
    //ImageView 추가
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var gameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @available(*, unavailable)
    required init?(coder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        self.contentView.backgroundColor = .systemGray2
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.gameLabel)
        
        // AutoLayout
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.imageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7),
            self.imageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.7),
            
            self.gameLabel.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor),
            self.gameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5)
        ])
    }
    
    // Cell Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(label:"", image:nil)
    }
    func prepare(label: String, image: UIImage?){
        self.gameLabel.text = label
        self.imageView.image = image
    }
}

// UIColor Hex Color Extension
extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}
