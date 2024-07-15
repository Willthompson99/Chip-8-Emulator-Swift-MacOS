//
//  Chip8.swift
//  Chip-8 Emulator Swift MacOS
//
//  Created by Will Thompson on 7/15/24.
//

import Foundation

class Chip8: ObservableObject {
    var memory: [UInt8] = Array(repeating: 0, count: 4096)
    var V: [UInt8] = Array(repeating: 0, count: 16)
    var I: UInt16 = 0
    var pc: UInt16 = 0x200
    @Published var gfx: [UInt8] = Array(repeating: 0, count: 64 * 32)
    var delayTimer: UInt8 = 0
    var soundTimer: UInt8 = 0
    var stack: [UInt16] = []
    var sp: UInt16 = 0

    init() {
        reset()
    }

    func reset() {
        memory = Array(repeating: 0, count: 4096)
        V = Array(repeating: 0, count: 16)
        I = 0
        pc = 0x200
        gfx = Array(repeating: 0, count: 64 * 32)
        delayTimer = 0
        soundTimer = 0
        stack = []
        sp = 0
        loadFontset()
    }

    private func loadFontset() {
        let fontSet: [UInt8] = [ /* Font data here */ ]
        for i in 0..<fontSet.count {
            memory[0x050 + i] = fontSet[i]
        }
    }

    func loadProgram(from url: URL) {
        do {
            let data = try Data(contentsOf: url)
            loadProgram(data)
        } catch {
            print("Failed to load ROM: \(error)")
        }
    }

    private func loadProgram(_ data: Data) {
        for (index, byte) in data.enumerated() {
            memory[Int(pc) + index] = byte
        }
    }
}
