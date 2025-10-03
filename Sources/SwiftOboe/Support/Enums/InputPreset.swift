//
//  InputPreset.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

import oboe

public struct InputPreset: Sendable, Equatable {
    let oboeValue: oboe.InputPreset

    public static let generic = InputPreset(oboe.Generic)
    public static let camcorder = InputPreset(oboe.Camcorder)
    public static let voiceRecognition = InputPreset(oboe.VoiceRecognition)
    public static let voiceCommunication = InputPreset(oboe.VoiceCommunication)
    public static let unprocessed = InputPreset(oboe.Unprocessed)
    public static let voicePerformance = InputPreset(oboe.VoicePerformance)

    init(_ inputPreset: oboe.InputPreset) {
        self.oboeValue = inputPreset
    }
}
