//
//  AllowedCapturePolicy.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 1, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

import oboe

public struct AllowedCapturePolicy: Sendable, Equatable {
    let oboeValue: oboe.AllowedCapturePolicy

    public static let unspecified = AllowedCapturePolicy(oboe.AllowedCapturePolicy.Unspecified)
    public static let all = AllowedCapturePolicy(oboe.AllowedCapturePolicy.All)
    public static let system = AllowedCapturePolicy(oboe.AllowedCapturePolicy.System)
    public static let none = AllowedCapturePolicy(oboe.AllowedCapturePolicy.None)

    init(_ allowedCapturePolicy: oboe.AllowedCapturePolicy) {
        self.oboeValue = allowedCapturePolicy
    }
}
