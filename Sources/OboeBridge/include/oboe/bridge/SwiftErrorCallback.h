//
//  SwiftErrorCallback.h
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

#pragma once

#include <oboe/AudioStreamCallback.h>
#include <oboe/bridge/SwiftRef.h>
#include <oboe/bridge/AudioStreamRef.h>

namespace oboe::bridge {

enum class SwiftErrorCallbackPhase {
    OnError = 0,
    OnErrorBeforeClose = 1,
    OnErrorAfterClose = 2,
};

// TODO: use const SwiftRef& context, once the compiler will accept it without crashing
// TODO: same for AudioStreamRef& audioStreamRef
typedef bool (*SwiftErrorCallbackFunction)(const SwiftRef* context, AudioStreamRef* audioStreamRef, SwiftErrorCallbackPhase phase, Result error);

class SwiftErrorCallback: public oboe::AudioStreamErrorCallback {
public:
    SwiftRef context;
    SwiftErrorCallbackFunction callback;
    AudioStreamRef audioStreamRef;

    SwiftErrorCallback() = delete;

    SwiftErrorCallback(const SwiftRef& context, SwiftErrorCallbackFunction callback)
        : context(context), callback(callback) {}

    virtual bool onError(AudioStream* audioStream, Result error) {
        if (audioStreamRef.ptr.get() != audioStream)
            audioStreamRef = AudioStreamRef(audioStream, true);

        bool result = callback(&context, &audioStreamRef, SwiftErrorCallbackPhase::OnError, error);

        if (audioStreamRef.ptr.use_count() != 1)
            throw std::runtime_error("This AudioStreamRef must not escape the data callback");

        return result;
    }

    virtual void onErrorBeforeClose(AudioStream* audioStream, Result error) {
        if (audioStreamRef.ptr.get() != audioStream)
            audioStreamRef = AudioStreamRef(audioStream, true);

        callback(&context, &audioStreamRef, SwiftErrorCallbackPhase::OnErrorBeforeClose, error);

        if (audioStreamRef.ptr.use_count() != 1)
            throw std::runtime_error("This AudioStreamRef must not escape the data callback");
    }

    virtual void onErrorAfterClose(AudioStream* audioStream, Result error) {
        if (audioStreamRef.ptr.get() != audioStream)
            audioStreamRef = AudioStreamRef(audioStream, true);

        callback(&context, &audioStreamRef, SwiftErrorCallbackPhase::OnErrorAfterClose, error);

        if (audioStreamRef.ptr.use_count() != 1)
            throw std::runtime_error("This AudioStreamRef must not escape the data callback");
    }
};

} // namespace oboe::bridge
