//
//  FilePickerViewModel.swift
//  Chip-8 Emulator Swift MacOS
//
//  Created by Will Thompson on 7/15/24.
//

import Foundation

class FilePickerViewModel: ObservableObject {
    @Published var chip8: Chip8
    
    init(chip8: Chip8) {
        self.chip8 = chip8
    }

    func selectFile() {
        Utility.openFilePicker { url in
            DispatchQueue.main.async {
                if let url = url {
                    self.chip8.loadProgram(from: url)
                }
            }
        }
    }
}

