//
//  BuildsCell.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/23/23.
//

import SwiftUI
import Combine

struct BuildsCell: View {
    @EnvironmentObject var buildController: BuildController
@Namespace private var animation
    @Environment(\.colorScheme) var colorScheme
    @State var build: Build
    @State private var itemImages: [UIImage?] = Array(repeating: nil, count: 6)
    @State private var championImage: UIImage?
    @State private var fullChampionImage: UIImage?
    @State private var selectedItemButton: Int = 0
    @State private var selectedChampionButton: Int = 0
    @State var isZoomed = false
    @State private var editedTitle: String = ""
    @State private var selectedBuildIndex: Build?
    @State private var selectedItem: Items?
    @State var index: Int = 0

    // MARK: Actions
    var itemAction: () -> Void
    var championAction: () -> Void

    var body: some View {
        VStack {
            if isZoomed {
                expandedView
                    .background(Color.secondarySystemBackground)
                    .buttonStyle(BorderlessButtonStyle())
            } else {
                collapsedView
                    .onTapGesture {
                        withAnimation(.spring()) {
                            isZoomed.toggle()
                        }
                    }
            }
        }
        .onChange(of: buildController.shouldUpdateBuild) { newValue in
            if index == buildController.selectedBuildIndex {
                buildController.builds = []
                buildController.loadFromPersistenceStore()
                if newValue {
                    if let champion = buildController.selectedChampion {
                        let imageURL = "\(URL.championImageURL)\(champion.image.full)"
                        fetchChampionImage(url: imageURL)
                    }
                    if let items = buildController.selectedItem {
                        let imageURL = "\(URL.itemImageURL)\(items.image.full)"
                        fetchItemImage(url: imageURL, index: buildController.selectedItemButton)
                    }
                    buildController.shouldUpdateBuild = false
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 25.0))
        .padding()
    }

    @ViewBuilder
    var collapsedView: some View {
        VStack {
            championButton
                .padding(.top)
                .onAppear {
                    if let champion = build.championButton {
                        let imageURL = "\(URL.championImageURL)\(champion.image.full)"
                        fetchChampionImage(url: imageURL)
                    }
                }
            
            Text(build.title)
                .font(.title)
                .padding()
            
            HStack {
                ForEach(0..<6) { index in
                    buildButton(index, frame: 50)
                        .matchedGeometryEffect(id: "item_\(index)\(buildController.selectedBuildIndex)", in: animation)
                }
            }
            .padding(.horizontal)
        }
        .background(Color.secondarySystemBackground)
    }

    @ViewBuilder
    var expandedView: some View {
        ScrollView {
        VStack {
            if isZoomed {
                VStack {
                    championButton
                        .padding(.top, 8)
                    
                    Text(build.title)
                        .font(.title)
                        .padding()
                    
                    
                    VStack(alignment: .leading) {
                        ForEach(0..<6) { index in
                            HStack {
                                buildButton(index, frame: 75)
                                    .matchedGeometryEffect(id: "item_\(index)\(buildController.selectedBuildIndex)", in: animation)
                                    .padding(.horizontal, 6)
                                if build.items[index]?.description != "" {
                                    Text(build.items[index]?.description.stripHTML() ?? "")
                                        .lineLimit(10)
                                        .font(.subheadline)
                                } else {
                                    Text(build.items[index]?.plaintext.stripHTML() ?? "")
                                        .lineLimit(10)
                                        .font(.subheadline)
                                }
                            }
                            .padding(6)
                        }
                    }
                }
                .background(Color.secondarySystemBackground)
                .buttonStyle(BorderlessButtonStyle())
            } else {
                collapsedView
                    .background(.fighter)
            }
        }
    }
        .onTapGesture {
            withAnimation(.spring()) {
                isZoomed.toggle()
            }
        }
    }

    
    @ViewBuilder
    func buildButton(_ index: Int, frame: CGFloat) -> some View {
        Button(action: {
            selectedItem = build.items[index]
            buildController.selectedItemButton = index
            itemAction()
        }) {
            if let itemImage = itemImages[index] {
                Image(uiImage: itemImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: frame, height: frame)
                    .cornerRadius(10)
            } else {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: frame, height: frame)
                    .cornerRadius(10)
            }
        }
        .matchedGeometryEffect(id: "item_\(index)_\(build.id)", in: animation, isSource: buildController.selectedItemButton == index)
        .onAppear {
            if let items = build.items[index] {
                let imageURL = "\(URL.itemImageURL)\(items.image.full)"
                fetchItemImage(url: imageURL, index: index)
            }
        }
    }

    @ViewBuilder
    var championButton: some View {
        Button(action: {
            championAction()
        }) {
            if let championImage = isZoomed ? fullChampionImage : championImage {
                ZStack {
                    if isZoomed {
                        Image(uiImage: championImage)
                            .resizable()
                            .blur(radius: 10)
                            .opacity(0.8)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width + 10)
                            .cornerRadius(23)
                        
                        Image(uiImage: championImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width)
                            .cornerRadius(20)
                    } else {
                        Image(uiImage: championImage)
                            .resizable()
                            .blur(radius: 10)
                            .opacity(0.8)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 140, height: 140)
                            .cornerRadius(23)
                        
                        Image(uiImage: championImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 120, height: 120)
                            .cornerRadius(20)
                    }
                }
            } else {
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                    .border(Color.black, width: 3)
            }
        }
        .matchedGeometryEffect(id: "image", in: animation)
        .onAppear {
            if let champion = build.championButton {
                let imageURL = "\(URL.championImageURL)\(champion.image.full)"
                fetchChampionImage(url: imageURL)
            }
        }
        .onAppear {
            if let champion = build.championButton {
                let imageURL = "\(URL.championSplashURL)\(champion.image.full.replacingOccurrences(of: ".png", with: "_0.jpg"))"
                fetchChampionImage(url: imageURL)
            }
        }
    }

    func fetchItemImage(url: String, index: Int) {
        guard let imageURL = URL(string: url) else { return }
        NetworkLayer.shared.fetchImage(from: imageURL) { result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    if let image = UIImage(data: imageData) {
                        itemImages[index] = image
                    }
                }
            case .failure(let error):
                print("Failed to fetch item image: \(error)")
            }
        }
    }

    func fetchChampionImage(url: String) {
        guard let imageURL = URL(string: url) else { return }
        NetworkLayer.shared.fetchImage(from: imageURL) { result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    if let image = UIImage(data: imageData) {
                        if imageURL.absoluteString.contains("_0.jpg") {
                            fullChampionImage = image
                        } else {
                            championImage = image
                        }
                    }
                }
            case .failure(let error):
                print("Failed to fetch champion image: \(error)")
            }
        }
    }
}

#Preview {
    BuildsCell(build: Build.mockBuild, itemAction: {}, championAction: {})
        .preferredColorScheme(.dark)
}
