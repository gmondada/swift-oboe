//
//  Direction.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 1, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

import oboe

public struct Direction: Sendable, Equatable {
    let oboeValue: oboe.Direction

    public static let input = Direction(oboe.Direction.Input)
    public static let output = Direction(oboe.Direction.Output)

    init(_ direction: oboe.Direction) {
        self.oboeValue = direction
    }
}
