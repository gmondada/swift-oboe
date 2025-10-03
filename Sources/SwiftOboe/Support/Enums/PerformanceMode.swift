//
//  PerformanceMode.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 1, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

import oboe

public struct PerformanceMode: Sendable, Equatable {
    let oboeValue: oboe.PerformanceMode

    public static let none = PerformanceMode(oboe.PerformanceMode.None)
    public static let powerSaving = PerformanceMode(oboe.PerformanceMode.PowerSaving)
    public static let lowLatency = PerformanceMode(oboe.PerformanceMode.LowLatency)

    init(_ performanceMode: oboe.PerformanceMode) {
        self.oboeValue = performanceMode
    }
}
