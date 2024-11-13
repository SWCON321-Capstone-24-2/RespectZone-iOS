//
//  DetailViewModel.swift
//  Swear
//
//  Created by 민 on 11/13/24.
//

import SwiftUI
import Combine

final class DetailViewModel: ObservableObject {
    
    private let service = BaseService.shared

    func postCreateSpeechWithAPI() async {
        do {
//            let response = try await service.getSpechSentenceList(id: <#T##Int#>)
        } catch {
            print("Delete Speech Error :", error)
        }
    }
}
