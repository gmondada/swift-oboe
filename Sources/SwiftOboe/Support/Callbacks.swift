//
//  Callbacks.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 1, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

public typealias UnsafeRawDataCallback = (_ audioStream: AudioStream, _ data: UnsafeMutableRawPointer, _ numFrames: Int) -> DataCallbackResult
public typealias UnsafeDataCallback<T> = (_ audioStream: AudioStream, _ data: UnsafeMutableBufferPointer<T>, _ numFrames: Int) -> DataCallbackResult
public typealias InputDataCallback<T> = (_ audioStream: AudioStream, _ data: borrowing Span<T>, _ numFrames: Int) -> DataCallbackResult
public typealias OutputDataCallback<T> = (_ audioStream: AudioStream, _ data: inout MutableSpan<T>, _ numFrames: Int) -> DataCallbackResult
public typealias ErrorCallback = (_ audioStream: AudioStream, _ result: Result) -> Bool

public protocol ErrorCallbackObject: AnyObject {
    func onError(audioStream: AudioStream, error: Result) -> Bool
    func onErrorBeforeClose(audioStream: AudioStream, error: Result)
    func onErrorAfterClose(audioStream: AudioStream, error: Result)
}
