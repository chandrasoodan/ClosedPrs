//
//  PrView.swift
//  ClosedPrs
//
//  Created by Chandrasoodan MS on 31/07/22.
//

import Foundation
import UIKit

// reference to presenter

protocol AnyView{
    var presenter: AnyPresenter?{ get set }
    func update(with closedPrs: [ClosedPr])
    func update(with error: Error)
}

class PrViewController: UIViewController, AnyView , UITableViewDelegate , UITableViewDataSource{
   
    var presenter: AnyPresenter?
    private let tableView: UITableView = {
        var tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tv.isHidden = true
        tv.translatesAutoresizingMaskIntoConstraints  = false
        return tv
    }()
    func update(with closedPrs: [ClosedPr]) {
        
    }
    
    func update(with error: Error) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = .red
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        self.view.pinAllEdges(viewToPin: tableView, insets: [0,0,0,0])
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
}
