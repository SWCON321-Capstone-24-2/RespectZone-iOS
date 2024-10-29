//
//  BarView.swift
//  Swear
//
//  Created by 민 on 10/29/24.
//

import SwiftUI

struct BarView: View {
    @State var value: CGFloat = 0.8
    @State var category: String = "성별 혐오"
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Capsule()
                    .frame(width: 30, height: 130)
                    .foregroundColor(.gray)
                Capsule()
                    .frame(width: 30, height: value*130)
                    .foregroundColor(.teal)
            }
            Text(category)
                .font(.subheadline)
                .foregroundStyle(.gray)
                .padding(.top, 8)
        }
    }
}

#Preview {
    BarView()
}
