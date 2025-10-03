//
//  AudioApi.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 1, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

import oboe

public struct AudioApi: Sendable, Equatable {
    let oboeValue: oboe.AudioApi

    public static let unspecified = AudioApi(oboe.AudioApi.Unspecified)
    public static let openSLES = AudioApi(oboe.AudioApi.OpenSLES)
    public static let aAudio = AudioApi(oboe.AudioApi.AAudio)

    init(_ audioApi: oboe.AudioApi) {
        self.oboeValue = audioApi
    }
}
