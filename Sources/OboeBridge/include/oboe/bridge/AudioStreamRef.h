//
//  AudioStreamRef.h
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

#pragma once

#include <memory>
#include <oboe/AudioStream.h>

namespace oboe::bridge {

class AudioStreamRef {
public:
    std::shared_ptr<oboe::AudioStream> ptr;

    AudioStreamRef() = default;
    AudioStreamRef(const AudioStreamRef& ref) = default;
    AudioStreamRef(AudioStreamRef&& ref) noexcept = default;

    explicit AudioStreamRef(oboe::AudioStream* stream, bool unowned = false)
        : ptr(unowned ? std::shared_ptr<oboe::AudioStream>(stream, [](oboe::AudioStream*) {}) : std::shared_ptr<oboe::AudioStream>(stream)) {}

    ~AudioStreamRef() = default;

    AudioStreamRef& operator=(const AudioStreamRef& ref) = default;
    AudioStreamRef& operator=(AudioStreamRef&& ref) noexcept = default;

    bool isNull() const {
        return !ptr;
    }

    oboe::Result release() const {
        return ptr->release();
    }

    oboe::Result close() const {
        return ptr->close();
    }

    oboe::Result start(int64_t timeoutNanoseconds = oboe::kDefaultTimeoutNanos) const {
        return ptr->start(timeoutNanoseconds);
    }

    oboe::Result pause(int64_t timeoutNanoseconds = oboe::kDefaultTimeoutNanos) const {
        return ptr->pause(timeoutNanoseconds);
    }

    oboe::Result flush(int64_t timeoutNanoseconds = oboe::kDefaultTimeoutNanos) const {
        return ptr->flush(timeoutNanoseconds);
    }

    oboe::Result stop(int64_t timeoutNanoseconds = oboe::kDefaultTimeoutNanos) const {
        return ptr->stop(timeoutNanoseconds);
    }

    oboe::Result requestStart() const {
        return ptr->requestStart();
    }

    oboe::Result requestPause() const {
        return ptr->requestPause();
    }

    oboe::Result requestFlush() const {
        return ptr->requestFlush();
    }

    oboe::Result requestStop() const {
        return ptr->requestStop();
    }

    oboe::StreamState getState() const {
        return ptr->getState();
    }

    oboe::Result waitForStateChange(
        oboe::StreamState inputState,
        oboe::StreamState *nextState,
        int64_t timeoutNanoseconds) const
    {
        return ptr->waitForStateChange(inputState, nextState, timeoutNanoseconds);
    }

    oboe::ResultWithValue<int32_t> setBufferSizeInFrames(int32_t requestedFrames) const {
        return ptr->setBufferSizeInFrames(requestedFrames);
    }

    oboe::ResultWithValue<int32_t> getXRunCount() const {
        return ptr->getXRunCount();
    }

    bool isXRunCountSupported() const {
        return ptr->isXRunCountSupported();
    }

    int32_t getFramesPerBurst() const {
        return ptr->getFramesPerBurst();
    }

    int32_t getBytesPerFrame() const {
        return ptr->getBytesPerFrame();
    }

    int32_t getBytesPerSample() const {
        return ptr->getBytesPerSample();
    }

    int64_t getFramesWritten() const {
        return ptr->getFramesWritten();
    }

    int64_t getFramesRead() const {
        return ptr->getFramesRead();
    }

    oboe::ResultWithValue<double> calculateLatencyMillis() const {
        return ptr->calculateLatencyMillis();
    }

    oboe::ResultWithValue<oboe::FrameTimestamp> getTimestamp(clockid_t clockId) const {
        return ptr->getTimestamp(clockId);
    }

    oboe::ResultWithValue<int32_t> write(
        const void* buffer,
        int32_t numFrames,
        int64_t timeoutNanoseconds) const
    {
        return ptr->write(buffer, numFrames, timeoutNanoseconds);
    }

    oboe::ResultWithValue<int32_t> read(
        void* buffer,
        int32_t numFrames,
        int64_t timeoutNanoseconds) const
    {
        return ptr->read(buffer, numFrames, timeoutNanoseconds);
    }

    oboe::AudioApi getAudioApi() const {
        return ptr->getAudioApi();
    }

    bool usesAAudio() const {
        return ptr->usesAAudio();
    }

    oboe::ResultWithValue<int32_t> getAvailableFrames() const {
        return ptr->getAvailableFrames();
    }

    oboe::ResultWithValue<int32_t> waitForAvailableFrames(
        int32_t numFrames,
        int64_t timeoutNanoseconds) const
    {
        return ptr->waitForAvailableFrames(numFrames, timeoutNanoseconds);
    }

    oboe::Result getLastErrorCallbackResult() const {
        return ptr->getLastErrorCallbackResult();
    }

    int32_t getDelayBeforeCloseMillis() const {
        return ptr->getDelayBeforeCloseMillis();
    }

    void setDelayBeforeCloseMillis(int32_t delayBeforeCloseMillis) const {
        ptr->setDelayBeforeCloseMillis(delayBeforeCloseMillis);
    }

    void setPerformanceHintEnabled(bool enabled) const {
        ptr->setPerformanceHintEnabled(enabled);
    }

    bool isPerformanceHintEnabled() const {
        return ptr->isPerformanceHintEnabled();
    }

    oboe::Result reportWorkload(int32_t appWorkload) const {
        return ptr->reportWorkload(appWorkload);
    }

    /*=== AudioStreamBase ===*/

    int32_t getChannelCount() const {
        return ptr->getChannelCount();
    }

    oboe::Direction getDirection() const { 
        return ptr->getDirection();
    }

    int32_t getSampleRate() const {
        return ptr->getSampleRate();
    }

    int32_t getFramesPerDataCallback() const {
        return ptr->getFramesPerDataCallback();
    }

    oboe::AudioFormat getFormat() const {
        return ptr->getFormat();
    }

    int32_t getBufferSizeInFrames() const {
        return ptr->getBufferSizeInFrames();
    }

    int32_t getBufferCapacityInFrames() const {
        return ptr->getBufferCapacityInFrames();
    }

    oboe::SharingMode getSharingMode() const {
        return ptr->getSharingMode();
    }

    oboe::PerformanceMode getPerformanceMode() const {
        return ptr->getPerformanceMode();
    }

    int32_t getDeviceId() const {
        return ptr->getDeviceId();
    }

    bool isDataCallbackSpecified() const {
        return ptr->isDataCallbackSpecified();
    }

    bool isErrorCallbackSpecified() const {
        return ptr->isErrorCallbackSpecified();
    }

    oboe::Usage getUsage() const {
        return ptr->getUsage();
    }

    oboe::ContentType getContentType() const {
        return ptr->getContentType();
    }

    oboe::InputPreset getInputPreset() const {
        return ptr->getInputPreset();
    }

    oboe::SessionId getSessionId() const {
        return ptr->getSessionId();
    }

    bool isContentSpatialized() const { 
        return ptr->isContentSpatialized();
    }

    oboe::SpatializationBehavior getSpatializationBehavior() const { 
        return ptr->getSpatializationBehavior();
    }

    oboe::AllowedCapturePolicy getAllowedCapturePolicy() const { 
        return ptr->getAllowedCapturePolicy();
    }

    oboe::PrivacySensitiveMode getPrivacySensitiveMode() const { 
        return ptr->getPrivacySensitiveMode();
    }

    bool isChannelConversionAllowed() const {
        return ptr->isChannelConversionAllowed();
    }

    bool isFormatConversionAllowed() const {
        return ptr->isFormatConversionAllowed();
    }

    oboe::SampleRateConversionQuality getSampleRateConversionQuality() const {
        return ptr->getSampleRateConversionQuality();
    }

    oboe::ChannelMask getChannelMask() const {
        return ptr->getChannelMask();
    }

    int32_t getHardwareChannelCount() const { 
        return ptr->getHardwareChannelCount();
    }

    int32_t getHardwareSampleRate() const { 
        return ptr->getHardwareSampleRate();
    }

    oboe::AudioFormat getHardwareFormat() const { 
        return ptr->getHardwareFormat();
    }
};

} // namespace oboe::bridge
