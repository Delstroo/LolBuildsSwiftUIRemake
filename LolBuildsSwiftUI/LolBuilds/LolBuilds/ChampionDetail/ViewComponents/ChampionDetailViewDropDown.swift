//
//  ChampionDetailViewDropDown.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/13/23.
//

import SwiftUI

struct ChampionDetailViewDropDown: View {
    @State var champion: ChampionData
    @StateObject private var viewModel: ChampionDetailViewModel = ChampionDetailViewModel()
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 12) {
            // MARK: Q Ability Toggle
            ZStack {
                Button(action: {
                    withAnimation {
                        viewModel.isQTapped.toggle()
                    }
                }) {
                    
                        
                        HStack {
                            Text("\(champion.name)s Q")
                                .font(.title)
                                .foregroundColor(Color(uiColor: .label))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(8)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.up")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .rotationEffect(.degrees(viewModel.isQTapped ? 0 : 180)) // Rotate 180 degrees when transitioning
                                .padding(.trailing, 8)
                        }
                    }
                .background(RoundedRectangle(cornerRadius: 25))
                .foregroundStyle(Color.clear)
                .innerShadow(shape: RoundedRectangle(cornerRadius: 12), color: Color.label.opacity(0.33), blur: 3, opacity: 1)

                }
            
            .padding(.horizontal, 2)
            .padding(.bottom, 10)

            if viewModel.isQTapped {
                VStack(spacing: 8) {
                    let imageURL = "\(URL.championSpellImageURL)\(champion.spells[0].image.full)"
                    AsyncImage(url:  URL(string: imageURL )) { img in
                        img
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .offset(x: 5, y: 5)
                            .padding(.bottom, 10)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text(champion.spells[0].name)
                            .font(.title3.weight(.semibold))
                            .frame(alignment: .leading)
                        
                        Text(champion.spells[0].description.stripHTML())
                            .font(.subheadline.weight(.regular))
                            .foregroundStyle(Color.secondaryLabel)
                    }
                    .padding(.horizontal, 2)
                    .padding(.bottom, 10)
                    .transition(.opacity) // Add a transition for a smooth fade in/out
                .opacity(viewModel.isQTapped ? 1 : 0)
                } // Set opacity based on the condition
            }
            
            // MARK: W Ability
            
            ZStack {
                Button(action: {
                    withAnimation {
                        viewModel.isWTapped.toggle()
                    }
                }) {
                    
                        
                        HStack {
                            Text("\(champion.name)s W")
                                .font(.title)
                                .foregroundColor(Color(uiColor: .label))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(8)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.up")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .rotationEffect(.degrees(viewModel.isWTapped ? 0 : 180)) // Rotate 180 degrees when transitioning
                                .padding(.trailing, 8)
                        }
                    }
                .background(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(Color.clear)
                .innerShadow(shape: RoundedRectangle(cornerRadius: 12), color: Color.label.opacity(0.33), blur: 3, opacity: 1)

                }
            
            .padding(.horizontal, 2)
            .padding(.bottom, 10)

            if viewModel.isWTapped {
                VStack(spacing: 8) {
                    let imageURL = "\(URL.championSpellImageURL)\(champion.spells[1].image.full)"
                    AsyncImage(url:  URL(string: imageURL )) { img in
                        img
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .offset(x: 5, y: 5)
                            .padding(.bottom, 10)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text(champion.spells[1].name)
                            .font(.title3.weight(.semibold))
                            .frame(alignment: .leading)
                        
                        Text(champion.spells[1].description.stripHTML())
                            .font(.subheadline.weight(.regular))
                            .foregroundStyle(Color.secondaryLabel)
                    }
                    .padding(.horizontal, 2)
                    .padding(.bottom, 10)
                    .transition(.opacity) // Add a transition for a smooth fade in/out
                .opacity(viewModel.isWTapped ? 1 : 0)
                } // Set opacity based on the condition
            }
            
            // MARK: E Ability Toggle
            ZStack {
                Button(action: {
                    withAnimation {
                        viewModel.isETapped.toggle()
                    }
                }) {
                    
                        
                        HStack {
                            Text("\(champion.name)s E")
                                .font(.title)
                                .foregroundColor(Color(uiColor: .label))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(8)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.up")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .rotationEffect(.degrees(viewModel.isETapped ? 0 : 180)) // Rotate 180 degrees when transitioning
                                .padding(.trailing, 8)
                        }
                    }
                .background(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(Color.clear)
                .innerShadow(shape: RoundedRectangle(cornerRadius: 12), color: Color.label.opacity(0.33), blur: 3, opacity: 1)

                }
            
            .padding(.horizontal, 2)
            .padding(.bottom, 10)

            if viewModel.isETapped {
                VStack(spacing: 8) {
                    let imageURL = "\(URL.championSpellImageURL)\(champion.spells[2].image.full)"
                    AsyncImage(url:  URL(string: imageURL )) { img in
                        img
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .offset(x: 5, y: 5)
                            .padding(.bottom, 10)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text(champion.spells[2].name)
                            .font(.title3.weight(.semibold))
                            .frame(alignment: .leading)
                        
                        Text(champion.spells[2].description.stripHTML())
                            .font(.subheadline.weight(.regular))
                            .foregroundStyle(Color.secondaryLabel)
                    }
                    .padding(.horizontal, 2)
                    .padding(.bottom, 10)
                    .transition(.opacity) // Add a transition for a smooth fade in/out
                .opacity(viewModel.isETapped ? 1 : 0)
                } // Set opacity based on the condition
            }
            
            // MARK: R Ability Toggle
            ZStack {
                Button(action: {
                    withAnimation {
                        viewModel.isRTapped.toggle()
                    }
                }) {
                    
                        
                        HStack {
                            Text("\(champion.name)s R")
                                .font(.title)
                                .foregroundColor(Color(uiColor: .label))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(8)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.up")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .rotationEffect(.degrees(viewModel.isRTapped ? 0 : 180)) // Rotate 180 degrees when transitioning
                                .padding(.trailing, 8)
                        }
                    }
                .background(RoundedRectangle(cornerRadius: 12))
                .foregroundStyle(Color.clear)
                .innerShadow(shape: RoundedRectangle(cornerRadius: 12), color: Color.label.opacity(0.33), blur: 3, opacity: 1)

                }
            
            .padding(.horizontal, 2)
            .padding(.bottom, 10)

            if viewModel.isRTapped {
                VStack(spacing: 8) {
                    let imageURL = "\(URL.championSpellImageURL)\(champion.spells[3].image.full)"
                    AsyncImage(url:  URL(string: imageURL )) { img in
                        img
                            .resizable()
                            .scaledToFit()
                            .frame(height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .offset(x: 5, y: 5)
                            .padding(.bottom, 10)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text(champion.spells[3].name)
                            .font(.title3.weight(.semibold))
                            .frame(alignment: .leading)
                        
                        Text(champion.spells[3].description.stripHTML())
                            .font(.subheadline.weight(.regular))
                            .foregroundStyle(Color.secondaryLabel)
                    }
                    .padding(.horizontal, 2)
                    .padding(.bottom, 10)
                    .transition(.opacity) // Add a transition for a smooth fade in/out
                .opacity(viewModel.isRTapped ? 1 : 0)
                } // Set opacity based on the condition
            }
        }
        .padding(.horizontal, 4)
    }
}

#Preview {
    ChampionDetailViewDropDown(champion: ChampionData.hardcodedChampionData)
        .preferredColorScheme(.dark)
}
