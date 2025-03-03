//
//  EnglishLearnerApp.swift
//  swift-vocab-cli
//
//  Created by Ilia Chub on 04.03.2025.
//

class EnglishLearnerApp {
    private let vocabularyLoader: VocabularyLoader
    private let speechService: SpeechService
    private let terminalIO: TerminalIO

    init(vocabularyLoader: VocabularyLoader, speechService: SpeechService, terminalIO: TerminalIO) {
        self.vocabularyLoader = vocabularyLoader
        self.speechService = speechService
        self.terminalIO = terminalIO
    }

    func run() {
        do {
            let vocabulary = try vocabularyLoader.loadVocabulary()
            let quizManager = VocabularyQuizManager(
                vocabulary: vocabulary,
                speechService: speechService,
                terminalIO: terminalIO
            )
            quizManager.startQuiz()
        } catch {
            terminalIO.printMessage("Error loading vocabulary: \(error)")
        }
    }
}
