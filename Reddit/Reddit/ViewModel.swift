//
//  ViewModel.swift
//  Reddit
//
//  Created by Divya on 24/06/21.
//

import Foundation

enum Constants: String {
    case base = "http://www.reddit.com/.json"
    case more = " http://www.reddit.com/.json?after="
}

protocol ViewModelDelegate: AnyObject {
    func update()
}

class ViewModel {
    weak var delegate: ViewModelDelegate?
    
    var results = [Child]()
    var afterLink = ""
    var rowCount: Int {
        return results.count
    }
    
    func fetchData() {
        var url = Constants.base.rawValue
        if afterLink.count > 0 {
            url = "http://www.reddit.com/.json?after=" + afterLink
        }
        print("Fetching from: \(url)")
        ApiManager.manager.getData(requestUrl: url) {[self] data in
            switch data {
            case .success(let feedData):
                if self.afterLink.count > 0 {
                    self.results.append(contentsOf: feedData.children)
                } else {
                    self.results = feedData.children
                }
                self.afterLink = feedData.after
                self.delegate?.update()
            case .failure(let error):
                print("Error in getting data: \(error)")    //show warning alert
            }
        }
    }
 
    func downloadImage(url: String, completionHandler: @escaping (Result<(Data, String), NetworkError>) -> Void) {
        ApiManager.manager.downloadImage(url: url, completionHandler: completionHandler)
    }
    
    func childAt(_ row: Int) -> Child {
        return results[row]
    }
}
