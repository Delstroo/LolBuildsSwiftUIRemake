//
//  ContentView.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/11/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedView: Int = 0

    var body: some View {
        NavigationView {
            VStack {
                switch selectedView {
                case 0:
                    ChampionHomeView()
                case 1:
                    ItemHomeView()
                case 2:
                    BuildsHomeView()
                default:
                    Text("Invalid Selection")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        VStack {
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    selectedView = 0
                                }
                            }) {
                                Text("Champions")
                            }
                            .foregroundColor(selectedView == 0 ? .blue : .primary)
                            
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(width: 100, height: 2)
                                .foregroundStyle(selectedView == 0 ? .blue.opacity(0.80) : .clear)
                        }
                        .padding(.horizontal) // Add padding to the right
                        
                        VStack {
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    selectedView = 1
                                }
                            }) {
                                Text("Items")
                            }
                            .foregroundColor(selectedView == 1 ? .blue : .primary)
                            
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(width: 100, height: 2)
                                .foregroundStyle(selectedView == 1 ? .blue.opacity(0.80) : .clear)
                        }
                        .padding(.horizontal) // Add padding to the right and left
                        
                        VStack {
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    selectedView = 2
                                }
                            }) {
                                Text("Builds")
                            }
                            .foregroundColor(selectedView == 2 ? .blue : .primary)
                            
                            RoundedRectangle(cornerRadius: 25.0)
                                .frame(width: 100, height: 2)
                                .foregroundStyle(selectedView == 2 ? .blue.opacity(0.80) : .clear)
                        }
                        .padding(.leading) // Add padding to the left
                    }
                    .frame(width: UIScreen.main.bounds.width)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
