//
//  MarkdownVocabularyLoader.swift
//  swift-vocab-cli
//
//  Created by Ilia Chub on 04.03.2025.
//

import Foundation

protocol VocabularyLoader {
    func loadVocabulary() throws -> [VocabularyItem]
}

enum VocabularyLoaderError: Error {
    case fileNotFound(String)
    case invalidFormat
}

class MarkdownVocabularyLoader: VocabularyLoader {
    private let filePath: String

    init(filePath: String) {
        self.filePath = filePath
    }

    func loadVocabulary() throws -> [VocabularyItem] {
        let fileURL = URL(fileURLWithPath: filePath)
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            throw VocabularyLoaderError.fileNotFound(filePath)
        }

        let data = try Data(contentsOf: fileURL)
        guard let content = String(data: data, encoding: .utf8) else {
            throw VocabularyLoaderError.invalidFormat
        }

        var vocabulary: [VocabularyItem] = []
        let lines = content.components(separatedBy: .newlines)
        for line in lines {
            let components = line.components(separatedBy: ", ")
            if components.count == 2 {
                let item = VocabularyItem(english: components[0], russian: components[1])
                vocabulary.append(item)
            }
        }
        return vocabulary
    }
}
