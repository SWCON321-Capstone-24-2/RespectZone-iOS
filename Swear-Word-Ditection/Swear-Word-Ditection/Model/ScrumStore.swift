//
//  ScrumStore.swift
//  Swear-Word-Ditection
//
//  Created by 민 on 10/22/24.
//

import Foundation

@MainActor
class ScrumStore: ObservableObject {
    @Published var scrums: [SpaceConversation] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("scrums.data")
    }
    
    func load() async throws {
        let task = Task<[SpaceConversation], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else { return [] }
            let dailyScrums = try JSONDecoder().decode([SpaceConversation].self, from: data)
            return dailyScrums
        }
        let scrums = try await task.value
        self.scrums = scrums
    }
    
    func save(scrums: [SpaceConversation]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(scrums)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}