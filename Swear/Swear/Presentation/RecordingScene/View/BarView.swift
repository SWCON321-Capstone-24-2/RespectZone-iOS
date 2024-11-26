//
//  BarView.swift
//  Swear
//
//  Created by 민 on 10/29/24.
//

import SwiftUI

struct BarView: View {
    var value: Double = 0.2
    var category: String = "성별 혐오"
    var isLast: Bool = false
    
    var body: some View {
        VStack {
            Text("\(Int(value * 100))%")
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(value >= 0.75 ? (isLast ? .cleanblue : .red) : .black)
                .padding(.bottom, 4)
            
            ZStack(alignment: .bottom) {
                Capsule()
                    .frame(width: 36, height: 180)
                    .foregroundColor(isLast ? .cleanblue.opacity(0.15) : .gray.opacity(0.2))
                
                Capsule()
                    .frame(width: 36, height: value * 180)
                    .foregroundStyle(
                        value >= 0.75
                        ? (isLast ? LinearGradient(colors: [.cleanblue, .cyan], startPoint: .bottom, endPoint: .top)
                           : LinearGradient(colors: [.red, .orange], startPoint: .bottom, endPoint: .top))
                        : LinearGradient(colors: [.white, .newWhite], startPoint: .bottom, endPoint: .top)
                    )
                    .shadow(color: value >= 0.75 ? .red.opacity(0.3) : .clear, radius: 5, x: 0, y: 5)
            }
            
            Text(category)
                .font(.subheadline)
                .fontWeight(isLast ? .heavy : .medium)
                .foregroundColor(isLast ? .cleanblue : .black)
                .padding([.top, .bottom], 8)
                .multilineTextAlignment(.center)
                .padding(.top, 4)
        }
        .frame(height: 220)
    }
}

#Preview {
    BarView()
}
