//
//  Direction.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
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
