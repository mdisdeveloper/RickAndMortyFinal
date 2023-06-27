//
//  LocationDetailViewController.swift
//  RickAndMorty
//
//  Created by Carlos De diego on 15/6/23.
//

import UIKit

final class LocationDetailViewController: UIViewController, LocationDetailViewViewModelDelegate, LocationDetailViewDelegate {

    private let viewModel: LocationDetailViewViewModel

    private let detailView = LocationDetailView()

    // MARK: - Init

    init(location: Location) {
        let url = URL(string: location.url)
        self.viewModel = LocationDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(detailView)
        addConstraints()
        detailView.delegate = self
        title = "Location"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))

        viewModel.delegate = self
        viewModel.fetchLocationData()
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    @objc
    private func didTapShare() {

    }

    // MARK: - View Delegate

    func EpisodeDetailView(
        _ detailView: LocationDetailView,
        didSelect character: Character
    ) {
        let vc = CharacterDetailViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - ViewModel Delegate

    func didFetchLocationDetails() {
        detailView.configure(with: viewModel)
    }
}
