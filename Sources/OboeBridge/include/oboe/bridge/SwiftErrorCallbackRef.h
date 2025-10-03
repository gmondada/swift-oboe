//
//  SwiftErrorCallbackRef.h
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

#pragma once

#include <memory>
#include <oboe/bridge/SwiftErrorCallback.h>

namespace oboe::bridge {

class SwiftErrorCallbackRef {
public:
    std::shared_ptr<SwiftErrorCallback> ptr;

    static SwiftErrorCallbackRef make(const SwiftRef& context, SwiftErrorCallbackFunction callback) {
        return SwiftErrorCallbackRef(std::make_shared<SwiftErrorCallback>(context, callback));
    }

    SwiftErrorCallbackRef() = default;
    SwiftErrorCallbackRef(const SwiftErrorCallbackRef& ref) = default;
    SwiftErrorCallbackRef(SwiftErrorCallbackRef&& ref) noexcept = default;

    explicit SwiftErrorCallbackRef(std::shared_ptr<SwiftErrorCallback> ptr)
        : ptr(ptr) {}

    ~SwiftErrorCallbackRef() = default;

    SwiftErrorCallbackRef& operator=(const SwiftErrorCallbackRef& ref) = default;
    SwiftErrorCallbackRef& operator=(SwiftErrorCallbackRef&& ref) noexcept = default;

    bool isNull() const {
        return !ptr;
    }
};

} // namespace oboe::bridge
