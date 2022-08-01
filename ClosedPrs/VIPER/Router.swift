//
//  Router.swift
//  ClosedPrs
//
//  Created by Chandrasoodan MS on 31/07/22.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter{
    var entry: EntryPoint? { get }
    static func start() -> AnyRouter
}

class PrRouter: AnyRouter{
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        var router = PrRouter()
        var presenter: AnyPresenter = PrPresenter()
        var view: AnyView = PrViewController()
        view.presenter = presenter
      
        var interactor: AnyInteractor = PrInteractor()
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        
        router.entry = view as? EntryPoint

        
        return router
    }
    
    
}
