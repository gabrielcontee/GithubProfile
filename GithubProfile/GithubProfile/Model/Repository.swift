//
//  Repository.swift
//  GithubProfile
//
//  Created by Gabriel Conte on 01/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    
    var language: String?
    var name: String?
    var avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case language = "language"
        case owner = "owner"
        case name = "name"
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        language = try? container.decodeIfPresent(String.self, forKey: .language)
        name = try? container.decodeIfPresent(String.self, forKey: .name)
        let owner = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .owner)
        avatarUrl = try? owner.decodeIfPresent(String.self, forKey: .avatarUrl)
    }

}
