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
    func update(with closedPrs: ClosedPrs)
    func update(with error: Error)
}

class PrViewController: UIViewController, AnyView , UITableViewDelegate , UITableViewDataSource{
   
    var presenter: AnyPresenter?
    var closedPrs: ClosedPrs = []
    private let tableView: UITableView = {
        var tv = UITableView()
        tv.register(PrViewCell.self, forCellReuseIdentifier: "cell")
        tv.isHidden = true
        tv.translatesAutoresizingMaskIntoConstraints  = false
        return tv
    }()
    func update(with closedPrs: ClosedPrs) {
        DispatchQueue.main.async {
            self.closedPrs = closedPrs
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: Error) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.title = "ClosedPrs"
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        self.view.pinAllEdges(viewToPin: tableView, insets: [0,-10,0,0])
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PrViewCell
       
        cell?.containerView.setCardView()
        var closedPr = closedPrs[indexPath.row]
        cell?.titleLabel.text = closedPr.title
        cell?.closedAtLabel.text = closedPr.closedAt?.formatted()
        cell?.createdAtLabel.text = closedPr.createdAt?.formatted()
        let url = URL(string: closedPr.user.avatarURL) ?? URL(string: "www.google.com")!
        cell?.userImage.loadImageWithUrl(url)
        
        cell?.statusImage.image = closedPr.mergedAt == nil ? UIImage.init(named: "closedPr") : UIImage.init(named: "mergedPr")
        cell?.userName.text = closedPr.user.login
        return cell ?? UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return closedPrs.count
    }
    
}
class PrViewCell: UITableViewCell{
    
    lazy var titleLabel: UILabel = {
       var v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.font = .boldSystemFont(ofSize: 18)
        v.adjustsFontSizeToFitWidth = true
        v.minimumScaleFactor = 0.1
        v.textColor = .darkText
        return v
    }()
    
    lazy var userName: UILabel = {
       var v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.adjustsFontSizeToFitWidth = true
        v.minimumScaleFactor = 0.1
        v.font = .systemFont(ofSize: 14)
        v.textColor = .darkText
        return v
    }()
    
    lazy var createdAtLabel: UILabel = {
       var v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.adjustsFontSizeToFitWidth = true
        v.minimumScaleFactor = 0.1
        v.font = .systemFont(ofSize: 14)
        v.textColor = .darkText
        return v
    }()
    
    lazy var closedAtLabel: UILabel = {
       var v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.adjustsFontSizeToFitWidth = true
        v.minimumScaleFactor = 0.1
        v.font = .systemFont(ofSize: 14)
        v.textColor = .darkText
        return v
    }()
    
    lazy var createdAtLabelTitle: UILabel = {
       var v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.adjustsFontSizeToFitWidth = true
        v.minimumScaleFactor = 0.1
        v.text = "Created At:"
        v.font = .boldSystemFont(ofSize: 14)
        v.textColor = .darkText
        return v
    }()
    
    lazy var closedAtLabelTitle: UILabel = {
       var v = UILabel()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.adjustsFontSizeToFitWidth = true
        v.minimumScaleFactor = 0.1
        v.text = "Closed At:"
        v.font = .boldSystemFont(ofSize: 14)
        v.textColor = .darkText
        return v
    }()
    
    lazy var userImage: ImageLoader = {
       var i = ImageLoader()
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
        
    }()
    lazy var statusImage: ImageLoader = {
       var i = ImageLoader()
        i.translatesAutoresizingMaskIntoConstraints = false
        return i
        
    }()
    lazy var containerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    lazy var lineView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 1).isActive = true
        v.backgroundColor = .lightGray
        return v
    }()
    
    lazy var secondLineView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant: 1).isActive = true
        v.backgroundColor = .lightGray
        return v
    }()
    
    lazy var horizontalLineView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraint(equalToConstant: 2).isActive = true
        v.backgroundColor = .lightGray
        return v
    }()
    
    lazy var createdStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sv.axis = .vertical
        return sv
    }()
    
    lazy var closedStackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sv.axis = .vertical
        return sv
    }()
    lazy var datesStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        return sv
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(containerView)
 
        containerView.addSubview(titleLabel)
        containerView.addSubview(userName)
        containerView.addSubview(createdAtLabel)
        containerView.addSubview(closedAtLabel)
        containerView.addSubview(userImage)
        containerView.addSubview(statusImage)
        containerView.addSubview(lineView)
        containerView.addSubview(datesStack)
        containerView.addSubview(secondLineView)

        contentView.pinAllEdges(viewToPin: containerView, insets: [5,-5,5,-5])
        
        statusImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4).isActive = true
        statusImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4).isActive = true
        statusImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        statusImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        statusImage.image = UIImage.checkmark
        
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: statusImage.trailingAnchor, constant: 4).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.textAlignment = .justified
        
        lineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        lineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4).isActive = true
        lineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4).isActive = true
    
        datesStack.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 2).isActive = true
        datesStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50).isActive = true
        datesStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5).isActive = true
        datesStack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        createdStackView.addArrangedSubview(createdAtLabelTitle)
        createdStackView.addArrangedSubview(createdAtLabel)
        
        closedStackView.addArrangedSubview(closedAtLabelTitle)
        closedStackView.addArrangedSubview(closedAtLabel)
        
        datesStack.addArrangedSubview(createdStackView)
        datesStack.addArrangedSubview(horizontalLineView)
        datesStack.addArrangedSubview(closedStackView)
       
        secondLineView.topAnchor.constraint(equalTo: datesStack.bottomAnchor, constant: 2).isActive = true
        secondLineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4).isActive = true
        secondLineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4).isActive = true
    
        userImage.topAnchor.constraint(equalTo: secondLineView.bottomAnchor, constant: 2).isActive = true
        userImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 50).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        userName.topAnchor.constraint(equalTo: userImage.topAnchor).isActive = true
        userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10).isActive = true
        userName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4).isActive = true
        userName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 4).isActive = true

        contentView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
