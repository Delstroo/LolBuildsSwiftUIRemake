//
//  ChampionModel.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/11/23.
//

import Foundation

struct TopLevelObject: Codable {
    let data: [String: ChampionInfo]
}// End of struct

struct ChampionInfo: Codable, Hashable {
    static func == (lhs: ChampionInfo, rhs: ChampionInfo) -> Bool {
        return lhs.name == rhs.name &&
        lhs.id == rhs.name &&
        lhs.title == rhs.title &&
        lhs.blurb == rhs.blurb &&
        lhs.key == rhs.key &&
        lhs.image == rhs.image &&
        lhs.stats == rhs.stats &&
        lhs.tags == rhs.tags
        
    }
    
    let name: String
    let title: String
    let blurb: String
    let key: String
    let id: String
    let image: ChampionImage
    var stats: ChampionStats
    var tags: [String]
    
    // Static property for mock data
    static var mockData: ChampionInfo {
        return ChampionInfo(
            name: "Aatrox",
            title: "the Darkin Blade",
            blurb: "Once honored defenders of Shurima against the Void, Aatrox and his brethren would eventually become an even greater threat to Runeterra...",
            key: "266",
            id: "Aatrox",
            image: ChampionImage(full: "Aatrox.png", sprite: "champion0.png"),
            stats: ChampionStats(
                hp: 650,
                hpperlevel: 114,
                hpregen: 0,
                hpregenperlevel: 0,
                mp: 345,
                mpregen: 38,
                mpregenperlevel: 4.45,
                mpperlevel: 32,
                attackdamage: 2.05,
                attackdamageperlevel: 175,
                attackspeed: 3,
                attackspeedperlevel: 1,
                movespeed: 0,
                armor: 0,
                armorperlevel: 0,
                spellblock: 0,
                spellblockperlevel: 60,
                attackrange: 5,
                crit: 2.5,
                critperlevel: 0.651
            ), tags: ["Fighter: Tank"]
        )
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(title)
        hasher.combine(blurb)
        hasher.combine(key)
        hasher.combine(image)
        hasher.combine(stats)
        hasher.combine(tags)
        // Hash other properties if needed
    }
    
}// End of struct

struct ChampionImage: Codable, Equatable, Hashable {
    let full: String
    let sprite: String
    
    static func == (lhs: ChampionImage, rhs: ChampionImage) -> Bool {
        return lhs.full == rhs.full &&
        lhs.sprite == rhs.sprite
    }
    
}// End of struct

struct ChampionStats: Codable, Equatable, Hashable {
    var hp: Double
    let hpperlevel: Double
    let hpregen: Double
    let hpregenperlevel: Double
    let mp: Double
    let mpregen: Double
    let mpregenperlevel: Double
    let mpperlevel: Double
    let attackdamage: Double
    let attackdamageperlevel: Double
    let attackspeed: Double
    let attackspeedperlevel: Double
    let movespeed: Double
    let armor: Double
    let armorperlevel: Double
    let spellblock : Double
    let spellblockperlevel: Double
    let attackrange: Double
    let crit: Double
    let critperlevel: Double
    
    static func == (lhs: ChampionStats, rhs: ChampionStats) -> Bool {
        return lhs.hp == rhs.hp &&
        lhs.hpperlevel == rhs.hpperlevel &&
        lhs.hpregen == rhs.hpregen &&
        lhs.hpregenperlevel == rhs.hpregenperlevel &&
        lhs.mp == rhs.mp &&
        lhs.mpregen == rhs.mpregen &&
        lhs.mpregenperlevel == rhs.mpregenperlevel &&
        lhs.mpperlevel == rhs.mpperlevel &&
        lhs.attackdamage == rhs.attackdamage &&
        lhs.attackdamageperlevel == rhs.attackdamageperlevel &&
        lhs.attackspeed == rhs.attackspeed &&
        lhs.attackspeedperlevel == rhs.attackspeedperlevel &&
        lhs.movespeed == rhs.movespeed &&
        lhs.armor == rhs.armor &&
        lhs.armorperlevel == rhs.armorperlevel &&
        lhs.spellblock == rhs.spellblock &&
        lhs.spellblockperlevel == rhs.spellblockperlevel &&
        lhs.attackrange == rhs.attackrange &&
        lhs.crit == rhs.crit &&
        lhs.critperlevel == rhs.critperlevel
    }
}// End of struct


struct ChampionStatsArray: Codable {
    var labelOne = "HP:"
    
    var labelTwo = "HP Per Level:"
    
    var labelThree = "HP Regen:"
    
    var labelFour = "HP Regen Per Level:"
    
    var labelFive = "Magic Penetration (MP):"
    
    var labelSix = "Mp Regen:"
    
    var labelSeven = "MP Regen Per Level:"
    
    var labelEight = "Mp Per Level:"
    
    var labelNine = "Attack Damage:"
    
    var labelTen = "Attack Damage Per level"
    
    var labelEleven = "Attack Speed:"
    
    var labelTwelve = "Attacl Speed Per Level:"
    
    var labelThirteen = "Movement Speed:"
    
    var labelFourteen = "Armor:"
    
    var labelFifteen = "Armor Per Level:"
    
    var labelSixteen = "Spell Block:"
    
    var labelSeventeen = "Spell Block Per Level:"
    
    var labelEighteen = "Attack Range:"
    
    var labelNineteen = "Critical Chance:"
    
    var labelTwenty = "Critical Chance Per Level"
    
}
