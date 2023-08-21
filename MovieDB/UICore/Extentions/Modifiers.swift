//
//  Modifiers.swift
//  MovieDB
//
//  Created by umair irfan on 08/08/2023.
//

import SwiftUI

struct Shimmering: ViewModifier {
    @State private var isAnimating = false
    
    func body(content: Content) -> some View {
        ZStack {
            content
            Rectangle()
                .fill(Color.gray)
                .opacity(0.3)
                .mask(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.clear, Color.white.opacity(0.8), Color.clear]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: 172)
                        .offset(x: isAnimating ? 200 : -150)
                )
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 2.5).repeatForever()) {
                self.isAnimating.toggle()
            }
        }
    }
}
