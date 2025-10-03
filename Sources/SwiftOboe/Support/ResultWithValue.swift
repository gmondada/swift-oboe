//
//  ResultWithValue.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 1, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

public enum ResultWithValue<T> {
    case success(T)
    case failure(Result)
}
