//
//  PrEntitty.swift
//  ClosedPrs
//
//  Created by Chandrasoodan MS on 31/07/22.
//

import Foundation


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let closedPrs = try ClosedPrs(json)

//
// To read values from URLs:
//
//   let task = URLSession.shared.closedPRTask(with: url) { closedPR, response, error in
//     if let closedPR = closedPR {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - ClosedPR
struct ClosedPR: Codable {
    
    let id: Int
    let title: String
    let user: User
    let createdAt, updatedAt, closedAt ,mergedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        
        case title, user
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case closedAt = "closed_at"
        case mergedAt = "merged_at"
        
    }
}

// MARK: ClosedPR convenience initializers and mutators

extension ClosedPR {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(ClosedPR.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        title: String? = nil,
        id: Int? = nil,
        user: User? = nil,
        createdAt: Date? = nil,
        updatedAt: Date? = nil,
        closedAt: Date? = nil,
        mergedAt: Date? = nil
        
        
    ) -> ClosedPR {
        let closedPr = ClosedPR.init(id: id ?? self.id, title: title ?? self.title, user: user ?? self.user, createdAt: createdAt ?? self.createdAt, updatedAt: updatedAt ?? self.updatedAt, closedAt: closedAt ?? self.closedAt, mergedAt: mergedAt ?? self.mergedAt)
        return closedPr
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.baseTask(with: url) { base, response, error in
//     if let base = base {
//       ...
//     }
//   }
//   task.resume()


// MARK: - User
struct User: Codable {
    let login: String
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

// MARK: User convenience initializers and mutators

extension User {
    init(data: Data) throws {
        self = try newJSONDecoder().decode(User.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func with(
        login: String? = nil,
        avatarURL: String? = nil
    ) -> User {
        return User(
            login: login ?? self.login,
            avatarURL: avatarURL ?? self.avatarURL
        )
    }
    
    func jsonData() throws -> Data {
        return try newJSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

typealias ClosedPrs = [ClosedPR]
// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }
    
    func closedPrsTask(with url: URL, completionHandler: @escaping (ClosedPrs?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}

// MARK: - Encode/decode helpers

