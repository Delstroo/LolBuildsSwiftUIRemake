//
//  ItemModel.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/11/23.
//

import Foundation

struct ItemTopLevelObject: Codable, Equatable, Hashable {
    let data: [String: Items]
    
    // Implement Equatable and Hashable for TheTopLevelObject
    static func == (lhs: ItemTopLevelObject, rhs: ItemTopLevelObject) -> Bool {
        return lhs.data == rhs.data
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(data)
    }
}

struct Items: Codable, Equatable, Hashable {
    let name: String
    let description: String
    let plaintext: String
    let image: ItemImage
    let gold: ItemGold
    let stats: ItemStats
    let tags: [String]
    
    // Implement Equatable and Hashable for Items
    static func == (lhs: Items, rhs: Items) -> Bool {
        return lhs.name == rhs.name &&
               lhs.description == rhs.description &&
               lhs.plaintext == rhs.plaintext &&
               lhs.image == rhs.image &&
               lhs.gold == rhs.gold &&
               lhs.stats == rhs.stats
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(description)
        hasher.combine(plaintext)
        hasher.combine(image)
        hasher.combine(gold)
        hasher.combine(stats)
    }
    
    static var itemArray = [Items.mockItem, Items.mockItem, Items.mockItem, Items.mockItem, Items.mockItem, Items.mockItem]
    
    static var mockItem: Items = Items(
        name: "Duskblade of Draktharr",
        description: "<mainText><stats><attention>350</attention> Health<br><attention>70</attention> Armor</stats><br><li><passive>Thorns:</passive> When struck by an Attack, deal damage to the attacker and apply 40% <status>Grievous Wounds</status> if they are a champion.<br><br><rules><status>Grievous Wounds</status> reduces the effectiveness of Healing and Regeneration effects.</rules></mainText><br>",
        plaintext: "",
        image: ItemImage(full: "223075.png", sprite: "item0.png"),
        gold: ItemGold(base: 3000, total: 3000, sell: 2100, purchasable: true),
        stats: ItemStats(
            FlatHPPoolMod: 350,
            rFlatHPModPerLevel: 0,
            FlatMPPoolMod: 0,
            rFlatMPModPerLevel: 0,
            percentHPPoolMod: 0,
            percentMPPoolMod: 0,
            FlatHPRegenMod: 0,
            rFlatHPRegenModPerLevel: 0,
            percentHPRegenMod: 0,
            FlatMPRegenMod: 0,
            rFlatMPRegenModPerLevel: 0,
            percentMPRegenMod: 0,
            FlatArmorMod: 70,
            rFlatArmorModPerLevel: 0,
            percentArmorMod: 0,
            rFlatArmorPenetrationMod: 0,
            rFlatArmorPenetrationModPerLevel: 0,
            rPercentArmorPenetrationMod: 0,
            rPercentArmorPenetrationModPerLevel: 0,
            FlatPhysicalDamageMod: 0,
            rFlatPhysicalDamageModPerLevel: 0,
            percentPhysicalDamageMod: 0,
            FlatMagicDamageMod: 0,
            rFlatMagicDamageModPerLevel: 0,
            percentMagicDamageMod: 0,
            FlatMovementSpeedMod: 0,
            rFlatMovementSpeedModPerLevel: 0,
            percentMovementSpeedMod: 0,
            rPercentMovementSpeedModPerLevel: 0,
            FlatAttackSpeedMod: 0,
            percentAttackSpeedMod: 0,
            rPercentAttackSpeedModPerLevel: 0,
            rFlatDodgeMod: 0,
            rFlatDodgeModPerLevel: 0,
            percentDodgeMod: 0,
            FlatCritChanceMod: 0,
            rFlatCritChanceModPerLevel: 0,
            percentCritChanceMod: 0,
            FlatCritDamageMod: 0,
            rFlatCritDamageModPerLevel: 0,
            percentCritDamageMod: 0,
            FlatBlockMod: 0,
            percentBlockMod: 0,
            FlatSpellBlockMod: 0,
            rFlatSpellBlockModPerLevel: 0,
            percentSpellBlockMod: 0,
            FlatEXPBonus: 0,
            percentEXPBonus: 0,
            rPercentCooldownMod: 0,
            rPercentCooldownModPerLevel: 0,
            rFlatTimeDeadMod: 0,
            rFlatTimeDeadModPerLevel: 0,
            rPercentTimeDeadMod: 0,
            rPercentTimeDeadModPerLevel: 0,
            rFlatGoldPer10Mod: 0,
            rFlatMagicPenetrationMod: 0,
            rFlatMagicPenetrationModPerLevel: 0,
            rPercentMagicPenetrationMod: 0,
            rPercentMagicPenetrationModPerLevel: 0,
            FlatEnergyRegenMod: 0,
            rFlatEnergyRegenModPerLevel: 0,
            FlatEnergyPoolMod: 0,
            rFlatEnergyModPerLevel: 0,
            percentLifeStealMod: 0,
            percentSpellVampMod: 0
        ), tags: ["Health", "Armor"]
    )

    // You can use mockItem for testing or as sample data.
}

struct ItemImage: Codable, Equatable, Hashable {
    let full: String
    let sprite: String
    
    // Implement Equatable and Hashable for ItemImage
    static func == (lhs: ItemImage, rhs: ItemImage) -> Bool {
        return lhs.full == rhs.full && lhs.sprite == rhs.sprite
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(full)
        hasher.combine(sprite)
    }
}

struct ItemGold: Codable, Equatable, Hashable {
    let base: Int
    let total: Int
    let sell: Int
    let purchasable: Bool
    
    // Implement Equatable and Hashable for ItemGold
    static func == (lhs: ItemGold, rhs: ItemGold) -> Bool {
        return lhs.base == rhs.base && lhs.total == rhs.total && lhs.sell == rhs.sell && lhs.purchasable == rhs.purchasable
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(base)
        hasher.combine(total)
        hasher.combine(sell)
        hasher.combine(purchasable)
    }
}

struct ItemStats: Codable, Equatable, Hashable {
    var FlatHPPoolMod: Double? = nil
    var rFlatHPModPerLevel: Double? = nil
    var FlatMPPoolMod: Double? = nil
    var rFlatMPModPerLevel: Double? = nil
    var percentHPPoolMod: Double? = nil
    var percentMPPoolMod: Double? = nil
    var FlatHPRegenMod: Double? = nil
    var rFlatHPRegenModPerLevel: Double? = nil
    var percentHPRegenMod: Double? = nil
    var FlatMPRegenMod: Double? = nil
    var rFlatMPRegenModPerLevel: Double? = nil
    var percentMPRegenMod: Double? = nil
    var FlatArmorMod: Double? = nil
    var rFlatArmorModPerLevel: Double? = nil
    var percentArmorMod: Double? = nil
    var rFlatArmorPenetrationMod: Double? = nil
    var rFlatArmorPenetrationModPerLevel: Double? = nil
    var rPercentArmorPenetrationMod: Double? = nil
    var rPercentArmorPenetrationModPerLevel: Double? = nil
    var FlatPhysicalDamageMod: Double? = nil
    var rFlatPhysicalDamageModPerLevel: Double? = nil
    var percentPhysicalDamageMod: Double? = nil
    var FlatMagicDamageMod: Double? = nil
    var rFlatMagicDamageModPerLevel: Double? = nil
    var percentMagicDamageMod: Double? = nil
    var FlatMovementSpeedMod: Double? = nil
    var rFlatMovementSpeedModPerLevel: Double? = nil
    var percentMovementSpeedMod: Double? = nil
    var rPercentMovementSpeedModPerLevel: Double? = nil
    var FlatAttackSpeedMod: Double? = nil
    var percentAttackSpeedMod: Double? = nil
    var rPercentAttackSpeedModPerLevel: Double? = nil
    var rFlatDodgeMod: Double? = nil
    var rFlatDodgeModPerLevel: Double? = nil
    var percentDodgeMod: Double? = nil
    var FlatCritChanceMod: Double? = nil
    var rFlatCritChanceModPerLevel: Double? = nil
    var percentCritChanceMod: Double? = nil
    var FlatCritDamageMod: Double? = nil
    var rFlatCritDamageModPerLevel: Double? = nil
    var percentCritDamageMod: Double? = nil
    var FlatBlockMod: Double? = nil
    var percentBlockMod: Double? = nil
    var FlatSpellBlockMod: Double? = nil
    var rFlatSpellBlockModPerLevel: Double? = nil
    var percentSpellBlockMod: Double? = nil
    var FlatEXPBonus: Double? = nil
    var percentEXPBonus: Double? = nil
    var rPercentCooldownMod: Double? = nil
    var rPercentCooldownModPerLevel: Double? = nil
    var rFlatTimeDeadMod: Double? = nil
    var rFlatTimeDeadModPerLevel: Double? = nil
    var rPercentTimeDeadMod: Double? = nil
    var rPercentTimeDeadModPerLevel: Double? = nil
    var rFlatGoldPer10Mod: Double? = nil
    var rFlatMagicPenetrationMod: Double? = nil
    var rFlatMagicPenetrationModPerLevel: Double? = nil
    var rPercentMagicPenetrationMod: Double? = nil
    var rPercentMagicPenetrationModPerLevel: Double? = nil
    var FlatEnergyRegenMod: Double? = nil
    var rFlatEnergyRegenModPerLevel: Double? = nil
    var FlatEnergyPoolMod: Double? = nil
    var rFlatEnergyModPerLevel: Double? = nil
    var percentLifeStealMod: Double? = nil
    var percentSpellVampMod: Double? = nil

    // Init method that filters out non-zero values
    init(FlatHPPoolMod: Double?,
         rFlatHPModPerLevel: Double?,
         FlatMPPoolMod: Double?,
         rFlatMPModPerLevel: Double?,
         percentHPPoolMod: Double?,
         percentMPPoolMod: Double?,
         FlatHPRegenMod: Double?,
         rFlatHPRegenModPerLevel: Double?,
         percentHPRegenMod: Double?,
         FlatMPRegenMod: Double?,
         rFlatMPRegenModPerLevel: Double?,
         percentMPRegenMod: Double?,
         FlatArmorMod: Double?,
         rFlatArmorModPerLevel: Double?,
         percentArmorMod: Double?,
         rFlatArmorPenetrationMod: Double?,
         rFlatArmorPenetrationModPerLevel: Double?,
         rPercentArmorPenetrationMod: Double?,
         rPercentArmorPenetrationModPerLevel: Double?,
         FlatPhysicalDamageMod: Double?,
         rFlatPhysicalDamageModPerLevel: Double?,
         percentPhysicalDamageMod: Double?,
         FlatMagicDamageMod: Double?,
         rFlatMagicDamageModPerLevel: Double?,
         percentMagicDamageMod: Double?,
         FlatMovementSpeedMod: Double?,
         rFlatMovementSpeedModPerLevel: Double?,
         percentMovementSpeedMod: Double?,
         rPercentMovementSpeedModPerLevel: Double?,
         FlatAttackSpeedMod: Double?,
         percentAttackSpeedMod: Double?,
         rPercentAttackSpeedModPerLevel: Double?,
         rFlatDodgeMod: Double?,
         rFlatDodgeModPerLevel: Double?,
         percentDodgeMod: Double?,
         FlatCritChanceMod: Double?,
         rFlatCritChanceModPerLevel: Double?,
         percentCritChanceMod: Double?,
         FlatCritDamageMod: Double?,
         rFlatCritDamageModPerLevel: Double?,
         percentCritDamageMod: Double?,
         FlatBlockMod: Double?,
         percentBlockMod: Double?,
         FlatSpellBlockMod: Double?,
         rFlatSpellBlockModPerLevel: Double?,
         percentSpellBlockMod: Double?,
         FlatEXPBonus: Double?,
         percentEXPBonus: Double?,
         rPercentCooldownMod: Double?,
         rPercentCooldownModPerLevel: Double?,
         rFlatTimeDeadMod: Double?,
         rFlatTimeDeadModPerLevel: Double?,
         rPercentTimeDeadMod: Double?,
         rPercentTimeDeadModPerLevel: Double?,
         rFlatGoldPer10Mod: Double?,
         rFlatMagicPenetrationMod: Double?,
         rFlatMagicPenetrationModPerLevel: Double?,
         rPercentMagicPenetrationMod: Double?,
         rPercentMagicPenetrationModPerLevel: Double?,
         FlatEnergyRegenMod: Double?,
         rFlatEnergyRegenModPerLevel: Double?,
         FlatEnergyPoolMod: Double?,
         rFlatEnergyModPerLevel: Double?,
         percentLifeStealMod: Double?,
         percentSpellVampMod: Double?) {
        self.FlatHPPoolMod = FlatHPPoolMod != 0 ? FlatHPPoolMod : nil
        self.rFlatHPModPerLevel = rFlatHPModPerLevel != 0 ? rFlatHPModPerLevel : nil
        self.FlatMPPoolMod = FlatMPPoolMod != 0 ? FlatMPPoolMod : nil
        self.rFlatMPModPerLevel = rFlatMPModPerLevel != 0 ? rFlatMPModPerLevel : nil
        self.percentHPPoolMod = percentHPPoolMod != 0 ? percentHPPoolMod : nil
        self.percentMPPoolMod = percentMPPoolMod != 0 ? percentMPPoolMod : nil
        self.FlatHPRegenMod = FlatHPRegenMod != 0 ? FlatHPRegenMod : nil
        self.rFlatHPRegenModPerLevel = rFlatHPRegenModPerLevel != 0 ? rFlatHPRegenModPerLevel : nil
        self.percentHPRegenMod = percentHPRegenMod != 0 ? percentHPRegenMod : nil
        self.FlatMPRegenMod = FlatMPRegenMod != 0 ? FlatMPRegenMod : nil
        self.rFlatMPRegenModPerLevel = rFlatMPRegenModPerLevel != 0 ? rFlatMPRegenModPerLevel : nil
        self.percentMPRegenMod = percentMPRegenMod != 0 ? percentMPRegenMod : nil
        self.FlatArmorMod = FlatArmorMod != 0 ? FlatArmorMod : nil
        self.rFlatArmorModPerLevel = rFlatArmorModPerLevel != 0 ? rFlatArmorModPerLevel : nil
        self.percentArmorMod = percentArmorMod != 0 ? percentArmorMod : nil
        self.rFlatArmorPenetrationMod = rFlatArmorPenetrationMod != 0 ? rFlatArmorPenetrationMod : nil
        self.rFlatArmorPenetrationModPerLevel = rFlatArmorPenetrationModPerLevel != 0 ? rFlatArmorPenetrationModPerLevel : nil
        self.rPercentArmorPenetrationMod = rPercentArmorPenetrationMod != 0 ? rPercentArmorPenetrationMod : nil
        self.rPercentArmorPenetrationModPerLevel = rPercentArmorPenetrationModPerLevel != 0 ? rPercentArmorPenetrationModPerLevel : nil
        self.FlatPhysicalDamageMod = FlatPhysicalDamageMod != 0 ? FlatPhysicalDamageMod : nil
        self.rFlatPhysicalDamageModPerLevel = rFlatPhysicalDamageModPerLevel != 0 ? rFlatPhysicalDamageModPerLevel : nil
        self.percentPhysicalDamageMod = percentPhysicalDamageMod != 0 ? percentPhysicalDamageMod : nil
        self.FlatMagicDamageMod = FlatMagicDamageMod != 0 ? FlatMagicDamageMod : nil
        self.rFlatMagicDamageModPerLevel = rFlatMagicDamageModPerLevel != 0 ? rFlatMagicDamageModPerLevel : nil
        self.percentMagicDamageMod = percentMagicDamageMod != 0 ? percentMagicDamageMod : nil
        self.FlatMovementSpeedMod = FlatMovementSpeedMod != 0 ? FlatMovementSpeedMod : nil
        self.rFlatMovementSpeedModPerLevel = rFlatMovementSpeedModPerLevel != 0 ? rFlatMovementSpeedModPerLevel : nil
        self.percentMovementSpeedMod = percentMovementSpeedMod != 0 ? percentMovementSpeedMod : nil
        self.rPercentMovementSpeedModPerLevel = rPercentMovementSpeedModPerLevel != 0 ? rPercentMovementSpeedModPerLevel : nil
        self.FlatAttackSpeedMod = FlatAttackSpeedMod != 0 ? FlatAttackSpeedMod : nil
        self.percentAttackSpeedMod = percentAttackSpeedMod != 0 ? percentAttackSpeedMod : nil
        self.rPercentAttackSpeedModPerLevel = rPercentAttackSpeedModPerLevel != 0 ? rPercentAttackSpeedModPerLevel : nil
        self.rFlatDodgeMod = rFlatDodgeMod != 0 ? rFlatDodgeMod : nil
        self.rFlatDodgeModPerLevel = rFlatDodgeModPerLevel != 0 ? rFlatDodgeModPerLevel : nil
        self.percentDodgeMod = percentDodgeMod != 0 ? percentDodgeMod : nil
        self.FlatCritChanceMod = FlatCritChanceMod != 0 ? FlatCritChanceMod : nil
        self.rFlatCritChanceModPerLevel = rFlatCritChanceModPerLevel != 0 ? rFlatCritChanceModPerLevel : nil
        self.percentCritChanceMod = percentCritChanceMod != 0 ? percentCritChanceMod : nil
        self.FlatCritDamageMod = FlatCritDamageMod != 0 ? FlatCritDamageMod : nil
        self.rFlatCritDamageModPerLevel = rFlatCritDamageModPerLevel != 0 ? rFlatCritDamageModPerLevel : nil
        self.percentCritDamageMod = percentCritDamageMod != 0 ? percentCritDamageMod : nil
        self.FlatBlockMod = FlatBlockMod != 0 ? FlatBlockMod : nil
        self.percentBlockMod = percentBlockMod != 0 ? percentBlockMod : nil
        self.FlatSpellBlockMod = FlatSpellBlockMod != 0 ? FlatSpellBlockMod : nil
        self.rFlatSpellBlockModPerLevel = rFlatSpellBlockModPerLevel != 0 ? rFlatSpellBlockModPerLevel : nil
        self.percentSpellBlockMod = percentSpellBlockMod != 0 ? percentSpellBlockMod : nil
        self.FlatEXPBonus = FlatEXPBonus != 0 ? FlatEXPBonus : nil
        self.percentEXPBonus = percentEXPBonus != 0 ? percentEXPBonus : nil
        self.rPercentCooldownMod = rPercentCooldownMod != 0 ? rPercentCooldownMod : nil
        self.rPercentCooldownModPerLevel = rPercentCooldownModPerLevel != 0 ? rPercentCooldownModPerLevel : nil
        self.rFlatTimeDeadMod = rFlatTimeDeadMod != 0 ? rFlatTimeDeadMod : nil
        self.rFlatTimeDeadModPerLevel = rFlatTimeDeadModPerLevel != 0 ? rFlatTimeDeadModPerLevel : nil
        self.rPercentTimeDeadMod = rPercentTimeDeadMod != 0 ? rPercentTimeDeadMod : nil
        self.rPercentTimeDeadModPerLevel = rPercentTimeDeadModPerLevel != 0 ? rPercentTimeDeadModPerLevel : nil
        self.rFlatGoldPer10Mod = rFlatGoldPer10Mod != 0 ? rFlatGoldPer10Mod : nil
        self.rFlatMagicPenetrationMod = rFlatMagicPenetrationMod != 0 ? rFlatMagicPenetrationMod : nil
        self.rFlatMagicPenetrationModPerLevel = rFlatMagicPenetrationModPerLevel != 0 ? rFlatMagicPenetrationModPerLevel : nil
        self.rPercentMagicPenetrationMod = rPercentMagicPenetrationMod != 0 ? rPercentMagicPenetrationMod : nil
        self.rPercentMagicPenetrationModPerLevel = rPercentMagicPenetrationModPerLevel != 0 ? rPercentMagicPenetrationModPerLevel : nil
        self.FlatEnergyRegenMod = FlatEnergyRegenMod != 0 ? FlatEnergyRegenMod : nil
        self.rFlatEnergyRegenModPerLevel = rFlatEnergyRegenModPerLevel != 0 ? rFlatEnergyRegenModPerLevel : nil
        self.FlatEnergyPoolMod = FlatEnergyPoolMod != 0 ? FlatEnergyPoolMod : nil
        self.rFlatEnergyModPerLevel = rFlatEnergyModPerLevel != 0 ? rFlatEnergyModPerLevel : nil
        self.percentLifeStealMod = percentLifeStealMod != 0 ? percentLifeStealMod : nil
        self.percentSpellVampMod = percentSpellVampMod != 0 ? percentSpellVampMod : nil
    }
    
//    static func == (lhs: ItemImage, rhs: ItemImage) -> Bool {
//        return lhs.full == rhs.full && lhs.sprite == rhs.sprite
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(full)
//        hasher.combine(sprite)
//    }
    
    func nonZeroStats() -> [String: Double] {
            var nonZeroStats = [String: Double]()
            
            if FlatHPPoolMod != 0 { nonZeroStats["FlatHPPoolMod"] = FlatHPPoolMod }
            if rFlatHPModPerLevel != 0 { nonZeroStats["rFlatHPModPerLevel"] = rFlatHPModPerLevel }
            if FlatMPPoolMod != 0 { nonZeroStats["FlatMPPoolMod"] = FlatMPPoolMod }
            if rFlatMPModPerLevel != 0 { nonZeroStats["rFlatMPModPerLevel"] = rFlatMPModPerLevel }
            if percentHPPoolMod != 0 { nonZeroStats["percentHPPoolMod"] = percentHPPoolMod }
            if percentMPPoolMod != 0 { nonZeroStats["percentMPPoolMod"] = percentMPPoolMod }
            if FlatHPRegenMod != 0 { nonZeroStats["FlatHPRegenMod"] = FlatHPRegenMod }
            if rFlatHPRegenModPerLevel != 0 { nonZeroStats["rFlatHPRegenModPerLevel"] = rFlatHPRegenModPerLevel }
            if percentHPRegenMod != 0 { nonZeroStats["percentHPRegenMod"] = percentHPRegenMod }
            if FlatMPRegenMod != 0 { nonZeroStats["FlatMPRegenMod"] = FlatMPRegenMod }
            if rFlatMPRegenModPerLevel != 0 { nonZeroStats["rFlatMPRegenModPerLevel"] = rFlatMPRegenModPerLevel }
            if percentMPRegenMod != 0 { nonZeroStats["percentMPRegenMod"] = percentMPRegenMod }
            if FlatArmorMod != 0 { nonZeroStats["FlatArmorMod"] = FlatArmorMod }
            if rFlatArmorModPerLevel != 0 { nonZeroStats["rFlatArmorModPerLevel"] = rFlatArmorModPerLevel }
            if percentArmorMod != 0 { nonZeroStats["percentArmorMod"] = percentArmorMod }
            if rFlatArmorPenetrationMod != 0 { nonZeroStats["rFlatArmorPenetrationMod"] = rFlatArmorPenetrationMod }
            if rFlatArmorPenetrationModPerLevel != 0 { nonZeroStats["rFlatArmorPenetrationModPerLevel"] = rFlatArmorPenetrationModPerLevel }
            if rPercentArmorPenetrationMod != 0 { nonZeroStats["rPercentArmorPenetrationMod"] = rPercentArmorPenetrationMod }
            if rPercentArmorPenetrationModPerLevel != 0 { nonZeroStats["rPercentArmorPenetrationModPerLevel"] = rPercentArmorPenetrationModPerLevel }
            if FlatPhysicalDamageMod != 0 { nonZeroStats["FlatPhysicalDamageMod"] = FlatPhysicalDamageMod }
            if rFlatPhysicalDamageModPerLevel != 0 { nonZeroStats["rFlatPhysicalDamageModPerLevel"] = rFlatPhysicalDamageModPerLevel }
            if percentPhysicalDamageMod != 0 { nonZeroStats["percentPhysicalDamageMod"] = percentPhysicalDamageMod }
            if FlatMagicDamageMod != 0 { nonZeroStats["FlatMagicDamageMod"] = FlatMagicDamageMod }
            if rFlatMagicDamageModPerLevel != 0 { nonZeroStats["rFlatMagicDamageModPerLevel"] = rFlatMagicDamageModPerLevel }
            if percentMagicDamageMod != 0 { nonZeroStats["percentMagicDamageMod"] = percentMagicDamageMod }
            if FlatMovementSpeedMod != 0 { nonZeroStats["FlatMovementSpeedMod"] = FlatMovementSpeedMod }
            if rFlatMovementSpeedModPerLevel != 0 { nonZeroStats["rFlatMovementSpeedModPerLevel"] = rFlatMovementSpeedModPerLevel }
            if percentMovementSpeedMod != 0 { nonZeroStats["percentMovementSpeedMod"] = percentMovementSpeedMod }
            if rPercentMovementSpeedModPerLevel != 0 { nonZeroStats["rPercentMovementSpeedModPerLevel"] = rPercentMovementSpeedModPerLevel }
            if FlatAttackSpeedMod != 0 { nonZeroStats["FlatAttackSpeedMod"] = FlatAttackSpeedMod }
            if percentAttackSpeedMod != 0 { nonZeroStats["percentAttackSpeedMod"] = percentAttackSpeedMod }
            if rPercentAttackSpeedModPerLevel != 0 { nonZeroStats["rPercentAttackSpeedModPerLevel"] = rPercentAttackSpeedModPerLevel }
            if rFlatDodgeMod != 0 { nonZeroStats["rFlatDodgeMod"] = rFlatDodgeMod }
            if rFlatDodgeModPerLevel != 0 { nonZeroStats["rFlatDodgeModPerLevel"] = rFlatDodgeModPerLevel }
            if percentDodgeMod != 0 { nonZeroStats["percentDodgeMod"] = percentDodgeMod }
            if FlatCritChanceMod != 0 { nonZeroStats["FlatCritChanceMod"] = FlatCritChanceMod }
            if rFlatCritChanceModPerLevel != 0 { nonZeroStats["rFlatCritChanceModPerLevel"] = rFlatCritChanceModPerLevel }
            if percentCritChanceMod != 0 { nonZeroStats["percentCritChanceMod"] = percentCritChanceMod }
            if FlatCritDamageMod != 0 { nonZeroStats["FlatCritDamageMod"] = FlatCritDamageMod }
            if rFlatCritDamageModPerLevel != 0 { nonZeroStats["rFlatCritDamageModPerLevel"] = rFlatCritDamageModPerLevel }
            if percentCritDamageMod != 0 { nonZeroStats["percentCritDamageMod"] = percentCritDamageMod }
            if FlatBlockMod != 0 { nonZeroStats["FlatBlockMod"] = FlatBlockMod }
            if percentBlockMod != 0 { nonZeroStats["percentBlockMod"] = percentBlockMod }
            if FlatSpellBlockMod != 0 { nonZeroStats["FlatSpellBlockMod"] = FlatSpellBlockMod }
            if rFlatSpellBlockModPerLevel != 0 { nonZeroStats["rFlatSpellBlockModPerLevel"] = rFlatSpellBlockModPerLevel }
            if percentSpellBlockMod != 0 { nonZeroStats["percentSpellBlockMod"] = percentSpellBlockMod }
            if FlatEXPBonus != 0 { nonZeroStats["FlatEXPBonus"] = FlatEXPBonus }
            if percentEXPBonus != 0 { nonZeroStats["percentEXPBonus"] = percentEXPBonus }
            if rPercentCooldownMod != 0 { nonZeroStats["rPercentCooldownMod"] = rPercentCooldownMod }
            if rPercentCooldownModPerLevel != 0 { nonZeroStats["rPercentCooldownModPerLevel"] = rPercentCooldownModPerLevel }
            if rFlatTimeDeadMod != 0 { nonZeroStats["rFlatTimeDeadMod"] = rFlatTimeDeadMod }
            if rFlatTimeDeadModPerLevel != 0 { nonZeroStats["rFlatTimeDeadModPerLevel"] = rFlatTimeDeadModPerLevel }
            if rPercentTimeDeadMod != 0 { nonZeroStats["rPercentTimeDeadMod"] = rPercentTimeDeadMod }
            if rPercentTimeDeadModPerLevel != 0 { nonZeroStats["rPercentTimeDeadModPerLevel"] = rPercentTimeDeadModPerLevel }
            if rFlatGoldPer10Mod != 0 { nonZeroStats["rFlatGoldPer10Mod"] = rFlatGoldPer10Mod }
            if rFlatMagicPenetrationMod != 0 { nonZeroStats["rFlatMagicPenetrationMod"] = rFlatMagicPenetrationMod }
            if rFlatMagicPenetrationModPerLevel != 0 { nonZeroStats["rFlatMagicPenetrationModPerLevel"] = rFlatMagicPenetrationModPerLevel }
            if rPercentMagicPenetrationMod != 0 { nonZeroStats["rPercentMagicPenetrationMod"] = rPercentMagicPenetrationMod }
            if rPercentMagicPenetrationModPerLevel != 0 { nonZeroStats["rPercentMagicPenetrationModPerLevel"] = rPercentMagicPenetrationModPerLevel }
            if FlatEnergyRegenMod != 0 { nonZeroStats["FlatEnergyRegenMod"] = FlatEnergyRegenMod }
            if rFlatEnergyRegenModPerLevel != 0 { nonZeroStats["rFlatEnergyRegenModPerLevel"] = rFlatEnergyRegenModPerLevel }
            if FlatEnergyPoolMod != 0 { nonZeroStats["FlatEnergyPoolMod"] = FlatEnergyPoolMod }
            if rFlatEnergyModPerLevel != 0 { nonZeroStats["rFlatEnergyModPerLevel"] = rFlatEnergyModPerLevel }
            if percentLifeStealMod != 0 { nonZeroStats["percentLifeStealMod"] = percentLifeStealMod }
            if percentSpellVampMod != 0 { nonZeroStats["percentSpellVampMod"] = percentSpellVampMod }
            
            return nonZeroStats
        }
    }


