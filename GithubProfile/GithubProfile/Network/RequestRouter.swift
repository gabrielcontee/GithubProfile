//
//  RequestRouter.swift
//  GithubProfile
//
//  Created by Gabriel Conte on 01/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import Foundation

protocol RequestComponents {
    var baseUrl: String { get }
    var path: String { get }
}

enum RouterContext {
    case repositories
}

struct Router: RequestComponents {
    
    var profileName: String
    
    var context: RouterContext
    
    var baseUrl: String {
        switch context {
        case .repositories:
            return "https://api.github.com/users/"
        }
    }
    
    var path: String {
        switch context {
        case .repositories:
            return "\(profileName)/repos"
        }
    }
    
    var method: String {
      switch context {
      case .repositories:
          return "GET"
      }
    }
    
    init(profileName: String, context: RouterContext) {
        self.profileName = profileName
        self.context = context
    }
}

