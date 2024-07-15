//
//  Chip8.swift
//  Chip-8 Emulator Swift MacOS
//
//  Created by Will Thompson on 7/15/24.
//

import Foundation
import AVFoundation

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
    var keypad: [UInt8] = Array(repeating: 0, count: 16)
    var player: AVAudioPlayer?

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

    func run() {
        Timer.scheduledTimer(withTimeInterval: 1.0/60.0, repeats: true) { timer in
            self.emulateCycle()
            self.updateTimers()
        }
    }

    func emulateCycle() {
        let opcode = fetchOpcode()
        decodeAndExecute(opcode)
    }

    private func fetchOpcode() -> UInt16 {
        return UInt16(memory[Int(pc)]) << 8 | UInt16(memory[Int(pc) + 1])
    }

    private func decodeAndExecute(_ opcode: UInt16) {
        // Opcodes decoding logic
    }

    private func updateTimers() {
        if delayTimer > 0 {
            delayTimer -= 1
        }
        if soundTimer > 0 {
            soundTimer -= 1
            if soundTimer == 0 {
                playSound()
            }
        }
    }

    private func playSound() {
        let soundURL = Bundle.main.url(forResource: "beep", withExtension: "wav")!
        player = try? AVAudioPlayer(contentsOf: soundURL)
        player?.play()
    }
}
