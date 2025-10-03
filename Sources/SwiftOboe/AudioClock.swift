//
//  AudioClock.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 1, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

import oboe

public struct AudioClock {
    static func getNanoseconds(clockId: SystemClockId = .monotonic) -> Int64 {
        return oboe.AudioClock.getNanoseconds(clockId.rawValue)
    }

    @discardableResult
    static func sleepUntilNanoTime(_ nanoTime: Int64, clockId: SystemClockId = .monotonic) -> Int32 {
        return oboe.AudioClock.sleepUntilNanoTime(nanoTime, clockId.rawValue)
    }

    @discardableResult
    static func sleepForNanos(_ nanoseconds: Int64, clockId: SystemClockId = .monotonic) -> Int32 {
        return oboe.AudioClock.sleepForNanos(nanoseconds, clockId.rawValue)
    }
}
