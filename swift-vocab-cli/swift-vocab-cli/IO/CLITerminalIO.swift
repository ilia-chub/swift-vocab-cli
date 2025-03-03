//
//  CLITerminalIO.swift
//  swift-vocab-cli
//
//  Created by Ilia Chub on 04.03.2025.
//

import Darwin

protocol TerminalIO {
    func printMessage(_ message: String)
    func readInput() -> String
}

class CLITerminalIO: TerminalIO {
    func printMessage(_ message: String) {
        print(message)
    }

    func readInput() -> String {
        return readLine() ?? ""
    }
}
