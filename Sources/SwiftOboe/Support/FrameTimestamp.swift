//
//  FrameTimestamp.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 1, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

import oboe

public struct FrameTimestamp {
    public let position: Int64 // in frames
    public let timestamp: Int64 // in nanoseconds

    init(_ frameTimestamp: oboe.FrameTimestamp) {
        self.position = frameTimestamp.position
        self.timestamp = frameTimestamp.timestamp
    }
}
