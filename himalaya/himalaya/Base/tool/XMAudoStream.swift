//
//  XMAudoStream.swift
//  himalaya
//
//  Created by Farben on 2020/8/26.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import FreeStreamer
class XMAudoStream: NSObject {
    
    
    private var playerStream: FSAudioStream?
    
    var playComplete: (() -> ())?
    
    
    private static let shareAudoStream: XMAudoStream = {
        let shared = XMAudoStream()
        
        return shared
    }()
    
    class func sharePlayer() -> XMAudoStream {
        return shareAudoStream
    }
    
    private override init() {
        super.init()
        let config = FSStreamConfiguration()
        config.httpConnectionBufferSize *= 2
        config.enableTimeAndPitchConversion = true
        playerStream = FSAudioStream(configuration: config)
        playerStream?.delegate = self
        playerStream?.onFailure = {(error, errorDescription) in
            //播放错误
            //有待解决
        }
        playerStream?.onCompletion = {[weak self] in
            //播放完成
            if self?.playComplete != nil {
                self?.playComplete!()
            }
        }
        
        playerStream?.onStateChange = {(state) in
            switch state {
            case .fsAudioStreamRetrievingURL:
                print("检索url")
                break
            case .fsAudioStreamBuffering:
                print("缓冲中")
                break
            case .fsAudioStreamSeeking:
                print("seek中...")
                break
            case .fsAudioStreamPlaying:
                print("正在播放中")
                break
            case .fsAudioStreamStopped:
                print("停止播放")
                break
            case .fsAudioStreamPaused:
                print("暂停播放")
                break
            case .fsAudioStreamPlaybackCompleted:
                print("播放完成")
                break
            case .fsAudioStreamRetryingFailed:
                print("检索失败")
                break
            case .fsAudioStreamRetryingStarted:
                print("检索失败")
                break
            case .fsAudioStreamFailed:
                print("播放失败")
                break
            case .fsAudioStreamRetryingSucceeded:
                print("检索成功")
                break
            case .fsAudioStreamEndOfFile:
                print("缓冲结束")
                break
            case .fsAudioStreamUnknownState:
                print("未知状态")
                break
            default:
                break
            }
        }
        
    }
    
    //播放音量
    func setVolume(volume: Float) {
        playerStream?.volume = volume
    }
    
    //设置播放速率
    func setPlayRate(rate: Float) {
        playerStream?.setPlayRate(rate)
    }
    
    func stopPlayer() {
        if playerStream?.isPlaying() == true {
            playerStream?.stop()
        }
    }
    
    func pauser() {
        if playerStream?.isPlaying() == true {
            playerStream?.pause()
        }
    }
    
    func play() {
        playerStream?.play()
    }
    
    func playerFormUrl(urlString: String) {
        if let url = URL(string: urlString) {
             playerStream?.play(from: url)
        }
       
    }
}

extension XMAudoStream: FSPCMAudioStreamDelegate {
    
    func audioStream(_ audioStream: FSAudioStream!, samplesAvailable samples: UnsafeMutablePointer<AudioBufferList>!, frames: UInt32, description: AudioStreamPacketDescription) {
        
    }
}
