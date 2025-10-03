//
//  SwiftRef.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 12, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

import OboeBridge

extension oboe.bridge.SwiftRef {
    init(_ object: AnyObject?) {
        if let object {
            let unmanagedPointer = Unmanaged.passRetained(object)
            let rawPointer = unmanagedPointer.toOpaque()
            self.init(rawPointer, true)
        } else {
            self.init(nil, true)
        }
    }

    var object: AnyObject? {
        get {
            let rawPointer = self.__getRawPointerUnsafe()
            guard let rawPointer else {
                return nil
            }
            let unmanagedPointer = Unmanaged<AnyObject>.fromOpaque(rawPointer)
            let object = unmanagedPointer.takeUnretainedValue()
            return object
        }
        set(object) {
            if let object {
                let unmanagedPointer = Unmanaged.passRetained(object)
                let rawPointer = unmanagedPointer.toOpaque()
                self.setRawPointer(rawPointer, true)
            } else {
                self.setRawPointer(nil)
            }
        }
    }
}

@_cdecl("oboe_bridge_SwiftRef_retain")
public func _SwiftRef_retain(rawPointer: UnsafeMutableRawPointer?) {
    let unmanagedPointer = Unmanaged<AnyObject>.fromOpaque(rawPointer!)
    _ = unmanagedPointer.retain()
}

@_cdecl("oboe_bridge_SwiftRef_release")
public func _SwiftRef_release(rawPointer: UnsafeMutableRawPointer?) {
    let unmanagedPointer = Unmanaged<AnyObject>.fromOpaque(rawPointer!)
    unmanagedPointer.release()
}

// never called, just there to check that C and Swift prototypes match
private func signatureCheck() {
    var f1 = oboe_bridge_SwiftRef_retain
    f1 = _SwiftRef_retain
    _ = f1 // suppress warning (unused var)
    var fp2 = _SwiftRef_retain
    fp2 = oboe_bridge_SwiftRef_retain
    _ = fp2

    var fp3 = oboe_bridge_SwiftRef_release
    fp3 = _SwiftRef_release
    _ = fp3
    var fp4 = _SwiftRef_release
    fp4 = oboe_bridge_SwiftRef_release
    _ = fp4
}
