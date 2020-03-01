//
//  ViewController.swift
//  GithubProfile
//
//  Created by Gabriel Conte on 01/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let router = Router(profileName: "gabrielcontee", context: .repositories)
        Requester().execute(router: router) { (result: Result<[Repository], Error>) in
            switch result {
            case .success(let teste):
                print(teste)
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }


}

