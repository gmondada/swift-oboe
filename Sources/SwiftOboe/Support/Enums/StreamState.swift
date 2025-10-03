//
//  StreamState.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

import oboe

public struct StreamState: Sendable, Equatable {
    let oboeValue: oboe.StreamState

    public static let uninitialized = StreamState(oboe.StreamState.Uninitialized)
    public static let unknown = StreamState(oboe.StreamState.Unknown)
    public static let `open` = StreamState(oboe.StreamState.Open)
    public static let starting = StreamState(oboe.StreamState.Starting)
    public static let started = StreamState(oboe.StreamState.Started)
    public static let pausing = StreamState(oboe.StreamState.Pausing)
    public static let paused = StreamState(oboe.StreamState.Paused)
    public static let flushing = StreamState(oboe.StreamState.Flushing)
    public static let flushed = StreamState(oboe.StreamState.Flushed)
    public static let stopping = StreamState(oboe.StreamState.Stopping)
    public static let stopped = StreamState(oboe.StreamState.Stopped)
    public static let closing = StreamState(oboe.StreamState.Closing)
    public static let closed = StreamState(oboe.StreamState.Closed)
    public static let disconnected = StreamState(oboe.StreamState.Disconnected)

    init(_ streamState: oboe.StreamState) {
        self.oboeValue = streamState
    }
}
