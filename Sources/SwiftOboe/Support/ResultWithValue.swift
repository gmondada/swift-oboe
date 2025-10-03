//
//  ResultWithValue.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

public enum ResultWithValue<T> {
    case success(T)
    case failure(Result)
}
