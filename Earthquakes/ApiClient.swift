//
//  ApiClient.swift
//  Earthquakes
//
//  Created by Praveen on 8/16/22.
//

import Foundation
import Combine

class ApiClient {
    
    func GET<T:Decodable>(type: T.Type, _ url: URL, queue: DispatchQueue = .main) -> AnyPublisher<T, Error> {
        var request =  URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return URLSession.shared.dataTaskPublisher(for: request)
            .retry(1)
            .tryMap({ (data, response) in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: queue)
            .eraseToAnyPublisher()
    }
}
