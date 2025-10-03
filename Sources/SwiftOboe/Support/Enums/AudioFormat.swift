//
//  AudioFormat.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 1, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

import oboe

public struct AudioFormat: Sendable, Equatable {
    let oboeValue: oboe.AudioFormat

    public static let invalid = AudioFormat(oboe.AudioFormat.Invalid)
    public static let unspecified = AudioFormat(oboe.AudioFormat.Unspecified)
    public static let i16 = AudioFormat(oboe.AudioFormat.I16)
    public static let float = AudioFormat(oboe.AudioFormat.Float)
    public static let i24 = AudioFormat(oboe.AudioFormat.I24)
    public static let i32 = AudioFormat(oboe.AudioFormat.I32)
    public static let iec61937 = AudioFormat(oboe.AudioFormat.IEC61937)

    init(_ audioFormat: oboe.AudioFormat) {
        self.oboeValue = audioFormat
    }

    /*
    public var isCompressedFormat: Bool {
        return oboe.isCompressedFormat(oboeValue)
    }
    */

    public var sizeInBytes: Int {
        return Int(oboe.convertFormatToSizeInBytes(oboeValue))
    }
}

extension AudioFormat: CustomStringConvertible {
    public var description: String {
        switch oboeValue {
        case oboe.AudioFormat.Invalid:
            return "Invalid"
        case oboe.AudioFormat.Unspecified:
            return "Unspecified"
        case oboe.AudioFormat.I16:
            return "I16"
        case oboe.AudioFormat.Float:
            return "Float"
        case oboe.AudioFormat.I24:
            return "I24"
        case oboe.AudioFormat.I32:
            return "I32"
        case oboe.AudioFormat.IEC61937:
            return "IEC61937"
        default:
            return "Unknown(\(oboeValue.rawValue))"
        }
    }
}
