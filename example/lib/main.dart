import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ios_volume_control/ios_volume_control.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  double volume = 0.0;

  @override
  void initState() {
    super.initState();
    initPlatformState();

  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      IosVolumeControl.getCurrentVolume().then((value){
        print("Volume: " + value.toString());
        setState(() {
          volume = value;
        });
      });

        //await IosVolumeControl.setVolume(.3);
      print("Volume: " + volume.toString());
      platformVersion = await IosVolumeControl.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoButton(child: Text("Volume Level", style: TextStyle(color: Colors.white),), onPressed: (){
                print("'Current Volume Level:' + $volume");
              }, color: Colors.lightBlue,),

              CupertinoSlider(value: volume, onChanged: _onVolumeChange)
            ],
          ),
        ),
      ),
    );
  }

  void _onVolumeChange(double value) {
    setState(() {
      volume = value;
      IosVolumeControl.setVolume(volume);
    });
  }
}
