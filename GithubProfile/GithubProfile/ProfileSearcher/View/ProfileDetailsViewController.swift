//
//  ProfileDetailsViewController.swift
//  GithubProfile
//
//  Created by Gabriel Conte on 01/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import UIKit

class ProfileDetailsViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!{
        didSet{
            profileImageView.round()
        }
    }
    @IBOutlet weak var profileNameLabel: UILabel!
    
    weak var coordinator: MainCoordinator?
    
    private let viewModel: ProfileDetailsViewModel

    init(with viewModel: ProfileDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: .main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.loadDelegate = self
        self.viewModel.fetchProfileImage()
        profileNameLabel.text = viewModel.profileName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileDetailsViewController: ProfileLoaderProtocol{
    
    func shouldChangeImage(byData: Data) {
        DispatchQueue.main.async {
            self.profileImageView.image = UIImage(data: byData)
        }
    }
}
