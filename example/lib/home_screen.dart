


import 'package:flutter/material.dart';
import 'package:flutter_incoming_call_example/notification_service.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    NotificationService().initCallkitListener();
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: TextButton(onPressed: () {
          var uuid = const Uuid().v4();
          print("uuid : " + uuid);
          NotificationService().showCallkitIncoming(uuid);
        },
        child: Text("Make call", style: TextStyle(color: Colors.black),)),
      ),
    );
  }

}