//
//  AudioStreamBuilder.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 1, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

import OboeBridge
import oboe

public struct AudioStreamBuilder {
    var ref: oboe.bridge.AudioStreamBuilderRef

    public init() {
        self.ref = oboe.bridge.AudioStreamBuilderRef.make()
    }

    public func setChannelCount(_ channelCount: Int) -> AudioStreamBuilder {
        ref.setChannelCount(Int32(channelCount))
        return self
    }

    public func setChannelMask(_ channelMask: ChannelMask) -> AudioStreamBuilder {
        ref.setChannelMask(channelMask.oboeValue)
        return self
    }

    public func setSampleRate(_ sampleRate: Int) -> AudioStreamBuilder {
        ref.setSampleRate(Int32(sampleRate))
        return self
    }

    public func setFramesPerDataCallback(_ framesPerCallback: Int) -> AudioStreamBuilder {
        ref.setFramesPerDataCallback(Int32(framesPerCallback))
        return self
    }

    public func setFormat(_ format: AudioFormat) -> AudioStreamBuilder {
        ref.setFormat(format.oboeValue)
        return self
    }

    public func setBufferCapacityInFrames(_ bufferCapacityInFrames: Int) -> AudioStreamBuilder {
        ref.setBufferCapacityInFrames(Int32(bufferCapacityInFrames))
        return self
    }

    public var audioApi: AudioApi {
        get {
            return AudioApi(ref.getAudioApi())
        }
        set {
            ref.setAudioApi(newValue.oboeValue)
        }
    }

    public func setAudioApi(_ audioApi: AudioApi) -> AudioStreamBuilder {
        ref.setAudioApi(audioApi.oboeValue)
        return self
    }

    static var isAAudioSupported: Bool {
        return oboe.bridge.AudioStreamBuilderRef.isAAudioSupported()
    }

    static var isAAudioRecommended: Bool {
        return oboe.bridge.AudioStreamBuilderRef.isAAudioRecommended()
    }

    public func setSharingMode(_ sharingMode: SharingMode) -> AudioStreamBuilder {
        ref.setSharingMode(sharingMode.oboeValue)
        return self
    }

    public func setPerformanceMode(_ performanceMode: PerformanceMode) -> AudioStreamBuilder {
        ref.setPerformanceMode(performanceMode.oboeValue)
        return self
    }

    public func setUsage(_ usage: Usage) -> AudioStreamBuilder {
        ref.setUsage(usage.oboeValue)
        return self
    }

    public func setContentType(_ contentType: ContentType) -> AudioStreamBuilder {
        ref.setContentType(contentType.oboeValue)
        return self
    }

    public func setInputPreset(_ inputPreset: InputPreset) -> AudioStreamBuilder {
        ref.setInputPreset(inputPreset.oboeValue)
        return self
    }

    public func setSessionId(_ sessionId: SessionId) -> AudioStreamBuilder {
        ref.setSessionId(sessionId.oboeValue)
        return self
    }

    public func setDeviceId(_ deviceId: Int) -> AudioStreamBuilder {
        ref.setDeviceId(Int32(deviceId))
        return self
    }

    public func setAllowedCapturePolicy(_ allowedCapturePolicy: AllowedCapturePolicy) -> AudioStreamBuilder {
        ref.setAllowedCapturePolicy(allowedCapturePolicy.oboeValue)
        return self
    }

    public func setPrivacySensitiveMode(_ privacySensitiveMode: PrivacySensitiveMode) -> AudioStreamBuilder {
        ref.setPrivacySensitiveMode(privacySensitiveMode.oboeValue)
        return self
    }

    public func setIsContentSpatialized(_ isContentSpatialized: Bool) -> AudioStreamBuilder {
        ref.setIsContentSpatialized(isContentSpatialized)
        return self
    }

    public func setSpatializationBehavior(_ spatializationBehavior: SpatializationBehavior) -> AudioStreamBuilder {
        ref.setSpatializationBehavior(spatializationBehavior.oboeValue)
        return self
    }

    public func setUnsafeDataCallback(_ callback: @escaping UnsafeRawDataCallback) {
        let closureRef = oboe.bridge.SwiftRef(callback as AnyObject)
        let callbackRef = oboe.bridge.SwiftDataCallbackRef.make(closureRef) {
            (context, audioStreamRef, data, numFrames) in
            let audioStream = AudioStream(audioStreamRef.pointee)
            let closure = context!.pointee.object as! UnsafeRawDataCallback
            let result = closure(audioStream, UnsafeMutableRawPointer(data!), numFrames)
            return result.oboeValue
        }
        ref.setDataCallback(callbackRef)
    }

    public func setUnsafeDataCallback<T>(_ callback: @escaping UnsafeDataCallback<T>) {
        setUnsafeDataCallback { (audioStream, data, numFrames) in
            precondition(MemoryLayout<T>.stride == audioStream.bytesPerSample, "Inconsistent sample size")
            let buffer = UnsafeMutableBufferPointer<T>(start: data.assumingMemoryBound(to: T.self), count: numFrames * audioStream.channelCount)
            return callback(audioStream, buffer, numFrames)
        }
    }

    public func setOutputDataCallback<T>(_ callback: @escaping OutputDataCallback<T>) {
        setUnsafeDataCallback { (audioStream, data, numFrames) in
            precondition(MemoryLayout<T>.stride == audioStream.bytesPerSample, "Inconsistent sample size")
            let buffer = UnsafeMutableBufferPointer<T>(start: data.assumingMemoryBound(to: T.self), count: numFrames * audioStream.channelCount)
            var span = MutableSpan<T>(_unsafeElements: buffer)
            return callback(audioStream, &span, numFrames)
        }
    }

    public func setInputDataCallback<T>(_ callback: @escaping InputDataCallback<T>) {
        setUnsafeDataCallback { (audioStream, data, numFrames) in
            precondition(MemoryLayout<T>.stride == audioStream.bytesPerSample, "Inconsistent sample size")
            let buffer = UnsafeBufferPointer<T>(start: data.assumingMemoryBound(to: T.self), count: numFrames * audioStream.channelCount)
            let span = Span<T>(_unsafeElements: buffer)
            return callback(audioStream, span, numFrames)
        }
    }

    public func setErrorCallback(_ callback: @escaping ErrorCallback) {
        let closureRef = oboe.bridge.SwiftRef(callback as AnyObject)
        let callbackRef = oboe.bridge.SwiftErrorCallbackRef.make(closureRef) {
            (context, audioStream, phase, result) in
            let closure = context!.pointee.object as! ErrorCallback
            if phase == oboe.bridge.SwiftErrorCallbackPhase.OnError {
                return closure(AudioStream(audioStream.pointee), Result(result))
            } else {
                return false
            }
        }
        ref.setErrorCallback(callbackRef)
    }

    public func setErrorCallbackObject(_ callback: any ErrorCallbackObject) {
        let objectRef = oboe.bridge.SwiftRef(callback as AnyObject)
        let callbackRef = oboe.bridge.SwiftErrorCallbackRef.make(objectRef) {
            (context, audioStream, phase, result) in
            let object = context!.pointee.object as! ErrorCallbackObject
            switch phase {
            case oboe.bridge.SwiftErrorCallbackPhase.OnError:
                return object.onError(audioStream: AudioStream(audioStream.pointee), error: Result(result))
            case oboe.bridge.SwiftErrorCallbackPhase.OnErrorBeforeClose:
                object.onErrorBeforeClose(audioStream: AudioStream(audioStream.pointee), error: Result(result))
                return false
            case oboe.bridge.SwiftErrorCallbackPhase.OnErrorAfterClose:
                object.onErrorAfterClose(audioStream: AudioStream(audioStream.pointee), error: Result(result))
                return false
            default:
                fatalError()
            }
        }
        ref.setErrorCallback(callbackRef)
    }

    public func setChannelConversionAllowed(_ allowed: Bool) -> AudioStreamBuilder {
        ref.setChannelConversionAllowed(allowed)
        return self
    }

    public func setFormatConversionAllowed(_ allowed: Bool) -> AudioStreamBuilder {
        ref.setFormatConversionAllowed(allowed)
        return self
    }

    public func setSampleRateConversionQuality(_ quality: SampleRateConversionQuality) -> AudioStreamBuilder {
        ref.setSampleRateConversionQuality(quality.oboeValue)
        return self
    }

    public func setPackageName(_ packageName: String) -> AudioStreamBuilder {
        ref.setPackageName(packageName)
        return self
    }

    public func setAttributionTag(_ attributionTag: String) -> AudioStreamBuilder {
        ref.setAttributionTag(attributionTag)
        return self
    }

    public var willUseAAudio: Bool {
        return ref.willUseAAudio()
    }

    public func openStream() -> ResultWithValue<AudioStream> {
        var stream = AudioStream()
        let result = ref.openStream(&stream.ref)
        if (result == oboe.Result.OK) {
            precondition(!stream.ref.isNull())
            return .success(stream)
        } else {
            precondition(stream.ref.isNull())
            return .failure(Result(result))
        }
    }
}
