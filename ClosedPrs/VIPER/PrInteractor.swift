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
    func getClosedPrs()
}

class PrInteractor: AnyInteractor{
    var presenter: AnyPresenter?
    
    
    func getClosedPrs() {
        
        
        
        guard let url = URL(string: "https://api.github.com/repos/firebase/quickstart-ios/pulls?state=closed") else{
            return
        }
        
        let task = URLSession.shared.closedPrsTask(with: url) {[weak self] prs, res, err in
            print("mass")
            print(err)
        
            self?.presenter?.prInteractorDidFetchPrs(with: .success(prs ?? []))
            print(prs?.first?.title)
        }
        task.resume()
                
    }
}

