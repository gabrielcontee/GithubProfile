//
//  SearchProfileViewController.swift
//  GithubProfile
//
//  Created by Gabriel Conte on 01/03/20.
//  Copyright © 2020 Gabriel Conte. All rights reserved.
//

import UIKit

class SearchProfileViewController: UIViewController {
    
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var profileSearchBar: UISearchBar!{
        didSet{
            profileSearchBar.searchTextField.textColor = .black
        }
    }
    
    private let viewModel: SearchProfileViewModel

    init(with viewModel: SearchProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: .main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        self.viewModel.loadingDelegate = self
    }
    
    @IBAction func searchProfilePressed(_ sender: Any) {
        guard let name = profileSearchBar.text else {
            return
        }
        viewModel.fetchProfile(name: name)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchProfileViewController: LoadableProtocol {
    
    func isLoading() {
        DispatchQueue.main.async {
            Spinner.start(from: self.view)
        }
    }
    
    func alreadyLoaded<T>(_ dataLoaded: T) {
        DispatchQueue.main.async {
            Spinner.stop()
            if let name = self.profileSearchBar.text, let repos = dataLoaded as? [Project] {
                self.coordinator?.goToProfileDetails(profileName: name, repositories: repos)
            }
        }
    }
    
    func loadError(_ error: Error) {
        DispatchQueue.main.async {
            Spinner.stop()
            self.showAlert(title: "Error in fetch", message: error.localizedDescription)
        }
    }
    
}
