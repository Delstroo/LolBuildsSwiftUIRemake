//
//  TabBar.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/16/23.
//

import SwiftUI

struct TabBar: View {
    
    var championAction: () -> Void
    var itemAction: () -> Void
    
    var body: some View {
        ZStack {
            // MARK: Arc Shape
            Arc()
                .fill(Color.championCardBlueHint.opacity(0.75))
                .frame(height: 88)
                .overlay {
                    
                    Arc()
                        .stroke(Color.pink, lineWidth: 0.5)
                }
            
            HStack {
                // MARK: Expand Button
                Button {
                    championAction()
                } label: {
                    Image(systemName: "mappin.and.ellipse")
                        .frame(width: 44, height: 44)
                }
                
                Spacer()
                
                // MARK: Navigation Button
                Button {
                    itemAction()
                } label: {
                    Image(systemName: "list.star")
                        .frame(width: 44, height: 44)
                }
            }
            .font(.title2)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 20, leading: 32, bottom: 24, trailing: 32))
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
}

#Preview {
    TabBar(championAction: {}, itemAction: {})
}
