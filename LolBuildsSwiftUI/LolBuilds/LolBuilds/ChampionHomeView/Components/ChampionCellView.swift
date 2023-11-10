//
//  ChampionCellView.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/12/23.
//

import SwiftUI

struct ChampionCellView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var championImage: UIImage? // Or use an appropriate image type
    
    var champion: ChampionInfo

    
    // Use mockChampionData as your mock data
    //http://ddragon.leagueoflegends.com/cdn/img/champion/loading/Chogath_0.jpg
    
    
    var body: some View {
        ZStack {
            if let data = champion.tags.description.data(using: .utf8),
               let tagsArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [String] {
                    
                if tagsArray.count >= 2 {
                    let tag1 = tagsArray[0]
                    let tag2 = tagsArray[1]
                    
                    // Now you can use tag1 and tag2 to create your colors
                    let color1 = Color(tag1)
                    let color2 = Color(tag2)
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            AngularGradient(
                                gradient: Gradient(colors: [color1, color2]),
                                center: .zero,
                                startAngle: .degrees(0),
                                endAngle: .degrees(90)
                            )
                        )
                    
                        .frame(width: UIScreen.main.bounds.width - 16, height: 172)
                        .blur(radius: colorScheme == .dark ? 15 : 1)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .clipped()
                        .shadow(color: .label.opacity(colorScheme == .light ? 0.33 : 0.02), radius: 15)
                } else {
                    // Default to blue color when there are fewer than 2 tags
                    let color = Color(tagsArray.first!)
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(color)
                        .frame(width: UIScreen.main.bounds.width - 16, height: 172)
                        .blur(radius: colorScheme == .dark ? 15 : 1)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .clipped()
                        .shadow(color: .label.opacity(colorScheme == .light ? 0.33 : 0.02), radius: 15)

                }
            }

            
            HStack(alignment: .top) {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.black.opacity(0.33))
                        .frame(width: 80, height: 145)
                    
                    if let championImage = championImage {
                        Image(uiImage: championImage)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 145)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                                .offset(x: 5, y: 5)
                    } else {
                        ProgressView()
                            .frame(width: 80, height: 80)
                    }
                 }
                .padding(.leading, 8)
                
                
                Spacer()
                
                    VStack(alignment: .trailing, spacing: 4) {
                        Text(champion.name)
                            .font(.system(size: 32).weight(.bold))
                            .frame(alignment: .top)
                            .foregroundStyle(Color.white)
                        
                        Text(champion.title)
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(Color.white.opacity(70))
                        
                    }
                    .padding(.trailing, 8)
            }
        }
        .onAppear {
            let championName = champion.image.full.replacingOccurrences(of: ".png", with: "_0.jpg")
            
            let imageURL = "\(URL.championLoadingSplashURL)\(championName)"
            fetchChampionImage(url: imageURL)
        }
        .frame(width: UIScreen.main.bounds.width - 16, height: 172)
    }
    
    func fetchChampionImage(url: String) {
        
        guard let imageUrl = URL(string: url) else { return }
        
        NetworkLayer.shared.fetchImage(from: imageUrl) { result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    if let image = UIImage(data: imageData) {
                        championImage = image
                    }
                }
            case .failure(let error):
                print("Failed to fetch image: \(error)")
            }
        }
    }
}



#Preview {
    ChampionCellView(champion: ChampionInfo.mockData)
        .preferredColorScheme(.dark)
}
