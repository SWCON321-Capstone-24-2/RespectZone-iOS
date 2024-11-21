//
//  LottieView.swift
//  Swear
//
//  Created by 민 on 11/17/24.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    @Binding var isPlaying: Bool
    var animationName: String
    var loopMode: LottieLoopMode

    class Coordinator {
        var animationView: LottieAnimationView?
        var currentAnimationName: String? // 현재 로드된 애니메이션 이름을 저장
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }

    func makeUIView(context: Context) -> UIView {
        let containerView = UIView()
        let animationView = LottieAnimationView(name: animationName)
        context.coordinator.animationView = animationView
        context.coordinator.currentAnimationName = animationName

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
        guard let animationView = context.coordinator.animationView else { return }

        if context.coordinator.currentAnimationName != animationName {
            context.coordinator.currentAnimationName = animationName
            animationView.animation = LottieAnimation.named(animationName)
            if isPlaying {
                animationView.play()
            }
        } else if isPlaying && !animationView.isAnimationPlaying {
            animationView.play()
        } else if !isPlaying {
            animationView.stop()
        }
    }
}
