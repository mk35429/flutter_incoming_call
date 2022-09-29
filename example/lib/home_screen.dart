


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
          NotificationService().showCallkitIncoming(const Uuid().v4());
        },
        child: Text("Make call", style: TextStyle(color: Colors.black),)),
      ),
    );
  }

}