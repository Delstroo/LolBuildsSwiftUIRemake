//
//  NavigationBar.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/12/23.
//

import SwiftUI

struct NavigationAndSearchBar: View {
    @Binding var searchText: String
    var championAction: () -> Void
    var itemAction: () -> Void
    var placeholder: String
    @State var isCompressed: Bool = false
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
               
                EmptyView()
                .frame(height: 50)
            }
            .frame(height: isCompressed ? 0 : 50)
            
            Divider()
            
            HStack(spacing: 2) {
                Image(systemName: "magnifyingglass")
                
                TextField(placeholder, text: $searchText)
            }
            .foregroundColor(.secondary)
            .padding(.horizontal, 6)
            .padding(.vertical, 7)
            .frame(height: 36, alignment: .leading)
            .background(Color.secondaryLabel.opacity(0.25), in: RoundedRectangle(cornerRadius: 10))
            .innerShadow(shape: RoundedRectangle(cornerRadius: 10), color: .black.opacity(0.25), lineWidth: 2, offsetX: 0, offsetY: 2, blur: 2)
        }
        .frame(height: isCompressed ? 70 : 106, alignment: .top)
        .padding(.horizontal, 16)
        .padding(.top, 49)
        .backgroundBlur(radius: 20, opaque: true)
//        .background(Color.navBarBackground)
        .frame(maxHeight: .infinity, alignment: .top)
        .ignoresSafeArea()
    }
}

#Preview {
    NavigationAndSearchBar(searchText: .constant(""), championAction: {}, itemAction: {}, placeholder: "Search for your favorite Champions!")
        .preferredColorScheme(.dark)
}
