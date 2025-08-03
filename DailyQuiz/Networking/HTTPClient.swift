//
//  HTTPClient.swift
//  DailyQuiz
//
//  Created by Z3ryk on 01.08.2025.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case httpError(statusCode: Int)
    case decodingError(Error)
}

struct HTTPClient {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder

        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    func get<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }

        let (data, response) = try await session.data(from: url)

        guard
            let code = (response as? HTTPURLResponse)?.statusCode,
            200..<300 ~= code
        else {
            throw NetworkError.httpError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
}
