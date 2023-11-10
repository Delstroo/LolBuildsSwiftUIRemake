//
//  BuildModel.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/11/23.
//

import Foundation

struct Build: Codable, Identifiable, Hashable {
    var id: String { uuid }
    var title: String
    var items: [Items?] // Use an array to represent the item slots
    var championButton: ChampionInfo?
    let uuid: String
    
    init(title: String, items: [Items?] = Array(repeating: nil, count: 6), championButton: ChampionInfo? = nil, uuid: String = UUID().uuidString) {
        
        self.title = title
        self.items = items
        self.championButton = championButton
        self.uuid = uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(items)
        hasher.combine(championButton)
        hasher.combine(uuid)
    }
    
    static let mockBuild = Build(title: "Aatrox", items: Items.itemArray, championButton: ChampionInfo.mockData, uuid: "hamburger")
}

extension Build: Equatable {
    static func == (lhs: Build, rhs: Build) -> Bool{
        return lhs.uuid == rhs.uuid
        
    }
}

