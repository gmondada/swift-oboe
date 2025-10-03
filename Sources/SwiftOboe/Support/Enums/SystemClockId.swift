//
//  SystemClockId.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

import Android

public struct SystemClockId: Sendable, Equatable {
    public let rawValue: clockid_t

    public static let monotonic = SystemClockId(rawValue: CLOCK_MONOTONIC)
    public static let realtime = SystemClockId(rawValue: CLOCK_REALTIME)

    public init(rawValue: clockid_t) {
        self.rawValue = rawValue
    }
}
