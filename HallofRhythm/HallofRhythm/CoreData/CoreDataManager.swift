//
//  CoreDataManager.swift
//  HallofRhythm
//
//  Created by HWANG-C-K on 2022/09/01.
//

import UIKit
import CoreData

class CoreDataManager {
    static let coreDM = CoreDataManager()
    var resultArray: [NSManagedObject]?
    
    // MARK: - CoreData
    // 데이터 저장
    func saveCoreData(gameTag: String, image: Data) {
        // App Delegate 호출
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // App Delegate 내부에 있는 viewContext 호출
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // managedContext 내부에 있는 entity 호출
        let entity = NSEntityDescription.entity(forEntityName: "Result", in: managedContext)!
        
        // entity 객체 생성
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        object.setValue(gameTag, forKey: "gameTag")
        object.setValue(Date(), forKey: "date")
        object.setValue(UUID(), forKey: "id")
        object.setValue(image, forKey: "image")
        object.setValue(UIImage(data:image)!.preparingThumbnail(of:CGSize(width:400, height:400))?.jpegData(compressionQuality:0), forKey: "thumbnail")
        
        // managedContext 내부의 변경사항 저장
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // 데이터 불러오기
    func readCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Entity의 fetchRequest 생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Result")
        
        // fetchRequest를 통해 managedContext로부터 결과 배열을 가져오기
        do {
            let resultCDArray = try managedContext.fetch(fetchRequest)
            self.resultArray = resultCDArray
        } catch let error as NSError {
            print("Could not read. \(error), \(error.userInfo)")
        }
    }
    
    // 데이터 삭제
    func deleteCoreData(object: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(object)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
