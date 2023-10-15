//
//  InitalizeDBUseCase.swift
//  NumberBlock
//
//  Created by sandy on 2023/10/10.
//

import Foundation
import Combine


protocol InitalizeDBUseCase {
    func execute(
        //        requestValue: InitalizeDBUseCaseRequestValue,
        completion: @escaping () -> ()
    )
}

final class DefaultInitalizeDBUseCase: InitalizeDBUseCase {
    private let unitRepository: UnitRepository
    private let levelRepository: LevelRepository
    private let quizRepository: QuizRepository
    private var subscription = Set<AnyCancellable>()
    
    init(
        unitRepository: UnitRepository,
        levelRepository: LevelRepository,
        quizRepository: QuizRepository
    ) {
        self.unitRepository = unitRepository
        self.levelRepository = levelRepository
        self.quizRepository = quizRepository
    }
    
    func execute(
        //        requestValue: InitalizeDBUseCaseRequestValue,
        completion: @escaping () -> ()
    ) {
        self.getLocalFiles(completion)
    }
    
    private func getLocalFiles(_ completion: @escaping () -> ()) {
        // 파일매니저 인스턴스 생성
        let fileManager = FileManager.default
        // 사용자의 문서 경로
        let documentPath: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // 만든 파일 불러와서 읽기.
        
        Publishers.Zip3(
            loadFiles(documentPath.appendingPathComponent("unit.csv")),
            loadFiles(documentPath.appendingPathComponent("level.csv")),
            loadFiles(documentPath.appendingPathComponent("quiz.csv"))
            )
        .run(in: &self.subscription) {[weak self] (unitList, levelList, quizList) in
            guard let self = self else { return }
            for item in unitList {
                if item.count < 4 { continue }
                let idx = Int(item[0]) ?? 0
                let uuid = item[1]
                let title = item[2]
                let subTitle = item[3]
                try? self.unitRepository.insert(item: Unit(uuid: uuid, idx: idx, title: title, subTitle: subTitle, openTime: Int(Date().timeIntervalSince1970)))
            }
            for item in levelList {
                if item.count < 4 { continue }
                let idx = Int(item[0]) ?? 0
                let uuid = item[1]
                let unitIdx = Int(item[2]) ?? 0
                let title = item[3]
                try? self.levelRepository.insert(item: Level(uuid: uuid, idx: idx, unitIdx: unitIdx, title: title, openTime: Int(Date().timeIntervalSince1970)))
            }
            for item in quizList {
                if item.count < 5 { continue }
                let idx = Int(item[0]) ?? 0
                let uuid = item[1]
                let levelIdx = Int(item[2]) ?? 0
                let block1 = Int(item[3]) ?? 0
                let block2 = Int(item[4]) ?? 0
                try? self.quizRepository.insert(item: Quiz(uuid: uuid, idx: idx, levelIdx: levelIdx, block1: block1, block2: block2, answer: (block1 < 0 ? 0 : block1) + (block2 < 0 ? 0 : block2)))
            }
        } err: { err in
            print(err)
        } complete: {
            completion()
        }

    }
    
    private func loadFiles(_ url: URL) -> Future<[[String]], Error> {
        return Future<[[String]], Error> {[weak self] promise in
            guard let self = self else { return }
            do {
                let dataFromPath: Data = try Data(contentsOf: url) // URL을 불러와서 Data타입으로 초기화
                let dataEncoded: String? = String(data: dataFromPath, encoding: .utf8) // Data to String
                if let dataArr = dataEncoded?.components(separatedBy: "\n").map({$0.components(separatedBy: ",")}) {
                    var result = dataArr
                    result.removeFirst()
                    promise(.success(result))
                }
            } catch let e {
                print("FAILED!!")
                print(e.localizedDescription)
                promise(.failure(e))
            }
        }
    }
    deinit {
        subscription.removeAll()
    }
}

struct InitalizeDBUseCaseRequestValue {
    
}
