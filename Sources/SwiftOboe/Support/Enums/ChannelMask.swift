//
//  ChannelMask.swift
//  swift-oboe
//
//  Created by Gabriele Mondada on September 1, 2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file LICENSE for details.
//

import oboe

public struct ChannelMask {
    let oboeValue: oboe.ChannelMask

    public static let unspecified = oboe.ChannelMask.Unspecified
    public static let frontLeft = oboe.ChannelMask.FrontLeft
    public static let frontRight = oboe.ChannelMask.FrontRight
    public static let frontCenter = oboe.ChannelMask.FrontCenter
    public static let lowFrequency = oboe.ChannelMask.LowFrequency
    public static let backLeft = oboe.ChannelMask.BackLeft
    public static let backRight = oboe.ChannelMask.BackRight
    public static let frontLeftOfCenter = oboe.ChannelMask.FrontLeftOfCenter
    public static let frontRightOfCenter = oboe.ChannelMask.FrontRightOfCenter
    public static let backCenter = oboe.ChannelMask.BackCenter
    public static let sideLeft = oboe.ChannelMask.SideLeft
    public static let sideRight = oboe.ChannelMask.SideRight
    public static let topCenter = oboe.ChannelMask.TopCenter
    public static let topFrontLeft = oboe.ChannelMask.TopFrontLeft
    public static let topFrontCenter = oboe.ChannelMask.TopFrontCenter
    public static let topFrontRight = oboe.ChannelMask.TopFrontRight
    public static let topBackLeft = oboe.ChannelMask.TopBackLeft
    public static let topBackCenter = oboe.ChannelMask.TopBackCenter
    public static let topBackRight = oboe.ChannelMask.TopBackRight
    public static let topSideLeft = oboe.ChannelMask.TopSideLeft
    public static let topSideRight = oboe.ChannelMask.TopSideRight
    public static let bottomFrontLeft = oboe.ChannelMask.BottomFrontLeft
    public static let bottomFrontCenter = oboe.ChannelMask.BottomFrontCenter
    public static let bottomFrontRight = oboe.ChannelMask.BottomFrontRight
    public static let lowFrequency2 = oboe.ChannelMask.LowFrequency2
    public static let frontWideLeft = oboe.ChannelMask.FrontWideLeft
    public static let frontWideRight = oboe.ChannelMask.FrontWideRight

    public static let mono = oboe.ChannelMask.Mono
    public static let stereo = oboe.ChannelMask.Stereo
    public static let cm2Point1 = oboe.ChannelMask.CM2Point1
    public static let tri = oboe.ChannelMask.Tri
    public static let triBack = oboe.ChannelMask.TriBack
    public static let cm3Point1 = oboe.ChannelMask.CM3Point1
    public static let cm2Point0Point2 = oboe.ChannelMask.CM2Point0Point2
    public static let cm2Point1Point2 = oboe.ChannelMask.CM2Point1Point2
    public static let cm3Point0Point2 = oboe.ChannelMask.CM3Point0Point2
    public static let cm3Point1Point2 = oboe.ChannelMask.CM3Point1Point2
    public static let quad = oboe.ChannelMask.Quad
    public static let quadSide = oboe.ChannelMask.QuadSide
    public static let surround = oboe.ChannelMask.Surround
    public static let penta = oboe.ChannelMask.Penta
    public static let cm5Point1 = oboe.ChannelMask.CM5Point1
    public static let cm5Point1Side = oboe.ChannelMask.CM5Point1Side
    public static let cm6Point1 = oboe.ChannelMask.CM6Point1
    public static let cm7Point1 = oboe.ChannelMask.CM7Point1
    public static let cm5Point1Point2 = oboe.ChannelMask.CM5Point1Point2
    public static let cm5Point1Point4 = oboe.ChannelMask.CM5Point1Point4
    public static let cm7Point1Point2 = oboe.ChannelMask.CM7Point1Point2
    public static let cm7Point1Point4 = oboe.ChannelMask.CM7Point1Point4
    public static let cm9Point1Point4 = oboe.ChannelMask.CM9Point1Point4
    public static let cm9Point1Point6 = oboe.ChannelMask.CM9Point1Point6
    public static let frontBack = oboe.ChannelMask.FrontBack

    init(_ channelMask: oboe.ChannelMask) {
        self.oboeValue = channelMask
    }
}
