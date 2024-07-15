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
            DisplayView(chip8: filePickerViewModel.chip8)
                .frame(width: 640, height: 320)
                .background(Color.black)
        }
        .onAppear {
            filePickerViewModel.chip8.run()
        }
    }
}
