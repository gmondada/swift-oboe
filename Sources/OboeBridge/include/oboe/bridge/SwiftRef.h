//
//  SwiftRef.h
//
//  Created by Gabriele Mondada on 12.09.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

#pragma once

extern "C" void oboe_bridge_SwiftRef_retain(void *ptr);
extern "C" void oboe_bridge_SwiftRef_release(void *ptr);

namespace oboe::bridge {

/**
 * This class holds a reference to a Swift object or nil.
 */
class SwiftRef {
public:
    SwiftRef() : ptr(nullptr) {}

    SwiftRef(void* ptr, bool transfer = false) : ptr(ptr) {
        if (!transfer)
            retain();
    }

    SwiftRef(const SwiftRef& ref) {
        ptr = ref.ptr;
        retain();
    }

    SwiftRef(SwiftRef&& ref) noexcept {
        if (&ref == this)
            return;
        ptr = ref.ptr;
        ref.ptr = nullptr;
    }

    ~SwiftRef() {
        release();
        ptr = nullptr;
    }

    SwiftRef& operator=(const SwiftRef& ref) {
        if (&ref == this)
            return *this;
        if (ref.ptr == ptr)
            return *this;
        release();
        ptr = ref.ptr;
        retain();
        return *this;
    }

    const SwiftRef& operator=(SwiftRef&& ref) noexcept {
        if (&ref == this)
            return *this;
        release();
        ptr = ref.ptr;
        ref.ptr = nullptr;
        return *this;
    }

    void* getRawPointer() const {
        return ptr;
    }

    void setRawPointer(void* ptr, bool transfer = false) {
        if (this->ptr == ptr) {
            if (transfer)
                release();
        } else {
            release();
            this->ptr = ptr;
            if (!transfer)
                retain();
        }
    }

    void empty() {
        release();
        ptr = nullptr;
    }

private:
    void *ptr;

    void retain() const {
        if (ptr)
            oboe_bridge_SwiftRef_retain(ptr);
    }

    void release() const {
        if (ptr)
            oboe_bridge_SwiftRef_release(ptr);
    }
};

} // namespace oboe::bridge
