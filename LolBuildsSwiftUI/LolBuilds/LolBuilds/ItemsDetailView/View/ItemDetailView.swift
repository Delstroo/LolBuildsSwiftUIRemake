//
//  SwiftUIView.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/20/23.
//

import SwiftUI

struct ItemDetailView: View {
    @State var item: Items
    @State private var itemImage: UIImage?
    var width = UIScreen.main.bounds.width * 0.65
    var body: some View {
        VStack {
            if let itemImage {
                ZStack(alignment: .center) {
                    Image(uiImage: itemImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .blur(radius: 10)
                        .opacity(0.8)
                        .frame(width: width + 12, height: width + 12)
                        .padding(.top, -6)
                        .background(Color.clear)
                    
                    Image(uiImage: itemImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: width)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .background(Color.clear)
                }
                .padding()
                
                Text(item.name)
                    .font(.title.weight(.bold))
                    .padding(8)
                    .background(Color.clear)
                
                if item.plaintext.isEmpty {
                    Text(item.description.stripHTML().replaceCapitalLetters())
                        .font(.callout)
                        .padding(.horizontal, 8)
                        .background(Color.clear)

                } else {
                    Text(item.plaintext)
                        .font(.callout)
                        .padding(.horizontal, 8)
                        .background(Color.clear)

                }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Base Gold Price:")
                            .font(.title3).fontWeight(.medium)
                            .background(Color.clear)

                        Text("\(item.gold.base)")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(Color.yellow)
                            .background(Color.clear)
                    }
                    .padding(6)
                    .padding(.horizontal, 8)
                    .background(Color.clear)

                    HStack {
                        Text("Total Gold Price:")
                            .font(.title3).fontWeight(.medium)
                            .background(Color.clear)

                        Text("\(item.gold.total)")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(Color.yellow)
                            .background(Color.clear)
                    }
                    .padding(6)
                    .padding(.horizontal, 8)
                    .background(Color.clear)

                    HStack {
                        Text("Selling Gold Price:")
                            .font(.title3).fontWeight(.medium)
                            .background(Color.clear)

                        Text("\(item.gold.sell)")
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(Color.yellow)
                            .background(Color.clear)
                    }
                    .padding(6)
                    .padding(.horizontal, 8)
                    .background(Color.clear)

                }
                .frame(width: UIScreen.main.bounds.width, alignment: .leading)
            }
        }
        .frame(alignment: .top)
        .background(Color.clear)
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
    ItemDetailView(item: Items.mockItem)
        .preferredColorScheme(.dark)
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
