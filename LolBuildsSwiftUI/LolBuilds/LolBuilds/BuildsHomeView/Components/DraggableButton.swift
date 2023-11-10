//
//  DraggableButton.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/24/23.
//

import SwiftUI

protocol AddActionDelegate {
    func addBuildAction()
}


struct DraggableButton: View {
    @State private var dragAmount: CGPoint?
    var delegate: AddActionDelegate?
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                
                VStack {
                    Spacer()
                    
                    AddButton(addAction: { delegate?.addBuildAction() })
                        .frame(width: 60, height: 60)
                        .position(dragAmount ?? CGPoint(x: geometry.size.width-34, y: geometry.size.height-100))
                        .gesture(
                        DragGesture()
                            .onChanged { self.dragAmount = $0.location }
                            .onEnded({ value in
                                var currentPosition = value.location
                                
                                if currentPosition.x < (geometry.size.width/2) {
                                    currentPosition.x = 16
                                } else {
                                    currentPosition.x = geometry.size.width - 34
                                }
                                
                                withAnimation(.easeIn(duration: 0.3)) {
                                    dragAmount = currentPosition
                                }
                            })
                        )
                }
            }
        }
    }
}


#Preview {
    DraggableButton()
}
