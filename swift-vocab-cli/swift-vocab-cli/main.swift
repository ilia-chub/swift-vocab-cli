//
//  main.swift
//  swift-vocab-cli
//
//  Created by Ilia Chub on 04.03.2025.
//

let markdownFilePath: String
if CommandLine.arguments.count > 1 {
    markdownFilePath = CommandLine.arguments[1]
} else {
    markdownFilePath = "/Users/frameorigin/Documents/Obsidian Vault/Education/English/monsters_manual_skeletons_1.md"
}

let vocabularyLoader = MarkdownVocabularyLoader(filePath: markdownFilePath)
let speechService = AVSpeechService()
let terminalIO = CLITerminalIO()

let app = EnglishLearnerApp(
    vocabularyLoader: vocabularyLoader,
    speechService: speechService,
    terminalIO: terminalIO
)
app.run()
