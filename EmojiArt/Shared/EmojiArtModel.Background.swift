//
//  EmojiArtModel.Background.swift
//  EmojiArt
//
//  Created by anthony on 2021/11/16.
//

import Foundation
import SwiftUI

extension EmojiArtModel {
    
    // enum with associated data
    enum Background: Equatable, Codable {
        case blank
        case url(URL)
        case imageData(Data)
        
        
        // MARK: - start customized Codable
        // this part is not quite necessary, because since Swift 5.5 it can automatically implement Codable for enums with associated values
        // but before Swift 5.5 this is not supported, that's the time when the CS193p 2021 Spring is recorded
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            if let url = try? container.decode(URL.self, forKey: .url) {
                self = .url(url)
            } else if let imageData = try? container.decode(Data.self, forKey: .imageData) {
                self = .imageData(imageData)
            } else {
                self = .blank
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case url = "theUrl"  // you can define the key name of the url field in json
            case imageData
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            switch self {
            case .url(let url): try container.encode(url, forKey: .url)
            case .imageData(let data): try container.encode(data, forKey: .imageData)
            case .blank: break
            }
        }
        // MARK: - end customized Codable
        
        var url: URL? {
            switch self {
            case .url(let url): return url
            default: return nil
            }
        }
        
        var imageData: Data? {
            switch self {
            case .imageData(let data): return data
            default: return nil
            }
        }
        
    }
}
