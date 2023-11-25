//
//  ChampionDetailView.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/13/23.
//

import SwiftUI

struct ChampionDetailView: View {
    @State var champion: ChampionData?
    @State var championInfo: ChampionInfo
    @StateObject private var viewModel: ChampionDetailViewModel = ChampionDetailViewModel()
    
    var body: some View {
        ScrollView {
            if let champion = viewModel.champion {
                VStack(alignment: .center, spacing: 12) {
                    ChampionDetailImageView(champion: champion)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.29)
                    VStack {
                        // MARK: Name & Title
                            Text(champion.name)
                                .font(.system(size: 32).weight(.bold))
                                .foregroundStyle(Color.label)
                                .padding(.leading)
                            
                            Text(champion.title)
                                .font(.title2.weight(.semibold))
                                .foregroundStyle(Color.secondaryLabel)
                                .padding(.leading)
                        
                        // MARK: Champion tags ex: [Assasin, Marksman]
                        HStack(spacing: 8, content: {
                            ForEach(champion.tags, id: \.self) { tag in
                                Text("  \(tag)  ")
                                    .padding(4)
                                    .innerShadow(shape: RoundedRectangle(cornerRadius: 25), color: Color(tag), blur: 3, opacity: 1)
                                    .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color(tag), lineWidth: 2)
                                    )
                            }
                        })
                        
                        // MARK: Champion Lore
                        Text(champion.lore)
                            .font(.headline.weight(.medium))
                            .foregroundStyle(Color.secondary)
                            .padding()
                    }
                    
                    // MARK: DropDowns
                    VStack(alignment: .leading) {
                        ChampionDetailViewDropDown(champion: champion)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchChampionDetail(networkLayer: NetworkLayer.shared, champion: championInfo) { result in
                switch result {
                case .success(let fetchedChampion):
                    champion = fetchedChampion
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        .background(Color.backgroundColor)
    }
}

#Preview {
    ChampionDetailView(champion: ChampionData.hardcodedChampionData, championInfo: ChampionInfo.mockData)
        .preferredColorScheme(.dark)
}
