//
//  SpatializationBehavior.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

import oboe

public struct SpatializationBehavior: Sendable, Equatable {
    let oboeValue: oboe.SpatializationBehavior

    public static let unspecified = SpatializationBehavior(oboe.SpatializationBehavior.Unspecified)
    public static let auto = SpatializationBehavior(oboe.SpatializationBehavior.Auto)
    public static let never = SpatializationBehavior(oboe.SpatializationBehavior.Never)

    init(_ spatializationBehavior: oboe.SpatializationBehavior) {
        self.oboeValue = spatializationBehavior
    }
}
