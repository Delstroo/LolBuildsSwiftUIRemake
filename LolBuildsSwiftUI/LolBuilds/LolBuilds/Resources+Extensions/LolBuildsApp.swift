//
//  LolBuildsApp.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/11/23.
//

import SwiftUI

@main
struct LolBuildsApp: App {
    @StateObject var buildController = BuildController()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(buildController)
        }
    }
}
