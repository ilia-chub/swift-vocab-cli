//
//  VocabularyQuizManager.swift
//  swift-vocab-cli
//
//  Created by Ilia Chub on 04.03.2025.
//

enum TranslationDirection {
    case ruToEn
    case enToRu
}

protocol QuizManager {
    func startQuiz()
}

class VocabularyQuizManager: QuizManager {
    private let vocabulary: [VocabularyItem]
    private let speechService: SpeechService
    private let terminalIO: TerminalIO
    private var incorrectAnswers: [String] = []

    init(vocabulary: [VocabularyItem], speechService: SpeechService, terminalIO: TerminalIO) {
        self.vocabulary = vocabulary
        self.speechService = speechService
        self.terminalIO = terminalIO
    }

    func startQuiz() {
        terminalIO.printMessage("Welcome to the Terminal English Learner!\n")
        terminalIO.printMessage("Choose translation direction:")
        terminalIO.printMessage("Type '1' for Russian → English, or '2' for English → Russian:")

        let choice = terminalIO.readInput()
        let direction: TranslationDirection
        if choice == "1" {
            direction = .ruToEn
        } else if choice == "2" {
            direction = .enToRu
        } else {
            terminalIO.printMessage("Invalid choice. Please try again.\n")
            startQuiz()
            return
        }

        runQuiz(for: direction)
        showSummary()
    }

    private func runQuiz(for direction: TranslationDirection) {
        let items = vocabulary.shuffled()
        for (index, item) in items.enumerated() {
            while terminalIO.readInput() != "1" {
                terminalIO.printMessage("Waiting 1")
            }

            let prompt: String
            let correctAnswer: String
            let promptLanguage: String
            let answerLanguage: String

            switch direction {
            case .ruToEn:
                prompt = item.russian
                correctAnswer = item.english
                promptLanguage = "ru"
                answerLanguage = "en"
            case .enToRu:
                prompt = item.english
                correctAnswer = item.russian
                promptLanguage = "en"
                answerLanguage = "ru"
            }

            terminalIO.printMessage("\n\(index + 1). \(prompt)")
            while true {
                speechService.speak(text: prompt, language: promptLanguage)

                let userAnswer = terminalIO.readInput().trimmingCharacters(in: .whitespacesAndNewlines)

                if userAnswer == "2" {
                    continue
                } else if userAnswer != correctAnswer {
                    terminalIO.printMessage("Incorrect. The correct answer is: \(correctAnswer)")
                    speechService.speak(text: correctAnswer, language: answerLanguage)
                    incorrectAnswers.append("Question \(index + 1): \(prompt) → \(userAnswer)")
                    break
                } else {
                    break
                }
            }
        }
    }

    private func showSummary() {
        terminalIO.printMessage("\nQuiz Summary:")
        if incorrectAnswers.isEmpty {
            terminalIO.printMessage("All answers were correct!")
        } else {
            terminalIO.printMessage("Incorrect answers:")
            incorrectAnswers.forEach { terminalIO.printMessage($0) }
        }
    }
}
