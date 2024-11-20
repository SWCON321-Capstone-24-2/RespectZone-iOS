//
//  LottieView.swift
//  Swear
//
//  Created by 민 on 11/17/24.
//

import Combine
import SwiftUI

import Lottie

struct LottieView: UIViewRepresentable {
    @Binding var isPlaying: Bool
    let animationName: String
    let loopMode: LottieLoopMode

    func makeUIView(context: Context) -> UIView {
        let containerView = UIView()
        let animationView = LottieAnimationView(name: animationName)
        
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = loopMode
        animationView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: containerView.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
        
        if isPlaying {
            animationView.play()
        }

        return containerView
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let animationView = uiView.subviews.first as? LottieAnimationView {
            if isPlaying {
                animationView.play()
            } else {
                animationView.stop()
            }
        }
    }
}
