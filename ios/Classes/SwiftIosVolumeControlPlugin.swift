import Flutter
import UIKit
import AVFoundation
import MediaPlayer;

public class SwiftIosVolumeControlPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ios_volume_control", binaryMessenger: registrar.messenger())
    let instance = SwiftIosVolumeControlPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if (call.method == "checkCurrentVolume") {
        let audioSession = AVAudioSession.sharedInstance()
        var currentVolume: Float?
        do {
            try audioSession.setActive(true)
            currentVolume = audioSession.outputVolume
            result(currentVolume)
        } catch {
            print("Error Setting Up Audio Session")
        }
        //result(volume);
    } else if (call.method == "setVolume"){
        let arguments = call.arguments as? NSDictionary
        let volume = arguments!["volume"] as? NSNumber ?? 0
        
        //print("Volume in swift: \(volume)")
        
        let floatVolume = Float(volume)
        
        MPVolumeView.setVolume(floatVolume)
        result(floatVolume);
    }
  }
}

extension MPVolumeView {
    static func setVolume(_ volume: Float) {
        let volumeView = MPVolumeView()
        let slider = volumeView.subviews.first(where: { $0 is UISlider }) as? UISlider
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            slider?.setValue(volume, animated: false)
            print("Volume in mp volume view: \(String(describing: slider?.value))")
        }
    }
}
