import 'dart:async';

import 'package:flutter/services.dart';

class IosVolumeControl {
  static const MethodChannel _channel =
      const MethodChannel('ios_volume_control');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<double> getCurrentVolume() async{
    double volume = await _channel.invokeMethod("checkCurrentVolume");
    return volume;
  }

  static Future<bool> setVolume(double volume) async {

    Map<String, dynamic> args = Map();
    args.putIfAbsent("volume", () => volume);

    print("Volume: " + volume.toString());

    double returnValue = await _channel.invokeMethod("setVolume", args);

    print("Value: " + returnValue.toString());

    return true;

  }
}
