//
//  ContentView.swift
//  Chip-8 Emulator Swift MacOS
//
//  Created by Will Thompson on 7/15/24.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var filePickerViewModel: FilePickerViewModel

    init() {
        let chip8 = Chip8()
        _filePickerViewModel = StateObject(wrappedValue: FilePickerViewModel(chip8: chip8))
    }

    var body: some View {
        VStack {
            Button("Select ROM File") {
                filePickerViewModel.selectFile()
            }
        }
    }
}
