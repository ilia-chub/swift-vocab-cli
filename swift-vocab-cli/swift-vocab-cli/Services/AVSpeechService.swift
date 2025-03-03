//
//  AVSpeechService.swift
//  swift-vocab-cli
//
//  Created by Ilia Chub on 04.03.2025.
//

import AVFoundation

protocol SpeechService {
    func speak(text: String, language: String)
}

class AVSpeechService: SpeechService {
    init() {}

    func speak(text: String, language: String) {
        let synthesizer = AVSpeechSynthesizer()
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        synthesizer.speak(utterance)
    }
}
