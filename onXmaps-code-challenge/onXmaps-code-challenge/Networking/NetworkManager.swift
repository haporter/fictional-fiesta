//
//  NetworkManager.swift
//  onXmaps-code-challenge
//
//  Created by Andrew Porter on 2/28/23.
//

import Foundation
import Combine

protocol NetworkManagerType {
    func fetchData(at url: URL) -> AnyPublisher<Data, Error>
}

struct NetworkManager: NetworkManagerType {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData(at url: URL) -> AnyPublisher<Data, Error> {
        session
            .dataTaskPublisher(for: url)
            .mapError { $0 }
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
