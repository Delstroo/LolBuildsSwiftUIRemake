//
//  ItemHomeView.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/17/23.
//

import SwiftUI

struct ItemHomeView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @StateObject private var viewModel: ItemHomeViewModel = ItemHomeViewModel()
    @State private var items: [Items] = []
    @State private var selectedItem: Items? // Replace with your data type
    @State private var originalItemsArray: [Items] = []
    @State private var showAllAttributes = false
    @State private var isChampionViewActive = false
    @State private var isItemViewActive = true
    @State private var shouldShowDetailView = false
    @State var isModallyPresented: Bool = false
    @State var button: Int?
    @State var build: Build?
    @EnvironmentObject var buildController: BuildController
    // Define filteredItemsByTag here based on viewModel.categorySelected
    var filteredItemsByTag: [Items] {
        if viewModel.categorySelected == "All" {
            return self.originalItemsArray
        } else {
            DispatchQueue.main.async {
                self.items = self.originalItemsArray
            }
            return self.items.filter { $0.tags.contains(viewModel.categorySelected) }
        }
    }
    
    var filteredItems: [Items] {
        if searchText.isEmpty {
            return filteredItemsByTag
        } else {
            return filteredItemsByTag.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .trailing) {
                    DropDown(filterAction: {
                        viewModel.categorySelected = UserDefaults().string(forKey: "itemCategory") ?? "All"
                        items = filteredItemsByTag
                        searchText = ""
                    })
                    .frame(alignment: .trailing)
                    .ignoresSafeArea()
                    .padding(.bottom, viewModel.isDropdownOpen ? 20 : 12)
                }
                
                // Use filteredItemsByTag to display items
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 16)], spacing: 20) {
                    ForEach(filteredItems, id: \.self) { item in
                        Button(action: {
                            selectedItem = item
                            if isModallyPresented {
                                guard let button = button else { return }
                                buildController.selectedItem = item
                                buildController.updateBuildController(buttonIndex: button)
                                dismiss()
                            } else {
                                shouldShowDetailView = true
                            }
                        }) {
                            ItemCellView(item: item)
                        }
                    }
                }
                .background(Color.backGround)
                .ignoresSafeArea()
            }
            .background(Color.backGround)
            .safeAreaInset(edge: .top) {
                EmptyView()
                    .frame(height: isModallyPresented ? 120 : 100)
            }
            .overlay {
                NavigationAndSearchBar(searchText: $searchText,
                                       
                championAction: {
                    
                    isChampionViewActive.toggle()
                    
                }, itemAction: {
                    
                }, placeholder: "Search for your desired Item!", isCompressed: isModallyPresented)
            }
            .fullScreenCover(isPresented: $isChampionViewActive) {
                ChampionHomeView()
            }
            .sheet(isPresented: $shouldShowDetailView) {
                if let selectedItem = selectedItem {
                    VStack {
                        ItemDetailView(item: selectedItem)
                    }
                } else {
                    Text("Item not found.")
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                withAnimation {
                    isItemViewActive = true
                }
                viewModel.fetchItems(networkLayer: NetworkLayer.shared) { result in
                    switch result {
                    case .success(let items):
                        self.items = items
                        self.originalItemsArray = items
                        
                    case .failure(let error):
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                }
            }
        }
        .opacity(isItemViewActive ? 1 : 0)
        .background(Color.backGround)
    }
}

#Preview {
    ItemHomeView()
        .preferredColorScheme(.dark)
}
