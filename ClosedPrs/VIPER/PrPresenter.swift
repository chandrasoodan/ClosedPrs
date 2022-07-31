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
    func prInteractorDidFetchPrs(with result: Result<[ClosedPr] , Error>)
        
    
    
}

class PrPresenter: AnyPresenter{
    var interactor: AnyInteractor?
    
    var view: AnyView?
    
    var router: AnyRouter?
    func prInteractorDidFetchPrs(with result: Result<[ClosedPr] , Error>){
        
        
    }
        
    
}
