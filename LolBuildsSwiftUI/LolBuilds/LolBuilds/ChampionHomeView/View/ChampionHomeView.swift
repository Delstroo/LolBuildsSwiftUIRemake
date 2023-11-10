//
//  ChampionHomeView.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/12/23.
//

import SwiftUI

enum ViewState {
    case champion
    case items
}

struct ChampionHomeView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var buildController: BuildController
    @State private var searchText = ""
    @State var isModallyPresented: Bool = false
    @StateObject private var viewModel: ChampionHomeViewModel = ChampionHomeViewModel()
    @State private var champions: [ChampionInfo] = []
    @State private var originalChampionsArray: [ChampionInfo] = []
    @State private var isChampionViewActive = true
    @State private var isItemViewActive = false
    @State private var selectedChampion: ChampionInfo?
    @State private var shouldShowDetailView = false
    @State var button: Int?
    let throttler = RequestThrottler()
    @State var shouldShowOnboarding: Bool = false

    var filteredChampions: [ChampionInfo] {
        if searchText.isEmpty {
            return filteredChampionsByTags
        } else {
            return filteredChampionsByTags.filter { $0.name.contains(searchText) }
        }
    }
    
    var filteredChampionsByTags: [ChampionInfo] {
        if viewModel.categorySelected == "All" {
            return originalChampionsArray
        } else {
            DispatchQueue.main.async {
                self.champions = self.originalChampionsArray
            }
            return champions.filter { $0.tags.contains(viewModel.categorySelected) }
        }
    }
    
    var body: some View {
            NavigationView {
                ScrollView {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(ChampionHomeViewModel.ChampionTypeSort.allCases, id: \.self) { category in
                                HStack {
                                    if category.rawValue != "All" {
                                        Text(category.rawValue)
                                            .fontWeight(.semibold)
                                            .foregroundColor(viewModel.categorySelected != category.rawValue ? Color.secondaryLabel.opacity(0.65) : Color.label)
                                            .padding(.vertical, 4)
                                            .padding(.leading, 12)
                                    } else {
                                        Text("   All   ")
                                            .fontWeight(.semibold)
                                            .foregroundColor(viewModel.categorySelected != category.rawValue ? Color.secondaryLabel.opacity(0.65) : Color.label)
                                            .background(.clear)
                                            .clipShape(RoundedRectangle(cornerRadius: 25))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25)
                                                    .stroke(viewModel.categorySelected != category.rawValue ? Color.clear : Color.label, lineWidth: 2)
                                            )
                                            .padding(.vertical, 4)
                                            .padding(.leading, 12)
                                    }
                                    
                                    if category.rawValue != "All" {
                                        Image(category.rawValue)
                                            .resizable()
                                            .frame(width: 25, height: 25)
                                            .padding(.trailing, 12)
                                            .opacity(viewModel.categorySelected != category.rawValue ? 0.45 : 1)
                                    }
                                }
                                
                                .background {
                                    if viewModel.categorySelected == category.rawValue {
                                        Capsule()
                                            .fill(Color(category.rawValue).opacity(0.55))
                                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        viewModel.categorySelected = category.rawValue
                                        searchText = ""
                                        
                                        // Update the champions array with the filtered champions by tags
                                        champions = filteredChampionsByTags
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                    .onAppear {
                        // Fetch champions when the view appears
                        throttler.throttle {
                            viewModel.fetchChampions(networkLayer: NetworkLayer.shared) { result in
                                switch result {
                                case .success(let fetchedChampions):
                                    champions = fetchedChampions
                                    originalChampionsArray = fetchedChampions
                                case .failure(let error):
                                    // Handle the error (e.g., show an error message)
                                    print("Error fetching champions: \(error)")
                                }
                            }
                        }
                    }
                    VStack(spacing: 20) {
                        ForEach(filteredChampions, id: \.self) { champion in
                            Button(action: {
                                selectedChampion = champion
                                if isModallyPresented {
                                    guard let button = button else { return }
                                    buildController.selectedChampion = champion
                                    buildController.updateBuildController(buttonIndex: button)
                                    dismiss()
                                } else {
                                    shouldShowDetailView = true
                                }
                            }) {
                                ChampionCellView(champion: champion)
                                .background(Color.clear)
                                .listRowBackground(Color.clear)
                            }
                        }
                    }
                    .padding(.top, 24)
                    .ignoresSafeArea()
                    }
                    .background(Color.backgroundColor)
                    .safeAreaInset(edge: .top) {
                        EmptyView()
                            .frame(height: isModallyPresented ? 120 : 100)
                    }
                    .sheet(isPresented: $shouldShowDetailView, content: {
                        if let selectedChampion {
                            ChampionDetailView(championInfo: selectedChampion)
                        } else {
                            Text("Failed")
                                .navigationBarHidden(false)
                        }
                    })
                    .fullScreenCover(isPresented: $shouldShowOnboarding, content: {
                        OnboardingView()
                    })
                    .onAppear {
                        showOnboardingIfNeccisary()
                    }
                    .overlay {
                        NavigationAndSearchBar(searchText: $searchText,
                                               
                        championAction: {
                            
                            
                        }, itemAction: {
                            isItemViewActive.toggle()
                        }, placeholder: "Search for your favorite Champions!", isCompressed: isModallyPresented)
                    }
                    .opacity(isChampionViewActive ? 1 : 0)
                    .fullScreenCover(isPresented: $isItemViewActive) {
                        ItemHomeView()
                    }
                    .navigationBarHidden(true)
            }
    }
    
    func showOnboardingIfNeccisary() -> Bool {
        if UserDefaults.standard.bool(forKey: "shouldShowOnboarding") == false {
            if !UserDefaults.standard.bool(forKey: "shownOnboarding") {
                shouldShowOnboarding = true
            } else {
                shouldShowOnboarding = false
            }
        }
        return shouldShowOnboarding
    }
}



#Preview {
    ChampionHomeView()
        .preferredColorScheme(.dark)
}
