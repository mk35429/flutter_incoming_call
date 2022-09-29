import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_incoming_call_method_channel.dart';

abstract class FlutterIncomingCallPlatform extends PlatformInterface {
  /// Constructs a FlutterIncomingCallPlatform.
  FlutterIncomingCallPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterIncomingCallPlatform _instance = MethodChannelFlutterIncomingCall();

  /// The default instance of [FlutterIncomingCallPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterIncomingCall].
  static FlutterIncomingCallPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterIncomingCallPlatform] when
  /// they register themselves.
  static set instance(FlutterIncomingCallPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
