//
//  AddButton.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/24/23.
//

import SwiftUI

struct AddButton: View {
    @State var opacityState: Double = 1
    var addAction: () -> Void

    var body: some View {
        Button {
            addAction()
        } label: {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .shadow(radius: 3)
                .overlay {

                    Image(systemName: "plus")
                        .resizable()
                        .foregroundStyle(.white)
                        .bold()
                        .frame(width: 25, height: 25)
                }
        }
        .disabled(true)
        .opacity(opacityState)
        .onTapGesture {
            addAction()
        }
        .onLongPressGesture(minimumDuration: 0.2) {
            withAnimation(.linear(duration: 0.1)) {
                opacityState = 0.2
            }
            
            withAnimation(.linear(duration: 0.1).delay(0.1)) {
                opacityState = 1
            }
            
        }
    }
}

#Preview {
    AddButton(addAction: { })
}
