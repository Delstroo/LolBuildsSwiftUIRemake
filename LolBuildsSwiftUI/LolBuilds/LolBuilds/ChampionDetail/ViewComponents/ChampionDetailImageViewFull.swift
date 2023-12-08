//
//  ChampionDetailImageViewFull.swift
//  LolBuilds
//
//  Created by Delstun McCray on 12/2/23.
//

import SwiftUI

struct ChampionDetailImageViewFull: View {
    @Environment(\.dismiss) var dismiss
    var images: [UIImage?]
    @State var selectedIndex: Int
    
    var body: some View {
//        let images = images.map { Image(uiImage: $0!) }
        ZStack(alignment: .topLeading) {
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white.opacity(0.33))
                    .padding(10)
            }
            .padding()
            // Handle displaying the images using selectedIndex and images array
            // You can use selectedIndex and images to show the selected image and others accordingly
            // Example code:
            VStack {
                TabView(selection: $selectedIndex) {
                    ForEach(images.indices, id: \.self) { index in
                        if let image = images[index] {
                            ZoomableScrollView {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                            }
                            .tag(index)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .preferredColorScheme(.dark)
            }
            .gesture(dragGesture)
            .preferredColorScheme(.dark)
        }
    }
    
    // Drag gesture to handle swiping between images
    var dragGesture: some Gesture {
        DragGesture()
            .onEnded { value in
                let threshold: CGFloat = 100 // Threshold to consider swipe
                if value.translation.width > threshold {
                    selectedIndex = max(selectedIndex - 1, 0) // Swipe right to view previous image
                } else if value.translation.width < -threshold {
                    selectedIndex = min(selectedIndex + 1, images.count - 1) // Swipe left to view next image
                }
            }
    }
}

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    private var content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        // set up the UIScrollView
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator  // for viewForZooming(in:)
        scrollView.maximumZoomScale = 20
        scrollView.minimumZoomScale = 1
        scrollView.bouncesZoom = true
        scrollView.backgroundColor = .black
        
        // create a UIHostingController to hold our SwiftUI content
        let hostedView = context.coordinator.hostingController.view!
        hostedView.translatesAutoresizingMaskIntoConstraints = true
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        scrollView.addSubview(hostedView)
        
        // Double tap gesture recognizer for zooming
        let doubleTapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleDoubleTap(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGesture)
        
        return scrollView
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: self.content))
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // update the hosting controller's SwiftUI content
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiView)
    }
    
    // MARK: - Coordinator
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>
        
        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }
        
        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
        
        @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
            guard let scrollView = recognizer.view as? UIScrollView else { return }

            let currentZoomScale = scrollView.zoomScale
            if currentZoomScale > scrollView.minimumZoomScale {
                scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
            } else {
                let zoomRect = zoomRectForScale(scale: scrollView.maximumZoomScale / 7.50, center: recognizer.location(in: scrollView))
                scrollView.zoom(to: zoomRect, animated: true)
            }
        }
        
        func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
            var zoomRect = CGRect.zero
            if let imageView = self.hostingController.view {
                zoomRect.size.height = imageView.frame.size.height / scale
                zoomRect.size.width = imageView.frame.size.width / scale

                let newCenter = imageView.convert(center, from: hostingController.view)
                zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
                zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
            }
            return zoomRect
        }
    }
}

#Preview {
    ChampionDetailImageViewFull(images: [
        UIImage(named: "Aatrox"),
        UIImage(named: "Champion"),
        UIImage(named: "Aatrox"),
    ], selectedIndex: 1)
        .edgesIgnoringSafeArea(.all)
}
