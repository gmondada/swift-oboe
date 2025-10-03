//
//  SwiftDataCallbackRef.h
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

#pragma once

#include <memory>
#include <oboe/bridge/SwiftDataCallback.h>

namespace oboe::bridge {

class SwiftDataCallbackRef {
public:
    std::shared_ptr<SwiftDataCallback> ptr;

    static SwiftDataCallbackRef make(const SwiftRef& context, SwiftDataCallbackFunction callback) {
        return SwiftDataCallbackRef(std::make_shared<SwiftDataCallback>(context, callback));
    }

    SwiftDataCallbackRef() = default;
    SwiftDataCallbackRef(const SwiftDataCallbackRef& ref) = default;
    SwiftDataCallbackRef(SwiftDataCallbackRef&& ref) noexcept = default;

    explicit SwiftDataCallbackRef(std::shared_ptr<SwiftDataCallback> ptr)
        : ptr(ptr) {}

    ~SwiftDataCallbackRef() = default;

    SwiftDataCallbackRef& operator=(const SwiftDataCallbackRef& ref) = default;
    SwiftDataCallbackRef& operator=(SwiftDataCallbackRef&& ref) noexcept = default;

    bool isNull() const {
        return !ptr;
    }
};

} // namespace oboe::bridge
