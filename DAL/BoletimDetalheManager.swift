//
//  BoletimDetalheManager.swift
//  AuditElections
//
//  Created by Arthur Tavares Bezerra on 12/03/20.
//  Copyright © 2020 Mithun. All rights reserved.
//

import Foundation
import RealmSwift

public class BoletimDetalheManager {
    private let delegate = AppDelegate.delegate!
    public static var shared = BoletimDetalheManager()
  
    private init() {
    }
    
    func sync(listOfBoletimDetalheModel: [BoletimDetalheModel]) -> Void {
        
        let listDb = self.getAll()
        try! delegate.realm.write {
            delegate.realm.add(listOfBoletimDetalheModel, update:Realm.UpdatePolicy.all)
            for p in listDb {
                if listOfBoletimDetalheModel.contains(p) == false {
                    delegate.realm.delete(p)
                }
            }
        }
    }
    
    func add(BoletimDetalheModel: BoletimDetalheModel) {
        try! delegate.realm.write {
            delegate.realm.add(BoletimDetalheModel)
        }
    }
    
    func update(update: @escaping()->Void) {
        try! delegate.realm.write {
            update()
        }
    }
    
    func update(BoletimDetalheModel: BoletimDetalheModel) {
        try! delegate.realm.write {
            delegate.realm.add(BoletimDetalheModel, update:Realm.UpdatePolicy.all)
        }
    }
    
    func remove(BoletimDetalheModel: BoletimDetalheModel) {
        try! delegate.realm.write {
            delegate.realm.delete(BoletimDetalheModel)
        }
    }
    
    func getAll() -> [BoletimDetalheModel] {
        let list = delegate.realm.objects(BoletimDetalheModel.self)
        print(list)
        return list.map({ (BoletimDetalheModel) -> BoletimDetalheModel in
            BoletimDetalheModel
        })
    }

    func get(_ id:String) -> BoletimDetalheModel? {
        guard let boletimDetalheModel = delegate.realm.object(ofType: BoletimDetalheModel.self, forPrimaryKey:id) else {
            return nil
        }
        return BoletimDetalheModel(det: boletimDetalheModel)
    }

}
