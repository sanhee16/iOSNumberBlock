//
//  FireStoreService.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/13.
//

import Foundation
import FirebaseFirestore

class FireStoreService {
    private let db: Firestore = Firestore.firestore()
    var ref: DocumentReference? = nil
    
    init() {
        
    }
    
    func getCollection(_ collection: String) {
        db.collection(collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
