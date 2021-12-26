//
//  AVPlayer_Ding.swift
//  Scrumdinger (iOS)
//
//  Created by anthony on 2021/12/26.
//

import Foundation
import AVFoundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
}
