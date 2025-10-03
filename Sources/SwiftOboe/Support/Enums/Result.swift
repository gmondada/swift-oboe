//
//  Result.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 1, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

import oboe

public struct Result: Sendable, Equatable {
    let oboeValue: oboe.Result

    public static let ok = Result(oboe.Result.OK)
    public static let errorBase = Result(oboe.Result.ErrorBase)
    public static let errorDisconnected = Result(oboe.Result.ErrorDisconnected)
    public static let errorIllegalArgument = Result(oboe.Result.ErrorIllegalArgument)
    public static let errorInternal = Result(oboe.Result.ErrorInternal)
    public static let errorInvalidState = Result(oboe.Result.ErrorInvalidState)
    public static let errorInvalidHandle = Result(oboe.Result.ErrorInvalidHandle)
    public static let errorUnimplemented = Result(oboe.Result.ErrorUnimplemented)
    public static let errorUnavailable = Result(oboe.Result.ErrorUnavailable)
    public static let errorNoFreeHandles = Result(oboe.Result.ErrorNoFreeHandles)
    public static let errorNoMemory = Result(oboe.Result.ErrorNoMemory)
    public static let errorNull = Result(oboe.Result.ErrorNull)
    public static let errorTimeout = Result(oboe.Result.ErrorTimeout)
    public static let errorWouldBlock = Result(oboe.Result.ErrorWouldBlock)
    public static let errorInvalidFormat = Result(oboe.Result.ErrorInvalidFormat)
    public static let errorOutOfRange = Result(oboe.Result.ErrorOutOfRange)
    public static let errorNoService = Result(oboe.Result.ErrorNoService)
    public static let errorInvalidRate = Result(oboe.Result.ErrorInvalidRate)
    public static let errorClosed = Result(oboe.Result.ErrorClosed)

    init(_ result: oboe.Result) {
        self.oboeValue = result
    }
}
