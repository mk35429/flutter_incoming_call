import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_incoming_call/flutter_incoming_call_method_channel.dart';

void main() {
  MethodChannelFlutterIncomingCall platform = MethodChannelFlutterIncomingCall();
  const MethodChannel channel = MethodChannel('flutter_incoming_call');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
