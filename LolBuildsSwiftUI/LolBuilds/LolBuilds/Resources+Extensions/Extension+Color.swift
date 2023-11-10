//
//  Extension+Color.swift
//  LolBuilds
//
//  Created by Delstun McCray on 10/12/23.
//

import SwiftUI
import UIKit
import CoreImage

public extension Color {
    static let lightText = Color(UIColor.lightText)
    static let darkText = Color(UIColor.darkText)

    static let label = Color(UIColor.label)
    static let secondaryLabel = Color(UIColor.secondaryLabel)
    static let tertiaryLabel = Color(UIColor.tertiaryLabel)
    static let quaternaryLabel = Color(UIColor.quaternaryLabel)

    static let systemBackground = Color(UIColor.systemBackground)
    static let secondarySystemBackground = Color(UIColor.secondarySystemBackground)
    static let tertiarySystemBackground = Color(UIColor.tertiarySystemBackground)

    static let backgroundColor = Color("backGroundColor")
}

extension View {
    func backgroundBlur(radius: CGFloat = 3, opaque: Bool = false) -> some View {
        self.background(Blur(radius: radius, opaque: opaque))
    }
}

extension View {
    func innerShadow<S: Shape, SS: ShapeStyle>(shape: S, color: SS, lineWidth: CGFloat = 1, offsetX: CGFloat = 0, offsetY: CGFloat = 0, blur: CGFloat = 4, blendMode: BlendMode = .normal, opacity: Double = 1) -> some View {
        return self
            .overlay {
                shape
                    .stroke(color, lineWidth: lineWidth)
                    .blendMode(blendMode)
                    .offset(x: offsetX, y: offsetY)
                    .blur(radius: blur)
                    .mask(shape)
                    .opacity(opacity)
            }
    }
}

extension UIImage {
    func dominantColor() -> Color? {
        guard let cgImage = self.cgImage else {
            return nil
        }
        
        let ciImage = CIImage(cgImage: cgImage)
        
        let filter = CIFilter(name: "CIAreaAverage")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        if let outputImage = filter?.outputImage {
            var bitmap = [UInt8](repeating: 0, count: 4)
            let context = CIContext()
            context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: CIFormat.RGBA8, colorSpace: nil)
            
            return Color(
                red: Double(bitmap[0]) / 255.0,
                green: Double(bitmap[1]) / 255.0,
                blue: Double(bitmap[2]) / 255.0
            )
        }
        
        return nil
    }
}

extension View {
    func blurryBorder(
        width: CGFloat = 1,
        cornerRadius: CGFloat = 10,
        color: Color = .white,
        blurRadius: CGFloat = 10
    ) -> some View {
        self.overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(color, lineWidth: width)
        )
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(Color.clear)
                .blur(radius: blurRadius)
        )
    }
}


extension View {
    func dynamicShadow() -> some View {
        ZStack {
            self // Place the original view
            Color.black
                .opacity(0.2) // Adjust the opacity of the shadow
                .blendMode(.multiply)
                .background(self)
                .mask(self)
        }
    }
}

extension String {
    func stripHTML() -> String {
        let strippedString = self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        return strippedString
    }
}
