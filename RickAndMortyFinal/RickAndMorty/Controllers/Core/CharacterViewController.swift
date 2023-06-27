//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Carlos De diego on 15/6/23.
//

import UIKit

/// Controller to show and search for Characters
final class CharacterViewController: UIViewController, CharacterListViewDelegate {

    private let characterListView = RickAndMorty.CharacterListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Characters"
        setUpView()
        addSearchButton()
    }

    private func addSearchButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }

    @objc private func didTapSearch() {
        let vc = SearchViewController(config: SearchViewController.Config(type: .character))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setUpView() {
        characterListView.delegate = self
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    // MARK: - CharacterListViewDelegate

    func CharacterListView(_ characterListView: CharacterListView, didSelectCharacter character: Character) {
        // Open detail controller for that character
        let viewModel = CharacterDetailViewViewModel(character: character)
        let detailVC = CharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
