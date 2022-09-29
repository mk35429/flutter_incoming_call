import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_incoming_call_platform_interface.dart';

/// An implementation of [FlutterIncomingCallPlatform] that uses method channels.
class MethodChannelFlutterIncomingCall extends FlutterIncomingCallPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_incoming_call');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
