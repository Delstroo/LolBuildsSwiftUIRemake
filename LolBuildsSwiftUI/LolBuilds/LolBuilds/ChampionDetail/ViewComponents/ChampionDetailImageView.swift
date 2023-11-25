//
//  ChampionDetailImageView.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/13/23.
//

import SwiftUI

struct ImageWithOrder {
    let image: UIImage?
    let order: Int
}


struct ChampionDetailImageView: View {
    @Environment(\.colorScheme) var colorScheme

    var champion: ChampionData
    @State private var championImages: [UIImage?] = [] // Array to hold images for each skin
    @State private var selectedTabIndex = 0

    var body: some View {
        ZStack {
            if championImages.isEmpty {
                ProgressView()
                    .frame(width: 80, height: 80, alignment: .center)
            }

            TabView(selection: $selectedTabIndex) {
                ForEach(championImages.indices, id: \.self) { index in
                    ZStack {
                        ZStack(alignment: .center) {
                            Image(uiImage: championImages[index] ?? UIImage()) // Display the fetched image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .blur(radius: 10)
                                .opacity(0.8)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.49)
                            
                            ZStack(alignment: .bottomLeading) {
                                Image(uiImage: championImages[index] ?? UIImage())
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.69)
                                
                                
                                
                                ZStack {
                                    if champion.skins[index].name == "default" {
                                        Text("  Default  ")
                                            .font(.title2.weight(.semibold))
                                            .foregroundStyle(.white)
                                            .padding(4)
                                            .innerShadow(shape: RoundedRectangle(cornerRadius: 25), color: Color.black, blur: 3, opacity: 1)
                                            .background(.black.opacity(0.65))
                                            .clipShape(RoundedRectangle(cornerRadius: 25))
                                            .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color.black, lineWidth: 2)
                                            )
                                            .padding(8)
                                    } else {
                                        Text("  \(champion.skins[index].name)  ")
                                            .font(.title2.weight(.semibold))
                                            .foregroundStyle(.white)
                                            .padding(4)
                                            .innerShadow(shape: RoundedRectangle(cornerRadius: 25), color: Color.black, blur: 3, opacity: 1)
                                            .background(.black.opacity(0.65))
                                            .clipShape(RoundedRectangle(cornerRadius: 25))
                                            .overlay(
                                            RoundedRectangle(cornerRadius: 25)
                                                .stroke(Color.black, lineWidth: 2)
                                            )
                                            .padding(8)
                                    }
                                }
                            }
                        }

                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
        .onAppear {
            let sortedSkins = champion.skins.sorted { $0.id < $1.id }
            let dispatchGroup = DispatchGroup()
            var imageResults: [ImageWithOrder] = []

            for (index, skin) in sortedSkins.enumerated() {
                dispatchGroup.enter()

                let imageURL = URL(string: "\(URL.championSplashURL)\(champion.image.full.replacingOccurrences(of: ".png", with: "_\(skin.num).jpg"))")
                fetchChampionImage(url: imageURL, order: index) { imageWithOrder in
                    imageResults.append(imageWithOrder)
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) {
                let sortedImages = imageResults.sorted { $0.order < $1.order }
                championImages = sortedImages.compactMap { $0.image }
            }
        }

    }

    func fetchChampionImage(url: URL?, order: Int, completion: @escaping (ImageWithOrder) -> Void) {
        guard let imageURL = url else {
            completion(ImageWithOrder(image: nil, order: order))
            return
        }

        NetworkLayer.shared.fetchImage(from: imageURL) { result in
            var image: UIImage?
            switch result {
            case .success(let imageData):
                image = UIImage(data: imageData)
            case .failure(let error):
                print("Failed to fetch image: \(error)")
            }
            let imageWithOrder = ImageWithOrder(image: image, order: order)
            completion(imageWithOrder)
        }
    }

}

#Preview {
    ChampionDetailImageView(champion: ChampionData.hardcodedChampionData)
        .preferredColorScheme(.dark)
}
