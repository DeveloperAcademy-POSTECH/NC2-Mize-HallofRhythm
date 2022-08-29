//
//  ViewController.swift
//  HallofRhythm
//
//  Created by HWANG-C-K on 2022/08/29.
//

import UIKit

class MainViewController: UIViewController {
    // CollectionView 기본 설정
    private let gridFlowLayout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .vertical
        return layout
    }()
    
    //CollectionView 생성
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame:.zero, collectionViewLayout: self.gridFlowLayout)
        view.isScrollEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.backgroundColor = .systemGray6
        view.clipsToBounds = true
        view.register(mainImageCell.self, forCellWithReuseIdentifier: "albumImageCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        //CollectionView AutoLayout
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    //CollectionView Cell의 Size 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { fatalError() }
        let cellColumns = 3
        let widthOfCells = collectionView.bounds.width
        let widthOfSpacing = CGFloat(cellColumns - 1) * flowLayout.minimumInteritemSpacing
        let width = (widthOfCells-widthOfSpacing) / CGFloat(cellColumns)
        return CGSize(width: width, height: width)
    }
    
//    //CollectionView에 표시되는 Item의 수
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return CoreDataManager.shared.albumImageArray!.count
//    }
//
//    //CollectionView의 각 cell에 이미지 표시
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: albumImageCell.id, for: indexPath) as! albumImageCell
//        cell.prepare(image:UIImage(data: CoreDataManager.shared.albumImageArray!.reversed()[indexPath.item].value(forKey: "thumbnail") as! Data))
//        return cell
//      }
}

////CollectionView의 이미지 클릭시 CellDetailView 표시
//extension MainViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cellDetailVC = CellDetailViewController()
//        cellDetailVC.getindex = indexPath.item
//        cellDetailVC.getimage = UIImage(data: CoreDataManager.shared.albumImageArray!.reversed()[indexPath.item].value(forKey: "image") as! Data)
//        self.navigationController?.pushViewController(cellDetailVC,animated: true)
//    }
//}
