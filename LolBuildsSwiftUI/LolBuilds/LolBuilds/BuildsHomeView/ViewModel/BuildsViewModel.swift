//
//  BuildsViewModel.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/23/23.
//

import UIKit

class BuildController: ObservableObject {
    
    @Published var builds: [Build] = []
    @Published var selectedBuild: Build?
    @Published var selectedItem: Items?
    @Published var selectedChampion: ChampionInfo?
    @Published var shouldUpdateBuild: Bool = false
    
    @Published var selectedItemButton: Int = 0 // To store the selected item button
    @Published var selectedChampionButton: Int = 0 // To store the selected champion
    @Published var shouldOpen = false
    @Published var selectedBuildIndex: Int = 0
    
    var mockBuilds = [Build.mockBuild, Build.mockBuild, Build.mockBuild, Build.mockBuild]
    
    
    func updateBuildController(buttonIndex: Int) {
        builds[selectedBuildIndex].items[buttonIndex] = selectedItem
        builds[selectedBuildIndex].championButton = selectedChampion
        updateBuild(build: self.builds[selectedBuildIndex])
        shouldUpdateBuild = true
    }
    
    //fetch build
    
    func createBuild(title: String) {
        
        let newBuild = Build(title: title)
        builds.append(newBuild)
        saveToPersistenceStore()
        //return newBuild
    }
    
    //Update build
    func updateBuild(build: Build) {
        saveToPersistenceStore()
    }
    
    //delete build
    func deleteBuild(build: Build) {
        
        guard let index = builds.firstIndex(of: build) else { return }
        builds.remove(at: index)
        builds = []
        saveToPersistenceStore()
    }
    
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Builds.json")
        return fileURL
    }
    
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(builds)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
    
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            builds = try JSONDecoder().decode([Build].self, from: data)
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}
