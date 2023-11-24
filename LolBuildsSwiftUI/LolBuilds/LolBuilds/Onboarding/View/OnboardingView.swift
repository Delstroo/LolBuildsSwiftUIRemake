//
//  OnboardingView.swift
//  LolBuilds
//
//  Created by Delstun McCray on 11/10/23.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    let onboardingData: [OnboardingItem] = [
        OnboardingItem(title: "Welcome to LolBuilds", description: "Explore the world of League of Legends with LolBuilds. This app is your ultimate guide to champions, items, and builds in the League of Legends universe.", imageName: "onboarding1"),
        OnboardingItem(title: "Discover Champions", description: "Dive into the vast array of League of Legends champions. Learn about their skins, lore, abilities, and gain insights on how to play or counter them", imageName: "onboarding2"),
        OnboardingItem(title: "Explore In-Game Items", description: "Explore a world of in-game items in your app. Whether they're in the game or not, you can find detailed information about each one, including their gold value and descriptions.", imageName: "onboarding3"),
        OnboardingItem(title: "Craft Your Ultimate Build", description: "You can create the ultimate builds by combining champions and items in your app. Test your theorycrafting skills and devise powerful combinations for victory. Get ready to create the most powerful strategies for your champions!", imageName: "onboarding4")
    ]

    @State private var currentPage: Int = 0

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<onboardingData.count) { index in
                    OnboardingPageView(onboardingItem: onboardingData[index])
                        .tag(index)
                        .ignoresSafeArea()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .ignoresSafeArea()

            HStack {
                Button(action: {
                    withAnimation {
                        if currentPage < onboardingData.count - 1 {
                            currentPage += 1
                        } else {
                            dismiss()
                        }
                    }
                }) {
                    if currentPage == onboardingData.count - 1 {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 200, height: 45, alignment: .center)
                            .overlay {
                                Text("Finish")
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                    .cornerRadius(8)
                            }
                            .foregroundStyle(Color.onboardingBlue)
                            .padding()
                    } else {
                        RoundedRectangle(cornerRadius: 15)
                            .frame(width: 200, height: 45, alignment: .center)
                            .overlay {
                                Text("Continue")
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                    .cornerRadius(8)
                            }
                            .foregroundStyle(Color.onboardingBlue)
                            .padding()
                    }
                }
            }
            .ignoresSafeArea()
            .padding(.horizontal)
            .background(.clear)
        }
        .onAppear {
            UserDefaults.standard.setValue(false, forKey: "shouldShowOnboarding")
            UserDefaults.standard.setValue(true, forKey: "shownOnboarding")
        }
        .background {
            Image(onboardingData[currentPage].imageName)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
                .animation(.easeInOut)
        }
        .background(Color.backgroundColor)
        .ignoresSafeArea()
    }
}


struct OnboardingPageView: View {
    let onboardingItem: OnboardingItem

    var body: some View {
        VStack {
            VStack {
                Spacer()
                Text(onboardingItem.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                
                Text(onboardingItem.description)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .padding(.horizontal)
            }
            .padding(.vertical, 70)
            
        }
        .padding()
    }
}


struct OnboardingItem {
    let title: String
    let description: String
    let imageName: String
}

#Preview {
    OnboardingView()
        .preferredColorScheme(.dark)
}
