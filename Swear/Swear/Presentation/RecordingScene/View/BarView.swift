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
        VStack(alignment: .center) {
            ZStack(alignment: .bottom) {
                Capsule()
                    .frame(width: 30, height: 150)
                    .foregroundColor(isLast ? .cleanblue.opacity(0.25) : .gray.opacity(0.5))
                Capsule()
                    .frame(width: 30, height: value*150)
                    .foregroundColor(value >= 0.75
                                     ? (isLast ? .cleanblue : .red)
                                     : .white)
            }
            
            ZStack(alignment: .top) {
                Text(category)
                    .font(.subheadline)
                    .fontWeight(isLast ? .heavy : .semibold)
                    .foregroundColor(isLast ? .cleanblue : .black)
                    .padding(.top, 8)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(height: 200)
    }
}

#Preview {
    BarView()
}
