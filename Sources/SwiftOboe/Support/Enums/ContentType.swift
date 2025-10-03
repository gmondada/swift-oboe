//
//  ContentType.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

import oboe

public struct ContentType: Sendable, Equatable {
    let oboeValue: oboe.ContentType

    public static let speech = ContentType(oboe.Speech)
    public static let music = ContentType(oboe.Music)
    public static let movie = ContentType(oboe.Movie)
    public static let sonification = ContentType(oboe.Sonification)

    init(_ contentType: oboe.ContentType) {
        self.oboeValue = contentType
    }
}
