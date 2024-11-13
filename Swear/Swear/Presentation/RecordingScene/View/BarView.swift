//
//  BarView.swift
//  Swear
//
//  Created by 민 on 10/29/24.
//

import SwiftUI

struct BarView: View {
    @State var value: CGFloat = 0.2
    @State var category: String = "성별 혐오"
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Capsule()
                    .frame(width: 25, height: 130)
                    .foregroundColor(.gray)
                Capsule()
                    .frame(width: 25, height: value*130)
                    .foregroundColor(value >= 0.8 ? .red : .white)
            }
            Text(category)
                .font(.subheadline)
                .padding(.top, 8)
        }
    }
}

#Preview {
    BarView()
}
