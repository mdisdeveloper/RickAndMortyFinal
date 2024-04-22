//
//  SearchViewController.swift
//  RickAndMorty
//
//  Created by Carlos De diego on 15/6/23.
//

import UIKit

// Dynamic search option view
// Render results
// Render no results zero state
// Searching / API Call

/// Configurable controller to search
final class SearchViewController: UIViewController {
    /// Configuration for search session
    struct Config {
        enum `Type` {
            case character // name | status | gender
            case episode // name
            case location // name | type

            var endpoint: Endpoint {
                switch self {
                case .character: return .character
                case .episode: return .episode
                case .location: return .location
                }
            }


            var title: String {
                switch self {
                case .character:
                    return "Search Characters"
                case .location:
                    return "Search Location"
                case .episode:
                    return "Search Episode"
                }
            }
        }

        let type: `Type`
    }

    private let viewModel: SearchViewViewModel
    private let searchView: SearchView

    // MARK: - Init

    init(config: Config) {
        let viewModel = SearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.searchView = RickAndMorty.SearchView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.config.type.title
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        addConstraints()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Search",
            style: .done,
            target: self,
            action: #selector(didTapExecuteSearch)
        )
        searchView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchView.presentKeyboard()
    }

    @objc
    private func didTapExecuteSearch() {
        viewModel.executeSearch()
    }

    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

// MARK: - SearchViewDelegate

extension SearchViewController: SearchViewDelegate {
    func SearchView(_ searchView: SearchView, didSelectOption option: SearchInputViewViewModel.DynamicOption) {
        let vc = SearchOptionPickerViewController(option: option) { [weak self] selection in
            DispatchQueue.main.async {
                self?.viewModel.set(value: selection, for: option)
            }
        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
    }

    func SearchView(_ searchView: SearchView, didSelectLocation location: Location) {
        let vc = LocationDetailViewController(location: location)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func SearchView(_ searchView: SearchView, didSelectCharacter character:  Character) {
        let vc = CharacterDetailViewController(viewModel: .init(character: character))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

    func SearchView(_ searchView: SearchView, didSelectEpisode episode: Episode) {
        let vc = EpisodeDetailViewController(url: URL(string: episode.url))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
