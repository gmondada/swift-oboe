//
//  SessionId.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
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
