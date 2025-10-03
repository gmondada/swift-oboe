//
//  SampleRateConversionQuality.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

import oboe

public struct SampleRateConversionQuality: Sendable, Equatable {
    let oboeValue: oboe.SampleRateConversionQuality

    public static let none = SampleRateConversionQuality(oboe.SampleRateConversionQuality.None)
    public static let fastest = SampleRateConversionQuality(oboe.SampleRateConversionQuality.Fastest)
    public static let low = SampleRateConversionQuality(oboe.SampleRateConversionQuality.Low)
    public static let medium = SampleRateConversionQuality(oboe.SampleRateConversionQuality.Medium)
    public static let high = SampleRateConversionQuality(oboe.SampleRateConversionQuality.High)
    public static let best = SampleRateConversionQuality(oboe.SampleRateConversionQuality.Best)

    init(_ sampleRateConversionQuality: oboe.SampleRateConversionQuality) {
        self.oboeValue = sampleRateConversionQuality
    }
}
