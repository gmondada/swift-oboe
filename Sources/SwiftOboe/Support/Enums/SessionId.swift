//
//  SessionId.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 1, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

import oboe

public struct SessionId: Sendable, Equatable {
    let oboeValue: oboe.SessionId

    public static let none = SessionId(oboe.None)
    public static let allocate = SessionId(oboe.Allocate)

    init(_ sessionId: oboe.SessionId) {
        self.oboeValue = sessionId
    }
}
