//
//  CellDetailViewController.swift
//  KnockKnock
//
//  Created by hurdasol on 2022/07/15.
//

import UIKit

class DetailViewController: UIViewController {
    // 해당 셀의 값 받아오기
    var getimage: UIImage?
    var getindex: Int?
    var getGame: String?
    
    // ImageView
    var detailImageView: UIImageView = {
        var imgView = UIImageView()
        imgView.adjustsImageSizeForAccessibilityContentSizeCategory = false
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    // 사진 확대를 위한 scrollView
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentMode = .scaleAspectFit
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //ImageView의 이미지에 받아온 이미지 넣기
        detailImageView.image = self.getimage
        
        //scrollView 세팅
        scrollView.maximumZoomScale = 4
        scrollView.minimumZoomScale = 1
        scrollView.addSubview(detailImageView)
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        //NavigationBar에 삭제 버튼 생성
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(trashTapped))
        
        //ImageView 레이아웃
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/3),
            
            detailImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            detailImageView.heightAnchor.constraint(equalTo: view.widthAnchor,  multiplier: 4/3),
        ])
    }
    
    // 사진 삭제 함수
    @objc func trashTapped() {
        let alert = UIAlertController(title: "사진 삭제", message: "사진을 삭제하시겠습니까?", preferredStyle: .alert)
        let success = UIAlertAction(title: "확인", style: .default) { [self] action in
            var counter = 0
            for item in CoreDataManager.coreDM.resultArray! {
                if item.value(forKey:"gameTag") as? String == self.getGame {
                    counter = counter + 1
                }
                if counter == self.getindex {
                    CoreDataManager.coreDM.deleteCoreData(object: item)
                }
            }
            navigationController?.popViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소 버튼")
        }
        alert.addAction(success)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
}

// 스크롤 뷰 줌기능 함수
extension DetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return detailImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = detailImageView.image {
                let ratioW = detailImageView.frame.width / image.size.width
                let ratioH = detailImageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > detailImageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - detailImageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > detailImageView.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - detailImageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
