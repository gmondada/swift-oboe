//
//  PrivacySensitiveMode.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

import oboe

public struct PrivacySensitiveMode: Sendable, Equatable {
    let oboeValue: oboe.PrivacySensitiveMode

    public static let unspecified = PrivacySensitiveMode(oboe.PrivacySensitiveMode.Unspecified)
    public static let disabled = PrivacySensitiveMode(oboe.PrivacySensitiveMode.Disabled)
    public static let enabled = PrivacySensitiveMode(oboe.PrivacySensitiveMode.Enabled)

    init(_ privacySensitiveMode: oboe.PrivacySensitiveMode) {
        self.oboeValue = privacySensitiveMode
    }
}
