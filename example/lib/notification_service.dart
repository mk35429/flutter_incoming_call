


import 'dart:collection';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_incoming_call/flutter_incoming_call.dart';
import 'package:flutter_incoming_call_example/routes.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class NotificationService{

  // Global navigation key for whole application
  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  //Singleton pattern
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  static NotificationService get instance => _notificationService;

  Future<void> init() async{
    initFirebaseListeners();
    String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      debugPrint("fcmToken = $token");
    }
    getDevicePushTokenVoIP();
  }
  void initFirebaseListeners(){
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("Foreground notification opened");
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async{
      print("Foreground notification received");
      showCallkitIncoming(const Uuid().v4());
    });
  }

  void initCallkitListener(){
    FlutterIncomingCall.onEvent.listen((event) {
      switch (event!.name) {
        case CallEvent.ACTION_CALL_INCOMING:
        // TODO: received an incoming call
          break;
        case CallEvent.ACTION_CALL_START:
        // TODO: started an outgoing call
        // TODO: show screen calling in Flutter
          break;
        case CallEvent.ACTION_CALL_ACCEPT:
          print("ACTION_CALL_ACCEPT");
          Get.toNamed(Routes.ongoingScreen);
          // Navigator.of(navigationKey.currentContext!).push(MaterialPageRoute(builder: (context) => OnGoingScreen()));
        // TODO: accepted an incoming call
        // TODO: show screen calling in Flutter
          break;
        case CallEvent.ACTION_CALL_DECLINE:
        // TODO: declined an incoming call
          break;
        case CallEvent.ACTION_CALL_ENDED:
        // TODO: ended an incoming/outgoing call
          break;
        case CallEvent.ACTION_CALL_TIMEOUT:
        // TODO: missed an incoming call
          break;
        case CallEvent.ACTION_CALL_CALLBACK:
        // TODO: only Android - click action `Call back` from missed call notification
          break;
        case CallEvent.ACTION_CALL_TOGGLE_HOLD:
        // TODO: only iOS
          break;
        case CallEvent.ACTION_CALL_TOGGLE_MUTE:
        // TODO: only iOS
          break;
        case CallEvent.ACTION_CALL_TOGGLE_DMTF:
        // TODO: only iOS
          break;
        case CallEvent.ACTION_CALL_TOGGLE_GROUP:
        // TODO: only iOS
          break;
        case CallEvent.ACTION_CALL_TOGGLE_AUDIO_SESSION:
        // TODO: only iOS
          break;
        case CallEvent.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
        // TODO: only iOS
          break;
      }
    });
  }

  Future<void> getDevicePushTokenVoIP() async {
    var devicePushTokenVoIP =
    await FlutterIncomingCall.getDevicePushTokenVoIP();
    print(devicePushTokenVoIP);
  }

  Future<Map<String, dynamic>?> getPushNotificationRoute() async{
    var currentCall = await getCurrentCall();
    if(currentCall!=null){
      Map<String, dynamic> data = HashMap();
      data['screen'] = Routes.ongoingScreen;
      data['args'] = currentCall;
      return data;
    }
    return null;
  }

  Future getCurrentCall() async {
    //check current call from pushkit if possible
    var calls = await FlutterIncomingCall.activeCalls();
    if (calls is List) {
      if (calls.isNotEmpty) {
        print('DATA: $calls');
        // calls[0]['id'];
        return calls[0];
      } else {
        return null;
      }
    }
  }

  Future<void> endCurrentCall() async {
    var data = await getCurrentCall();
    var params = <String, dynamic>{'id': data['id']};
    await FlutterIncomingCall.endCall(params);
  }

  Future<void> showCallkitIncoming(String uuid) async {
    var params = <String, dynamic>{
      'id': uuid,
      'nameCaller': 'Hien Nguyen',
      'appName': 'Callkit',
      'avatar': 'https://i.pravatar.cc/100',
      'handle': '0123456789',
      'type': 0,
      'duration': 30000,
      'textAccept': 'Accept',
      'textDecline': 'Decline',
      'textMissedCall': 'Missed call',
      'textCallback': 'Call back',
      'extra': <String, dynamic>{'userId': '1a2b3c4d'},
      'headers': <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      'android': <String, dynamic>{
        'isCustomNotification': true,
        'isShowLogo': false,
        'isShowCallback': false,
        'ringtonePath': 'system_ringtone_default',
        'backgroundColor': '#0955fa',
        'backgroundUrl': 'https://i.pravatar.cc/500',
        'actionColor': '#4CAF50'
      },
      'ios': <String, dynamic>{
        'iconName': 'CallKitLogo',
        'handleType': '',
        'supportsVideo': true,
        'maximumCallGroups': 2,
        'maximumCallsPerCallGroup': 1,
        'audioSessionMode': 'default',
        'audioSessionActive': true,
        'audioSessionPreferredSampleRate': 44100.0,
        'audioSessionPreferredIOBufferDuration': 0.005,
        'supportsDTMF': true,
        'supportsHolding': true,
        'supportsGrouping': false,
        'supportsUngrouping': false,
        'ringtonePath': 'system_ringtone_default'
      }
    };
    await FlutterIncomingCall.showCallkitIncoming(params);
  }

}