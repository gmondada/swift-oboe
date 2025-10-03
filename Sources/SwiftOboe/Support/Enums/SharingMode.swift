//
//  SharingMode.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

import oboe

public struct SharingMode: Sendable, Equatable {
    let oboeValue: oboe.SharingMode

    public static let exclusive = SharingMode(oboe.SharingMode.Exclusive)
    public static let shared = SharingMode(oboe.SharingMode.Shared)

    init(_ sharingMode: oboe.SharingMode) {
        self.oboeValue = sharingMode
    }
}
