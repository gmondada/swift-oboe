//
//  DataCallbackResult.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

import oboe

public struct DataCallbackResult: Sendable, Equatable {
    let oboeValue: oboe.DataCallbackResult

    public static let `continue` = DataCallbackResult(oboe.DataCallbackResult.Continue)
    public static let stop = DataCallbackResult(oboe.DataCallbackResult.Stop)

    init(_ dataCallbackResult: oboe.DataCallbackResult) {
        self.oboeValue = dataCallbackResult
    }
}
