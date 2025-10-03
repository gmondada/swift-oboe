//
//  Usage.swift
//
//  Created by Gabriele Mondada on 1.9.2025.
//  Copyright (c) 2025 Gabriele Mondada.
//  MIT License. See the file COPYRIGHT for details.
//

import oboe

public struct Usage: Sendable, Equatable {
    let oboeValue: oboe.Usage

    public static let media = Usage(oboe.Usage.Media)
    public static let voiceCommunication = Usage(oboe.Usage.VoiceCommunication)
    public static let voiceCommunicationSignalling = Usage(oboe.Usage.VoiceCommunicationSignalling)
    public static let alarm = Usage(oboe.Usage.Alarm)
    public static let notification = Usage(oboe.Usage.Notification)
    public static let notificationRingtone = Usage(oboe.Usage.NotificationRingtone)
    public static let notificationEvent = Usage(oboe.Usage.NotificationEvent)
    public static let assistanceAccessibility = Usage(oboe.Usage.AssistanceAccessibility)
    public static let assistanceNavigationGuidance = Usage(oboe.Usage.AssistanceNavigationGuidance)
    public static let assistanceSonification = Usage(oboe.Usage.AssistanceSonification)
    public static let game = Usage(oboe.Usage.Game)
    public static let assistant = Usage(oboe.Usage.Assistant)

    init(_ usage: oboe.Usage) {
        self.oboeValue = usage
    }
}
