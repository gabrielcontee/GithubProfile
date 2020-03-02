//
//  ProfileDetailsViewModel.swift
//  GithubProfile
//
//  Created by Gabriel Conte on 01/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import Foundation

protocol ProfileLoaderProtocol: class {
    func shouldChangeImage(byData: Data)
}

final class ProfileDetailsViewModel: NSObject {
    
    private var repositories: [Repository]
    private(set) var profileName: String
    
    weak var loadDelegate: ProfileLoaderProtocol?
    
    // MARK: - Initialization functions
    
    init(profileName: String, repositories: [Repository]) {
        self.repositories = repositories
        self.profileName = profileName
    }
    
    func fetchProfileImage() {
        guard let avatarUrl = self.repositories.first(where: {$0.avatarUrl != nil})?.avatarUrl, let url = URL(string: avatarUrl) else {
            return
        }
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            self.loadDelegate?.shouldChangeImage(byData: data)
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - Table population functions
    
}


