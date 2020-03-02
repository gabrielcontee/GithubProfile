//
//  Repository.swift
//  GithubProfile
//
//  Created by Gabriel Conte on 01/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import Foundation

struct Project: Codable {
    
    var language: String?
    var name: String?
    var avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case language = "language"
        case owner = "owner"
        case name = "name"
        case avatarUrl = "avatar_url"
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        language = try? container.decodeIfPresent(String.self, forKey: .language)
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        let owner = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .owner)
        avatarUrl = try? owner.decodeIfPresent(String.self, forKey: .avatarUrl)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        var owner = container.nestedContainer(keyedBy: CodingKeys.self, forKey: .owner)
        try owner.encode(avatarUrl, forKey: .avatarUrl)
        try container.encode(language, forKey: .language)
        try container.encode(name, forKey: .name)
    }

}
