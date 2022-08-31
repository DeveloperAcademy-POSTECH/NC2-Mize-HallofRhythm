//
//  GameCollectionViewCell.swift
//  HallofRhythm
//
//  Created by HWANG-C-K on 2022/08/31.
//

import UIKit

//CollectionView의 Cell 구성
final class resultImageCell: UICollectionViewCell {
    static let id = "resultImageCell"
    
    //ImageView 추가
    private var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    @available(*, unavailable)
    required init?(coder:NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame:CGRect){
        super.init(frame:frame)
        self.contentView.backgroundColor = .systemGray2
        self.contentView.addSubview(self.imageView)
        
        // AutoLayout
        NSLayoutConstraint.activate([
            self.imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.imageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            self.imageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            self.imageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor)
        ])
    }
    
    // Cell Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(image:nil)
    }
    func prepare(image: UIImage?){
        self.imageView.image = image
    }
}
