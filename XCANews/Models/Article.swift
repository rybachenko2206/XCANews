//
//  Article.swift
//  XCANews
//
//  Created by Roman Rybachenko on 31.05.2022.
//

import Foundation

struct Article: Identifiable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let publishedAt: Date?
    let content: String?
    let id: String
    
    private let urlString: String?
    var url: URL? {
        guard let urlStr = urlString else { return nil }
        return URL(string: urlStr)
    }
    
    private let imageUrlString: String?
    var imageUrl: URL? {
        guard let imgUrlStr = imageUrlString else { return nil }
        return URL(string: imgUrlStr)
    }
    
    private let relativeDF = RelativeDateTimeFormatter()
    var publishedAtString: String? {
        guard let publishedDate = publishedAt else { return nil }
        return [source?.name, "·", relativeDF.localizedString(for: publishedDate, relativeTo: Date())].spaceJoined
    }
}

extension Article: Decodable {
    enum CodingKeys: String, CodingKey {
        case author, title, description, publishedAt, content, source
        case urlString = "url"
        case imageUrlString = "urlToImage"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        author = try? container.decode(String.self, forKey: .author)
        title = try? container.decode(String.self, forKey: .title)
        description = try? container.decode(String.self, forKey: .description)
        content = try? container.decode(String.self, forKey: .content)
        urlString = try? container.decode(String.self, forKey: .urlString)
        imageUrlString = try? container.decode(String.self, forKey: .imageUrlString)
        publishedAt = try? container.decode(Date.self, forKey: .publishedAt)
        source = try? container.decode(Source.self, forKey: .source)
        
        id = urlString ?? UUID().uuidString
    }
}

extension Article {
    static var stubItems: [Article] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        guard let dataUrl = Bundle.main.url(forResource: "GetNewsStub", withExtension: "json"),
              let data = try? Data(contentsOf: dataUrl),
              let response = try? decoder.decode(GetArticlesResponse.self, from: data)
        else {
            assertionFailure("problem with fetching data from stub file")
            return []
        }

        return response.articles ?? []
    }
}

struct Source: Decodable, Equatable {
    let name: String?
}

struct GetArticlesResponse: Decodable {
    let articles: [Article]?
    let totalResults: Int?
    
    let status: ResponseStatus?
    let code: String?
    let message: String?
}

enum ResponseStatus: String, Decodable {
    case ok, error
}
