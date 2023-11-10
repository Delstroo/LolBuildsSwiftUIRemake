//
//  SelectedChampionModel.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/11/23.
//

import Foundation

struct SelectedChampionTopLevelObject: Codable {
    let data: [String:ChampionData]
    
}// End of struct

struct ChampionData: Codable {
    let id: String
    let name: String
    let title: String
    let image: ChampionSplashImage
    var skins: [Skins]
    let lore: String
    let blurb: String
    let allytips: [String]
    let enemytips: [String]
    let tags: [String]
    let spells: [Spells]
    
    // Add a static variable with hardcoded values
    static var hardcodedChampionData: ChampionData {
        return ChampionData(
            id: "Aatrox",
            name: "Aatrox",
            title: "the Darkin Blade",
            image: ChampionSplashImage(full: "Aatrox.png", sprite: "champion0.png", group: "champion"),
            skins: [
                Skins(id: "266000", name: "default", num: 0),
                Skins(id: "266001", name: "Justicar Aatrox", num: 1),
                // Add other skin data here...
            ],
            lore: "Once honored defenders of Shurima against the Void, Aatrox and his brethren would eventually become an even greater threat to Runeterra...",
            blurb: "Once honored defenders of Shurima against the Void, Aatrox and his brethren would eventually become an even greater threat to Runeterra...",
            allytips: ["Use Umbral Dash while casting The Darkin Blade to increase your chances of hitting the enemy.",
                        "Crowd Control abilities like Infernal Chains or your allies' immobilizing effects will help you set up The Darkin Blade.",
                        "Cast World Ender when you are sure you can force a fight."],
            enemytips: ["Aatrox's attacks are very telegraphed, so use the time to dodge the hit zones.",
                         "Aatrox's Infernal Chains are easier to exit when running towards the sides or at Aatrox.",
                         "Keep your distance when Aatrox uses his Ultimate to prevent him from reviving."],
            tags: ["Fighter", "Tank"],
            spells: [
                Spells(
                    id: "AatroxQ",
                    name: "The Darkin Blade",
                    description: "Aatrox slams his greatsword down, dealing physical damage. He can swing three times, each with a different area of effect.",
                    tooltip: "Aatrox slams his greatsword, dealing <physicalDamage>{{ qdamage }} physical damage</physicalDamage>. If they are hit on the edge, they are briefly <status>Knocked Up</status> and they take <physicalDamage>{{ qedgedamage }}</physicalDamage> instead. This Ability can be <recast>Recast</recast> twice, each one changing shape and dealing 25% more damage than the previous one.{{ spellmodifierdescriptionappend }}",
                    image: SpellImage(full: "AatroxQ.png", sprite: "spell0.png", group: "spell")
                ),
                Spells(
                    id: "AatroxW",
                    name: "Infernal Chains",
                    description: "Aatrox smashes the ground, dealing damage to the first enemy hit. Champions and large monsters have to leave the impact area quickly or they will be dragged to the center and take the damage again.",
                    tooltip: "Aatrox fires a chain, <status>Slowing</status> the first enemy hit by {{ wslowpercentage*-100 }}% for {{ wslowduration }} seconds and dealing <magicDamage>{{ wdamage }} magic damage</magicDamage>. Champions and large jungle monsters have {{ wslowduration }} seconds to leave the impact area or be <status>Pulled</status> back to the center and damaged again for the same amount.{{ spellmodifierdescriptionappend }}",
                    image: SpellImage(full: "AatroxW.png", sprite: "spell0.png", group: "spell")
                ),
                Spells(
                    id: "AatroxE",
                    name: "Umbral Dash",
                    description: "Passively, Aatrox heals when damaging enemy champions. On activation, he dashes in a direction.",
                    tooltip: "<spellPassive>Passive:</spellPassive> Aatrox gains <lifeSteal>{{ espellvamp }}% Omnivamp</lifeSteal> against champions, increased to <lifeSteal>{{ espellvampempowered }}% Omnivamp</lifeSteal> during <keywordMajor>World Ender</keywordMajor>.<br /><br /><spellActive>Active:</spellActive> Aatrox dashes. He can use this Ability while winding up his other Abilities.{{ spellmodifierdescriptionappend }}",
                    image: SpellImage(full: "AatroxE.png", sprite: "spell0.png", group: "spell")
                ),
                Spells(
                    id: "AatroxR",
                    name: "World Ender",
                    description: "Aatrox unleashes his demonic form, fearing nearby enemy minions and gaining attack damage, increased healing, and Move Speed. If he gets a takedown, this effect is extended.",
                    tooltip: "Aatrox reveals his true demonic form, <status>Fearing</status> nearby minions for {{ rminionfearduration }} seconds and gaining <speed>{{ rmovementspeedbonus*100 }}% Move Speed</speed> decaying over {{ rduration }} seconds. He also gains <scaleAD>{{ rtotaladamp*100 }}% Attack Damage</scaleAD> and increases <healing>self-healing by {{ rhealingamp*100 }}%</healing> for the duration.<br /><br />Champion takedowns extend the duration of this effect by {{ rextension }} seconds and refresh the <speed>Move Speed</speed> effect.{{ spellmodifierdescriptionappend }}",
                    image: SpellImage(full: "AatroxR.png", sprite: "spell0.png", group: "spell")
                ),
            ]
        )
    }
}

struct ChampionSplashImage: Codable {
    let full: String
    let sprite: String
    let group: String
    
}// End of struct

struct Skins: Codable {
    let id: String
    let name: String
    let num: Int
    
}// End of struct

struct SpellImage: Codable, Equatable, Hashable {
    let full: String
    let sprite: String
    let group: String

    static func == (lhs: SpellImage, rhs: SpellImage) -> Bool {
        return lhs.full == rhs.full &&
               lhs.sprite == rhs.sprite &&
               lhs.group == rhs.group
    }
}

struct Spells: Codable, Hashable, Equatable {
    let id: String
    let name: String
    let description: String
    let tooltip: String
    let image: SpellImage

    static func == (lhs: Spells, rhs: Spells) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.description == rhs.description &&
               lhs.tooltip == rhs.tooltip &&
               lhs.image == rhs.image
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(tooltip)
        hasher.combine(image)
    }
}

