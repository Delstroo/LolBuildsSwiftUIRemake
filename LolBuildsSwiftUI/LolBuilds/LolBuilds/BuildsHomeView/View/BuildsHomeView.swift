//
//  BuildsHomeView.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/23/23.
//

import SwiftUI

struct BuildsHomeView: View, AddActionDelegate {
    @EnvironmentObject var buildController: BuildController
    @State var builds: [Build] = []
    @State private var newBuildTitle = ""
    @State private var isItemSelectionPresented = false
    @State private var isChampionSelectionPresented = false
    @State private var shouldUpdate = false
    @State private var showingAlert = false
    @State private var buildName = ""

    var body: some View {
            NavigationView {
                ZStack {
                        List {
                            ForEach(buildController.builds.indices, id: \.self) { index in
                                let build = buildController.builds[index]

                                BuildsCell(build: build, index: index, itemAction: { itemButtonTapped(button: buildController.selectedItemButton, index: index) }, championAction: { championButtonTapped(button: buildController.selectedChampionButton, index: index) })

                            }
                            .onDelete(perform: { indexSet in
                                deleteBuilds(at: indexSet)
                            })
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .scrollContentBackground(.hidden)
                        .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
                    
                    DraggableButton(delegate: self)
                    .onAppear {
                        buildController.loadFromPersistenceStore()
                    }
                    .navigationBarHidden(true)
                    
                }
                .onChange(of: buildController.builds.count, perform: { newValue in
                    print(buildController.builds.count)
                })
                .onChange(of: buildController.builds, perform: { newValue in
                    print(buildController.builds)
                })
                .sheet(isPresented: $isItemSelectionPresented, content: {
                    ItemHomeView(isModallyPresented: true, button: buildController.selectedItemButton)
                })
                .sheet(isPresented: $isChampionSelectionPresented, content: {
                    ChampionHomeView(isModallyPresented: true, button: buildController.selectedChampionButton)
                })
                .alert("Add Build Name Here", isPresented: $showingAlert) {
                    TextField("Enter build name", text: $buildName)
                    Button("OK") {
                        buildController.createBuild(title: buildName)
                        buildName = ""
                        showingAlert = false
                    }
                    Button("Dismiss", role: .cancel) {
                        buildName = ""
                        showingAlert = false
                    }
                }
            }
    }

    func deleteBuilds(at offsets: IndexSet) {
        for index in offsets {
            let deletedBuild = buildController.builds[index]
            
            buildController.builds.remove(atOffsets: offsets)
            buildController.deleteBuild(build: deletedBuild)
            buildController.saveToPersistenceStore()
        }
    }
    
    func itemButtonTapped(button: Int, index: Int) {
        isItemSelectionPresented.toggle()
        buildController.selectedItemButton = button
        buildController.selectedBuildIndex = index
    }
    
    func championButtonTapped(button: Int, index: Int) {
        isChampionSelectionPresented.toggle()
        buildController.selectedChampionButton = button
        buildController.selectedBuildIndex = index
    }
    
    func addBuildAction() {
        showingAlert = true
    }
}

#Preview {
    BuildsHomeView()
        .preferredColorScheme(.dark)
}
