//
//  BoletimManager.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 12/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//


import Foundation
import RealmSwift

public class BoletimManager {
    private let delegate = AppDelegate.delegate!
    public static var shared = BoletimManager()
  
    private init() {
    }
    
    func sync(listOfBoletimModel: [BoletimModel]) -> Void {
        
        let listDb = self.getAll()
        try! delegate.realm.write {
            delegate.realm.add(listOfBoletimModel, update:Realm.UpdatePolicy.all)
            for p in listDb {
                if listOfBoletimModel.contains(p) == false {
                    delegate.realm.delete(p)
                }
            }
        }
    }
    
    func add(BoletimModel: BoletimModel) {
        try! delegate.realm.write {
            delegate.realm.add(BoletimModel)
        }
    }
    
    func update(update: @escaping()->Void) {
        try! delegate.realm.write {
            update()
        }
    }
    
    func update(BoletimModel: BoletimModel) {
        try! delegate.realm.write {
            delegate.realm.add(BoletimModel, update:Realm.UpdatePolicy.all)
        }
    }
    
    func remove(BoletimModel: BoletimModel) {
        try! delegate.realm.write {
            delegate.realm.delete(BoletimModel)
        }
    }
    
    func getAll() -> [BoletimModel] {
        let list = delegate.realm.objects(BoletimModel.self)
        print(list)
        return list.map({ (BoletimModel) -> BoletimModel in
            BoletimModel
        })
    }

    func get(_ id:String) -> BoletimModel? {
        guard let boletimModel = delegate.realm.object(ofType: BoletimModel.self, forPrimaryKey:id) else {
            return nil
        }
        return BoletimModel(bol: boletimModel)
    }

}
