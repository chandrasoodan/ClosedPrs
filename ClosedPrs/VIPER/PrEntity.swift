//
//  PrEntitty.swift
//  ClosedPrs
//
//  Created by Chandrasoodan MS on 31/07/22.
//

import Foundation

struct ClosedPr: Codable{
    let title: String?
    let createdAt: Date?
    let closedDate: Date?
    let userName: String?
    let userImage: Data
}
