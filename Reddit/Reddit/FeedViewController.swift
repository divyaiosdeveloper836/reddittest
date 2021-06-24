//
//  FeedViewController.swift
//  Reddit
//
//  Created by Divya on 24/06/21.
//

import UIKit

class FeedViewController: UIViewController {
    
    var viewModel = ViewModel()
    let feedTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reddit"
        
        viewModel.delegate = self
        setupTableView()
        
        viewModel.fetchData()
    }
    
    private func setupTableView() {
        view.addSubview(feedTableView)
        //feedTableView.contentInset = UIEdgeInsets(top: 20.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        feedTableView.estimatedRowHeight = 40
        feedTableView.rowHeight = UITableView.automaticDimension
        
        feedTableView.translatesAutoresizingMaskIntoConstraints = false
        feedTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0).isActive = true
        feedTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        feedTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0).isActive = true
        feedTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        
        
        feedTableView.register(FeedListTableViewCell.self, forCellReuseIdentifier: "FeedsCell")
        feedTableView.dataSource = self
        feedTableView.delegate = self
        
    }
}


extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedsCell", for: indexPath) as? FeedListTableViewCell else {
            return UITableViewCell()
        }
        
        let item = viewModel.childAt(indexPath.row)
        cell.title.text = item.data.title
        cell.comments.text = "Comments: \(item.data.numComments)"
        cell.score.text = "Score: \(item.data.score)"

        if let image = CacheManager.manager.fetch(from: item.data.thumbnail), let img = UIImage(data: image) {
            cell.feedImage.image = img
        } else {
            viewModel.downloadImage(url: item.data.thumbnail) {(result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let received):
                        CacheManager.manager.cahceImage(url: received.1, data: received.0)
                        if let cell = tableView.cellForRow(at: indexPath) as? FeedListTableViewCell, let img = UIImage(data: received.0) {
                            cell.feedImage.image = img
                        }
                    case .failure(let error):
                        //print("Failed to download \(item.data.thumbnail) image: \(error)")
                        print("download failed: \(item.data.thumbnail)")
                    }
                }
            }
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            // Notify interested parties that end has been reached
            viewModel.fetchData()
        }
    }
}

extension FeedViewController: ViewModelDelegate {
    func update() {
        DispatchQueue.main.async { [self] in
            feedTableView.reloadData()
        }
    }
}
