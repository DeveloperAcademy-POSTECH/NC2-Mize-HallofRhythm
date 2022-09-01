//
//  GameViewController.swift
//  HallofRhythm
//
//  Created by HWANG-C-K on 2022/08/30.
//

import UIKit
import CoreData

class GameViewController: UIViewController {

    var gameName: String?
    var imageArray: [NSManagedObject] = []
    
    // CollectionView 기본 설정
    private let gridFlowLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        layout.scrollDirection = .vertical
        return layout
    }()
    
    // CollectionView 생성
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame:.zero, collectionViewLayout: self.gridFlowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .systemGray6
        view.register(resultImageCell.self, forCellWithReuseIdentifier: "resultImageCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.coreDM.readCoreData()
        collectionView.reloadData()
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        navigationItem.title = gameName
        
        // CollectionView AutoLayout
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension GameViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    // CollectionView Cell의 Size 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { fatalError() }
        let cellColumns = 3
        let widthOfCells = collectionView.bounds.width
        let widthOfSpacing = CGFloat(cellColumns - 1) * flowLayout.minimumInteritemSpacing
        let width = (widthOfCells-widthOfSpacing) / CGFloat(cellColumns)
        return CGSize(width: width, height: width)
    }
    
    // CollectionView에 표시되는 Item의 수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArray.count
    }

    // CollectionView의 각 cell에 이미지 표시
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resultImageCell.id, for: indexPath) as! resultImageCell
        cell.prepare(image: UIImage(data: self.imageArray.reversed()[indexPath.item].value(forKey: "thumbnail") as! Data))
        return cell
      }
}

//// CollectionView의 이미지 클릭시 CellDetailView 표시
//extension GameViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let gameVC = GameViewController()
//        gameVC.imageArray = self.imageArray
//        self.navigationController?.pushViewController(gameVC,animated: true)
//    }
//}
