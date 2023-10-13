//
//  FireStorageService.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/13.
//

import Foundation
import FirebaseStorage
import Firebase
import Combine

class FireStorageService {
    private let url: String = Bundle.main.fireStorageUrl
    private let storage: Storage = Storage.storage()
    let gsReference: StorageReference
    
    init() {
        self.gsReference = self.storage.reference(forURL: self.url)
    }
    
    func downloadFile(_ childUrl: String, localUrl: String = "") -> Future<Bool, Error> {
        return Future<Bool, Error> {[weak self] promise in
            guard let self = self else { return }
            let downloadRef = gsReference.child(childUrl)
            
            // 파일매니저 인스턴스 생성
            let fileManager = FileManager.default
            // 사용자의 문서 경로
            let documentPath: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let _ = downloadRef.write(toFile: documentPath.appendingPathComponent(childUrl)) { url, error in
                if let error = error {
                    // Uh-oh, an error occurred!
                    print("download failed: \(error)")
                    promise(.failure(error))
                } else {
                    print("download success: \(childUrl)")
                    promise(.success(true))
                }
            }
        }
    }
}
