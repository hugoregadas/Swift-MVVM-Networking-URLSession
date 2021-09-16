//
//  ItemsObject.swift
//  URLSession_NetWorking
//
//  Created by Hugo Regadas on 11/09/2021.
//

import Foundation

class Item : Codable{
    let id: String
    let title: String
    let publishedDate: String
    let hero: String
    let author: String
    let summary: String
    let body: String
    
    private enum CodingKeys: String, CodingKey{
        case publishedDate = "published-at"
        case id, title, hero, author, summary, body
    }
}


class ItemsObject : Codable {
    let items: [Item]
}
