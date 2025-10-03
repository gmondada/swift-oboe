//
//  SwiftDataCallback.h
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

// TODO: use const SwiftRef& context, once the compiler will accept it without crashing
// TODO: same for AudioStreamRef& audioStreamRef
typedef oboe::DataCallbackResult (*SwiftDataCallbackFunction)(const SwiftRef* context, AudioStreamRef* audioStreamRef, void* audioData, size_t numFrames);

class SwiftDataCallback: public oboe::AudioStreamDataCallback {
public:
    SwiftRef context;
    SwiftDataCallbackFunction callback;
    AudioStreamRef audioStreamRef;

    SwiftDataCallback() = delete;

    SwiftDataCallback(const SwiftRef& context, SwiftDataCallbackFunction callback)
        : context(context), callback(callback) {}

    virtual oboe::DataCallbackResult onAudioReady(
        oboe::AudioStream *audioStream,
        void *audioData,
        int32_t numFrames) override
    {
        if (audioStreamRef.ptr.get() != audioStream)
            audioStreamRef = AudioStreamRef(audioStream, true);

        auto result = callback(&context, &audioStreamRef, audioData, numFrames);

        if (audioStreamRef.ptr.use_count() != 1)
            throw std::runtime_error("This AudioStreamRef must not escape the data callback");

        return result;
    }
};

} // namespace oboe::bridge
