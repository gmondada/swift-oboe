//
//  AudioStreamBuilderRef.h
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

#pragma once

#include <oboe/AudioStreamBuilder.h>
#include <oboe/bridge/AudioStreamRef.h>
#include <oboe/bridge/SwiftDataCallbackRef.h>
#include <oboe/bridge/SwiftErrorCallbackRef.h>

namespace oboe::bridge {

class AudioStreamBuilderRef {
public:
    std::shared_ptr<oboe::AudioStreamBuilder> ptr;

    static AudioStreamBuilderRef make() {
        return AudioStreamBuilderRef(std::make_shared<oboe::AudioStreamBuilder>());
    }

    AudioStreamBuilderRef() = default;
    AudioStreamBuilderRef(const AudioStreamBuilderRef& ref) = default;
    AudioStreamBuilderRef(AudioStreamBuilderRef&& ref) noexcept = default;

    explicit AudioStreamBuilderRef(std::shared_ptr<oboe::AudioStreamBuilder> ptr)
        : ptr(ptr) {}

    ~AudioStreamBuilderRef() = default;
    
    AudioStreamBuilderRef& operator=(const AudioStreamBuilderRef& ref) = default;
    AudioStreamBuilderRef& operator=(AudioStreamBuilderRef&& ref) noexcept = default;

    AudioStreamBuilderRef setChannelCount(int channelCount) const {
        ptr->setChannelCount(channelCount);
        return *this;
    }

    AudioStreamBuilderRef setChannelMask(oboe::ChannelMask channelMask) const {
        ptr->setChannelMask(channelMask);
        return *this;
    }

    AudioStreamBuilderRef setDirection(oboe::Direction direction) const {
        ptr->setDirection(direction);
        return *this;
    }

    AudioStreamBuilderRef setSampleRate(int32_t sampleRate) const {
        ptr->setSampleRate(sampleRate);
        return *this;
    }

    AudioStreamBuilderRef setFramesPerDataCallback(int framesPerCallback) const {
        ptr->setFramesPerDataCallback(framesPerCallback);
        return *this;
    }

    AudioStreamBuilderRef setFormat(oboe::AudioFormat format) const {
        ptr->setFormat(format);
        return *this;
    }

    AudioStreamBuilderRef setBufferCapacityInFrames(int32_t bufferCapacityInFrames) const {
        ptr->setBufferCapacityInFrames(bufferCapacityInFrames);
        return *this;
    }

    oboe::AudioApi getAudioApi() const { 
        return ptr->getAudioApi();
    }

    AudioStreamBuilderRef setAudioApi(oboe::AudioApi audioApi) const {
        ptr->setAudioApi(audioApi);
        return *this;
    }

    static bool isAAudioSupported() {
        return oboe::AudioStreamBuilder::isAAudioSupported();
    }

    static bool isAAudioRecommended() {
        return oboe::AudioStreamBuilder::isAAudioRecommended();
    }

    AudioStreamBuilderRef setSharingMode(oboe::SharingMode sharingMode) const {
        ptr->setSharingMode(sharingMode);
        return *this;
    }

    AudioStreamBuilderRef setPerformanceMode(oboe::PerformanceMode performanceMode) const {
        ptr->setPerformanceMode(performanceMode);
        return *this;
    }

    AudioStreamBuilderRef setUsage(oboe::Usage usage) const {
        ptr->setUsage(usage);
        return *this;
    }

    AudioStreamBuilderRef setContentType(oboe::ContentType contentType) const {
        ptr->setContentType(contentType);
        return *this;
    }

    AudioStreamBuilderRef setInputPreset(oboe::InputPreset inputPreset) const {
        ptr->setInputPreset(inputPreset);
        return *this;
    }

    AudioStreamBuilderRef setSessionId(oboe::SessionId sessionId) const {
        ptr->setSessionId(sessionId);
        return *this;
    }

    AudioStreamBuilderRef setDeviceId(int32_t deviceId) const {
        ptr->setDeviceId(deviceId);
        return *this;
    }

    AudioStreamBuilderRef setAllowedCapturePolicy(oboe::AllowedCapturePolicy allowedCapturePolicy) const {
        ptr->setAllowedCapturePolicy(allowedCapturePolicy);
        return *this;
    }

    AudioStreamBuilderRef setPrivacySensitiveMode(oboe::PrivacySensitiveMode privacySensitiveMode) const {
        ptr->setPrivacySensitiveMode(privacySensitiveMode);
        return *this;
    }

    AudioStreamBuilderRef setIsContentSpatialized(bool isContentSpatialized) const {
        ptr->setIsContentSpatialized(isContentSpatialized);
        return *this;
    }

    AudioStreamBuilderRef setSpatializationBehavior(oboe::SpatializationBehavior spatializationBehavior) const {
        ptr->setSpatializationBehavior(spatializationBehavior);
        return *this;
    }

    AudioStreamBuilderRef setDataCallback(const SwiftDataCallbackRef callback) const {
        ptr->setDataCallback(callback.ptr);
        return *this;
    }

    AudioStreamBuilderRef setErrorCallback(const SwiftErrorCallbackRef callback) const {
        ptr->setErrorCallback(callback.ptr);
        return *this;
    }

    AudioStreamBuilderRef setChannelConversionAllowed(bool allowed) const {
        ptr->setChannelConversionAllowed(allowed);
        return *this;
    }

    AudioStreamBuilderRef setFormatConversionAllowed(bool allowed) const {
        ptr->setFormatConversionAllowed(allowed);
        return *this;
    }

    AudioStreamBuilderRef setSampleRateConversionQuality(oboe::SampleRateConversionQuality quality) const {
        ptr->setSampleRateConversionQuality(quality);
        return *this;
    }

    AudioStreamBuilderRef setPackageName(std::string packageName) const {
        ptr->setPackageName(packageName);
        return *this;
    }

    AudioStreamBuilderRef setPackageName(const char* packageName) const {
        ptr->setPackageName(std::string(packageName));
        return *this;
    }

    AudioStreamBuilderRef setAttributionTag(std::string attributionTag) const {
        ptr->setAttributionTag(attributionTag);
        return *this;
    }

    AudioStreamBuilderRef setAttributionTag(const char* attributionTag) const {
        ptr->setAttributionTag(std::string(attributionTag));
        return *this;
    }

    bool willUseAAudio() const { 
        return ptr->willUseAAudio();
    }

    oboe::Result openStream(AudioStreamRef& audioStream) const {
        return ptr->openStream(audioStream.ptr);
    }
};

} // namespace oboe::bridge
