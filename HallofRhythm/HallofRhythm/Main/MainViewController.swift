//
//  ViewController.swift
//  HallofRhythm
//
//  Created by HWANG-C-K on 2022/08/29.
//

import UIKit

class MainViewController: UIViewController {
    
    var games: [Game] = []
    
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
        view.register(mainImageCell.self, forCellWithReuseIdentifier: "mainImageCell")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        // Navigation Bar
        navigationItem.title = "리듬게임"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: nil)
        
        doJsonLoad()
        self.collectionView.reloadData()
        
        // CollectionView AutoLayout
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    //json Parsing
    func doJsonLoad() {
        guard let path = Bundle.main.path(forResource: "GameList", ofType: "json") else { return }
        guard let jsonString = try? String(contentsOfFile: path) else { return }
        let decoder: JSONDecoder = JSONDecoder()
        guard let data = jsonString.data(using: .utf8) else { return }
        do {
          self.games = try decoder.decode([Game].self, from: data)
        } catch {
          print(error.localizedDescription)
        }
    }

}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
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
        return self.games.count
    }

    // CollectionView의 각 cell에 이미지 표시
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainImageCell.id, for: indexPath) as! mainImageCell
        cell.prepare(label: self.games[indexPath.item].gameName, image:UIImage(named: self.games[indexPath.item].imageName))
        return cell
      }
}

// CollectionView의 이미지 클릭시 CellDetailView 표시
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gameVC = GameViewController()
        self.navigationController?.pushViewController(gameVC,animated: true)
    }
}
