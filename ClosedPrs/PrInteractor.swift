//
//  PrInteractor.swift
//  ClosedPrs
//
//  Created by Chandrasoodan MS on 31/07/22.
//

import Foundation
// ref to presenter

protocol AnyInteractor{
    var presenter: AnyPresenter? {get set}
    func getClosedPrs(perPage: Int , sinceId: Int? )
}
public enum APIError: Error {
    case invalidUrl
    case errorDecode
    case failed(error: Error)
    case unknownError
}

class PrInteractor: AnyInteractor{
    var presenter: AnyPresenter?
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getClosedPrs(perPage: Int = 30 , sinceId: Int? = nil) {
        var components = URLComponents(string: "https://api.github.com/repos/chandrasoodan/ClosedPrs/pulls")!
        // firebase PR url
        //        var components = URLComponents(string: "https://api.github.com/repos/firebase/FirebaseUI-Android/pulls")!
        components.queryItems = [
            URLQueryItem(name: "per_page", value: "\(perPage)"),
            URLQueryItem(name: "state", value: "closed"),
            URLQueryItem(name: "since", value: (sinceId != nil) ? "\(sinceId!)" : "")
        ]
        
        guard let url = components.url else {
            self.presenter?.prInteractorDidFetchPrs(with: .failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.closedPrsTask(with: url) {[weak self] prs, res, err in
            
            if let err = err {
                self?.presenter?.prInteractorDidFetchPrs(with: .failure(.failed(error: err)))
                print(err)
            }else{
                self?.presenter?.prInteractorDidFetchPrs(with: .success(prs ?? []))
            }
        }
        task.resume()
        
    }
}

