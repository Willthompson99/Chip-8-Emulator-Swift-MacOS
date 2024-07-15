//
//  DisplayView.swift
//  Chip-8 Emulator Swift MacOS
//
//  Created by Will Thompson on 7/15/24.
//

import SwiftUI

struct DisplayView: View {
    @ObservedObject var chip8: Chip8

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<32, id: \.self) { y in
                HStack(spacing: 0) {
                    ForEach(0..<64, id: \.self) { x in
                        Rectangle()
                            .fill(self.chip8.gfx[y * 64 + x] == 1 ? Color.white : Color.black)
                            .frame(width: geometry.size.width / 64, height: geometry.size.height / 32)
                    }
                }
            }
        }
    }
}

