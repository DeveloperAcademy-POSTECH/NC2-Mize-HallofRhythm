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
        self.contentView.backgroundColor = .yellow
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.gameLabel)
        
        // AutoLayout
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            self.imageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.7),
            self.imageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.7),
            self.gameLabel.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor),
            self.gameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.gameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 100)
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
