//
//  PrPresenter.swift
//  ClosedPrs
//
//  Created by Chandrasoodan MS on 31/07/22.
//

import Foundation
//ref to interactor
// ref to router
// ref to view

protocol AnyPresenter{
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set}
    var view: AnyView? {get set}
    func prInteractorDidFetchPrs(with result: Result<ClosedPrs , APIError>)
    func fetchNextBatch(perPage: Int , sinceId: Int?)
    
    
}

class PrPresenter: AnyPresenter{
    
    var interactor: AnyInteractor? {
        didSet{
            interactor?.getClosedPrs(perPage: 30, sinceId: nil)
        }
    }
    
    var view: AnyView?
    
    var router: AnyRouter?
    func prInteractorDidFetchPrs(with result: Result<ClosedPrs , APIError>){
        
        switch result{
        case .success(let prs):
            view?.update(with: prs)
        case .failure(let err):
            view?.update(with: err)
        }
    }
    
    func fetchNextBatch(perPage: Int = 30 , sinceId: Int? = nil) {
        interactor?.getClosedPrs(perPage: perPage, sinceId: sinceId)
    }
    
    
}
