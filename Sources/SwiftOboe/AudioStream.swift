//
//  AudioStream.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

import OboeBridge
import oboe

public struct AudioStream {
    var ref: oboe.bridge.AudioStreamRef

    init() {
        ref = oboe.bridge.AudioStreamRef()
    }

    init(_ ref: oboe.bridge.AudioStreamRef) {
        self.ref = ref
    }

    public func release() -> Result{
        let rv = ref.release()
        return Result(rv)
    }

    public func close() -> Result {
        let rv = ref.close()
        return Result(rv)
    }

    public func start(timeout timeoutNanoseconds: Int64 = oboe.bridge.kDefaultTimeoutNanos) -> Result {
        let rv = ref.start(timeoutNanoseconds)
        return Result(rv)
    }

    public func pause(timeout timeoutNanoseconds: Int64 = oboe.bridge.kDefaultTimeoutNanos) -> Result {
        let rv = ref.pause(timeoutNanoseconds)
        return Result(rv)
    }

    public func flush(timeout timeoutNanoseconds: Int64 = oboe.bridge.kDefaultTimeoutNanos) -> Result {
        let rv = ref.flush(timeoutNanoseconds)
        return Result(rv)
    }

    public func stop(timeout timeoutNanoseconds: Int64 = oboe.bridge.kDefaultTimeoutNanos) -> Result {
        let rv = ref.stop(timeoutNanoseconds)
        return Result(rv)
    }

    public func requestStart() -> Result {
        let rv = ref.requestStart()
        return Result(rv)
    }

    public func requestPause() -> Result {
        let rv = ref.requestPause()
        return Result(rv)
    }

    public func requestFlush() -> Result {
        let rv = ref.requestFlush()
        return Result(rv)
    }

    public func requestStop() -> Result {
        let rv = ref.requestStop()
        return Result(rv)
    }

    public func getState() -> StreamState {
        let state = ref.getState()
        return StreamState(state)
    }

    public func waitForStateChange(current: StreamState, timeout timeoutNanoseconds: Int64) -> ResultWithValue<StreamState> {
        var newState = oboe.StreamState.Uninitialized
        let rv = ref.waitForStateChange(current.oboeValue, &newState, timeoutNanoseconds)
        if (rv == oboe.Result.OK) {
            return .success(StreamState(newState))
        } else {
            return .failure(Result(rv))
        }
    }

    public func setBufferSizeInFrames(_ requestedFrames: Int) -> ResultWithValue<Int> {
        let rv = ref.setBufferSizeInFrames(Int32(requestedFrames))
        if (rv.error() == oboe.Result.OK) {
            return .success(Int(rv.value()))
        } else {
            return .failure(Result(rv.error()))
        }
    }

    public func getXRunCount() -> ResultWithValue<Int> {
        let rv = ref.getXRunCount()
        if (rv.error() == oboe.Result.OK) {
            return .success(Int(rv.value()))
        } else {
            return .failure(Result(rv.error()))
        }
    }

    public var isXRunCountSupported: Bool {
        return ref.isXRunCountSupported()
    }

    public var framesPerBurst: Int {
        return Int(ref.getFramesPerBurst())
    }

    public var bytesPerFrame: Int {
        return Int(ref.getBytesPerFrame())
    }

    public var bytesPerSample: Int {
        return Int(ref.getBytesPerSample())
    }

    public var framesWritten: Int64 {
        return ref.getFramesWritten()
    }

    public var framesRead: Int64 {
        return ref.getFramesRead()
    }

    public func calculateLatencyMillis() -> ResultWithValue<Double> {
        let rv = ref.calculateLatencyMillis()
        if (rv.error() == oboe.Result.OK) {
            return .success(Double(rv.value()))
        } else {
            return .failure(Result(rv.error()))
        }
    }

    /** The default clock is the system monotonic clock (CLOCK_MONOTONIC) also used by ProcessInfo.processInfo.systemUptime */
    public func getTimestamp(clock: SystemClockId = .monotonic) -> ResultWithValue<FrameTimestamp> {
        let rv = ref.getTimestamp(clock.rawValue)
        if (rv.error() == oboe.Result.OK) {
            return .success(FrameTimestamp(rv.value()))
        } else {
            return .failure(Result(rv.error()))
        }
    }

    public func unsafeWrite(start buffer: UnsafeRawPointer, frames numFrames: Int, timeout timeoutNanoseconds: Int64) -> ResultWithValue<Int> {
        let rv = ref.write(buffer, Int32(numFrames), timeoutNanoseconds)
        if (rv.error() == oboe.Result.OK) {
            return .success(Int(rv.value()))
        } else {
            return .failure(Result(rv.error()))
        }
    }

    public func unsafeWrite<T>(buffer: UnsafeBufferPointer<T>, frames numFrames: Int, timeout timeoutNanoseconds: Int64) -> ResultWithValue<Int> {
        precondition(MemoryLayout<T>.stride == bytesPerSample, "Inconsistent sample size")
        precondition(buffer.count == numFrames * channelCount, "Inconsistent buffer size")
        return unsafeWrite(start: buffer.baseAddress!, frames: numFrames, timeout: timeoutNanoseconds)
    }

    public func write<T>(span: borrowing Span<T>, frames numFrames: Int, timeout timeoutNanoseconds: Int64) -> ResultWithValue<Int> {
        return span.withUnsafeBufferPointer { buffer in
            return unsafeWrite(buffer: buffer, frames: numFrames, timeout: timeoutNanoseconds)
        }
    }

    public func unsafeRead(start buffer: UnsafeMutableRawPointer, frames numFrames: Int, timeout timeoutNanoseconds: Int64) -> ResultWithValue<Int> {
        let rv = ref.read(buffer, Int32(numFrames), timeoutNanoseconds)
        if (rv.error() == oboe.Result.OK) {
            return .success(Int(rv.value()))
        } else {
            return .failure(Result(rv.error()))
        }
    }

    public func unsafeRead<T>(buffer: UnsafeMutableBufferPointer<T>, frames numFrames: Int, timeout timeoutNanoseconds: Int64) -> ResultWithValue<Int> {
        precondition(MemoryLayout<T>.stride == bytesPerSample, "Inconsistent sample size")
        precondition(buffer.count == numFrames * channelCount, "Inconsistent buffer size")
        return unsafeRead(start: buffer.baseAddress!, frames: numFrames, timeout: timeoutNanoseconds)
    }

    public func read<T>(span: inout MutableSpan<T>, frames numFrames: Int, timeout timeoutNanoseconds: Int64) -> ResultWithValue<Int> {
        return span.withUnsafeMutableBufferPointer { buffer in
            return unsafeRead(buffer: buffer, frames: numFrames, timeout: timeoutNanoseconds)
        }
    }

    public var audioApi: AudioApi {
        return AudioApi(ref.getAudioApi())
    }

    public var usesAAudio: Bool {
        return ref.usesAAudio()
    }

    public func getAvailableFrames() -> ResultWithValue<Int> {
        let rv = ref.getAvailableFrames()
        if (rv.error() == oboe.Result.OK) {
            return .success(Int(rv.value()))
        } else {
            return .failure(Result(rv.error()))
        }
    }

    public func waitForAvailableFrames(frames numFrames: Int, timeout timeoutNanoseconds: Int64) -> ResultWithValue<Int> {
        let rv = ref.waitForAvailableFrames(Int32(numFrames), timeoutNanoseconds)
        if (rv.error() == oboe.Result.OK) {
            return .success(Int(rv.value()))
        } else {
            return .failure(Result(rv.error()))
        }
    }

    public var lastErrorCallbackResult: Result {
        return Result(ref.getLastErrorCallbackResult())
    }

    public var delayBeforeCloseMillis: Int {
        get {
            return Int(ref.getDelayBeforeCloseMillis())
        }
        set {
            ref.setDelayBeforeCloseMillis(Int32(newValue))
        }
    }

    public var isPerformanceHintEnabled: Bool {
        get {
            return ref.isPerformanceHintEnabled()
        }
        set {
            ref.setPerformanceHintEnabled(newValue)
        }
    }

    public func reportWorkload(_ appWorkload: Int) -> Result {
        return Result(ref.reportWorkload(Int32(appWorkload)))
    }

    public var channelCount: Int {
        return Int(ref.getChannelCount())
    }

    public var direction: Direction {
        return Direction(ref.getDirection())
    }

    public var sampleRate: Int {
        return Int(ref.getSampleRate())
    }

    public var framesPerDataCallback: Int {
        return Int(ref.getFramesPerDataCallback())
    }

    public var format: AudioFormat {
        return AudioFormat(ref.getFormat())
    }

    public var bufferSizeInFrames: Int {
        return Int(ref.getBufferSizeInFrames())
    }

    public var bufferCapacityInFrames: Int {
        return Int(ref.getBufferCapacityInFrames())
    }

    public var sharingMode: SharingMode {
        return SharingMode(ref.getSharingMode())
    }

    public var performanceMode: PerformanceMode {
        return PerformanceMode(ref.getPerformanceMode())
    }

    public var deviceId: Int {
        return Int(ref.getDeviceId())
    }

    public var isDataCallbackSpecified: Bool {
        return ref.isDataCallbackSpecified()
    }

    public var isErrorCallbackSpecified: Bool {
        return ref.isErrorCallbackSpecified()
    }

    public var usage: Usage {
        return Usage(ref.getUsage())
    }

    public var contentType: ContentType {
        return ContentType(ref.getContentType())
    }

    public var inputPreset: InputPreset {
        return InputPreset(ref.getInputPreset())
    }

    public var sessionId: SessionId {
        return SessionId(ref.getSessionId())
    }

    public var isContentSpatialized: Bool {
        return ref.isContentSpatialized()
    }

    public var spatializationBehavior: SpatializationBehavior {
        return SpatializationBehavior(ref.getSpatializationBehavior())
    }

    public var allowedCapturePolicy: AllowedCapturePolicy {
        return AllowedCapturePolicy(ref.getAllowedCapturePolicy())
    }

    public var privacySensitiveMode: PrivacySensitiveMode {
        return PrivacySensitiveMode(ref.getPrivacySensitiveMode())
    }

    public var isChannelConversionAllowed: Bool {
        return ref.isChannelConversionAllowed()
    }

    public var isFormatConversionAllowed: Bool {
        return ref.isFormatConversionAllowed()
    }

    public var sampleRateConversionQuality: SampleRateConversionQuality {
        return SampleRateConversionQuality(ref.getSampleRateConversionQuality())
    }

    public var channelMask: ChannelMask {
        return ChannelMask(ref.getChannelMask())
    }

    public var hardwareChannelCount: Int {
        return Int(ref.getHardwareChannelCount())
    }

    public var hardwareSampleRate: Int {
        return Int(ref.getHardwareSampleRate())
    }

    public var hardwareFormat: AudioFormat {
        return AudioFormat(ref.getHardwareFormat())
    }
}
