//
//  Utility.swift
//  Chip-8 Emulator Swift MacOS
//
//  Created by Will Thompson on 7/15/24.
//

import Cocoa
import UniformTypeIdentifiers

class Utility {
    static func openFilePicker(completion: @escaping (URL?) -> Void) {
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Select File"
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedContentTypes = [UTType.plainText]

        openPanel.begin { (result) -> Void in
            if result == .OK, let selectedFile = openPanel.url {
                completion(selectedFile)
            } else {
                completion(nil)
            }
        }
    }
}
