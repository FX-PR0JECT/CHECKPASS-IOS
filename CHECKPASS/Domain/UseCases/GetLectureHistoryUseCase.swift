//
//  GetLectureHistoryUseCase.swift
//  CHECKPASS
//
//  Created by 이정훈 on 3/6/24.
//

import Combine
import Foundation

typealias History = [String: [Lecture]]

protocol GetLectureHistoryUseCase {
    func execute() -> AnyPublisher<History, Error>
}

class DefaultGetLectureHistoryUseCase<T: LectureRepository> {
    let repository: T
    
    init(repository: T) {
        self.repository = repository
    }
}

extension DefaultGetLectureHistoryUseCase: GetLectureHistoryUseCase {
    func execute() -> AnyPublisher<History, Error> {
//        let publicIP = Bundle.main.publicIP
//        let url = "http://\(publicIP)/enrollment/history"
        let domain = Bundle.main.domain
        let url = "\(domain)/enrollment/history"
        
        return repository.fetchLectures(url: url)
            .map { history in
                guard let history = history as? History else {
                    fatalError("history can not be converted to History type")
                }
                
                return history
            }
            .eraseToAnyPublisher()
    }
}
