//
//  ItemCellView.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/17/23.
//

import SwiftUI

struct ItemCellView: View {
    var item: Items
    var width = UIScreen.main.bounds.width * 0.40
    @State private var itemImage: UIImage?

    var body: some View {
        ZStack(alignment: .top) {
            if let itemImage {
                Image(uiImage: itemImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 10)
                    .opacity(0.8)
                    .frame(width: width + 12, height: width + 6)
                    .padding(.top, -6)
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: width, height: width / 0.667)
                    .foregroundStyle(Color.secondarySystemBackground.opacity(0.75))
                VStack(alignment: .center, spacing: 8) {
                    Image(uiImage: itemImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                    
                    Text(item.name)
                        .multilineTextAlignment(.center)
                        .font(.title3.weight(.semibold))
                        .bold()
                        .foregroundColor(Color.label)
                        .frame(width: width - 16, alignment: .center)
                        .padding(.leading, 8)
                        .padding(.bottom, 20)
                        .lineLimit(3)
                }
                
            } else {
                ProgressView()
                    .frame(width: width, height: width / 0.667)
            }
        }
        .onAppear {
            let imageURL = "\(URL.itemImageURL)\(item.image.full)"
            
            fetchItemImage(url: imageURL)
        }
    }
    
    func fetchItemImage(url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        NetworkLayer.shared.fetchImage(from: imageURL) { result in
            switch result {
            case .success(let imageData):
                DispatchQueue.main.async {
                    if let image = UIImage(data: imageData) {
                        itemImage = image
                    }
                }
            case .failure(let error):
                print("Failed to fetch image: \(error)")
            }
        }
    }
}

#Preview {
    ItemCellView(item: Items.mockItem)
}
