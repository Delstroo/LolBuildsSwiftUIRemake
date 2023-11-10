//
//  ItemHomeViewModel.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/17/23.
//

import Foundation

class ItemHomeViewModel: ObservableObject {
    
    enum ItemAttribute: String, CaseIterable {
        case all = "All"
        case abilityHaste = "AbilityHaste"
        case armor = "Armor"
        case armorPenetration = "ArmorPenetration"
        case attackSpeed = "AttackSpeed"
        case boots = "Boots"
        case consumable = "Consumable"
        case cooldownReduction = "CooldownReduction"
        case criticalStrike = "CriticalStrike"
        case damage = "Damage"
        case health = "Health"
        case jungle = "Jungle"
        case lifeSteal = "LifeSteal"
        case magicPenetration = "MagicPenetration"
        case magicResist = "MagicResist"
        case mana = "Mana"
        case manaRegen = "ManaRegen"
        case nonbootsMovement = "NonbootsMovement"
        case onHit = "OnHit"
        case slow = "Slow"
        case spellBlock = "SpellBlock"
        case spellDamage = "SpellDamage"
        case spellVamp = "SpellVamp"
        case stealth = "Stealth"
        case tenacity = "Tenacity"
        case trinket = "Trinket"
        case vision = "Vision"
    }
    
    @Published var items: [Items] = []
    @Published var categorySelected = "All"
    @Published var isDropdownOpen = false

    
    func fetchItems(networkLayer: NetworkLayer, completion: @escaping (Result<[Items], NetworkError>) -> Void) {
        let url = URL.apiEndpoint(url: URL.itemURL)
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        guard let finalURL = components?.url?.appendingPathExtension("json") else { return }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        networkLayer.fetch(request) { (result: Result<ItemTopLevelObject, NetworkError>) in
            switch result {
            case .success(let itemResult):
                DispatchQueue.main.async {
                    var uniqueItemNames = Set<String>()
                    
                    let itemData = itemResult.data.map { $0.value }.sorted(by: { $0.name < $1.name })
                    for item in itemData {
                        if item.gold.purchasable && !uniqueItemNames.contains(item.name) {
                            uniqueItemNames.insert(item.name)
                            self.items.append(item)
                        }
                    }
                    
                    completion(.success(self.items))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
