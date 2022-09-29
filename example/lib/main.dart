import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_incoming_call/flutter_incoming_call.dart';
import 'package:flutter_incoming_call_example/firebase_options.dart';
import 'package:flutter_incoming_call_example/notification_service.dart';
import 'package:flutter_incoming_call_example/route_generator.dart';
import 'package:flutter_incoming_call_example/routes.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

Future initializeFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("background notification received");
  await initializeFirebase();
  await NotificationService().init();
  NotificationService().showCallkitIncoming(const Uuid().v4());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await NotificationService().init();
  String initialRoute = await findInitialRoute();
  runApp(MyApp(initialRoute));
}

Future<String> findInitialRoute() async {
  String initialRoute = Routes.homeScreen;
  Map<String, dynamic>? map =
      await NotificationService().getPushNotificationRoute();
  if (map != null) {
    initialRoute = map['screen'];
    args = map['args'];
  } else {
    initialRoute = Routes.homeScreen;
  } // initialRoute = Routes.mainScreen;
  return initialRoute;
}

Object? args;

class MyApp extends StatelessWidget {

  late String initialRoute;

  MyApp(this.initialRoute, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GetMaterialApp(
        title: "Incoming Video Call",
        defaultTransition: Transition.rightToLeft,
        debugShowCheckedModeBanner: false,
        navigatorObservers: [ClearFocusOnPush()],
        initialRoute: Routes.homeScreen,
        onGenerateRoute: RoutesGenerator.generateRoute,
        onGenerateInitialRoutes: (String initialRouteName) {
          return [
            RoutesGenerator.generateRoute(
                RouteSettings(name: initialRoute, arguments: args)),
          ];
        },
      );
    });
  }
}

class ClearFocusOnPush extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();
  }
}
