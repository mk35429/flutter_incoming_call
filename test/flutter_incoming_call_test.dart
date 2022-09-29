import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_incoming_call/flutter_incoming_call.dart';
import 'package:flutter_incoming_call/flutter_incoming_call_platform_interface.dart';
import 'package:flutter_incoming_call/flutter_incoming_call_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterIncomingCallPlatform
    with MockPlatformInterfaceMixin
    implements FlutterIncomingCallPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterIncomingCallPlatform initialPlatform = FlutterIncomingCallPlatform.instance;

  test('$MethodChannelFlutterIncomingCall is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterIncomingCall>());
  });

  test('getPlatformVersion', () async {
    FlutterIncomingCall flutterIncomingCallPlugin = FlutterIncomingCall();
    MockFlutterIncomingCallPlatform fakePlatform = MockFlutterIncomingCallPlatform();
    FlutterIncomingCallPlatform.instance = fakePlatform;

    expect(await flutterIncomingCallPlugin.getPlatformVersion(), '42');
  });
}
