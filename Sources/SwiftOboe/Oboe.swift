//
//  Oboe.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

import OboeBridge
import oboe

public struct Oboe {
    public static let kUnspecified: Int = Int(oboe.bridge.kUnspecified)

    public static let kDefaultTimeoutNanos: Int64 = oboe.bridge.kDefaultTimeoutNanos

    public static let kNanosPerMicrosecond: Int64 = 1_000
    public static let kNanosPerMillisecond: Int64 = 1_000_000
    public static let kMillisPerSecond: Int64 = 1_000
    public static let kNanosPerSecond: Int64 = 1_000_000_000

    public static func convertFloatToPcm16(_ source: UnsafeBufferPointer<Float>, _ destination: UnsafeMutableBufferPointer<Int16>) {
        precondition(source.count == destination.count, "Source and destination must have the same number of elements")
        oboe.convertFloatToPcm16(source.baseAddress, destination.baseAddress, Int32(source.count))
    }

    public static func convertPcm16ToFloat(_ source: UnsafeBufferPointer<Int16>, _ destination: UnsafeMutableBufferPointer<Float>) {
        precondition(source.count == destination.count, "Source and destination must have the same number of elements")
        oboe.convertPcm16ToFloat(source.baseAddress, destination.baseAddress, Int32(source.count))
    }

    public static func getSdkVersion() -> Int {
        return Int(oboe.getSdkVersion())
    }
}
