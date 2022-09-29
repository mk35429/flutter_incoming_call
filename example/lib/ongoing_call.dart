

import 'package:flutter/material.dart';
import 'package:flutter_incoming_call/flutter_incoming_call.dart';
import 'package:flutter_incoming_call_example/notification_service.dart';
import 'package:flutter_incoming_call_example/routes.dart';
import 'package:get/get.dart';

class OnGoingScreen extends StatefulWidget{
  const OnGoingScreen({super.key});

  @override
  State<OnGoingScreen> createState() => _OnGoingScreenState();
}

class _OnGoingScreenState extends State<OnGoingScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Text("Ongoing call", style: TextStyle(color: Colors.black),),
          SizedBox(height: 80,),
          GestureDetector(child: Text("End call", style: TextStyle(color: Colors.black),),
          onTap: (){
            // NavigationService.instance
            //     .pushReplacementNamed(Routes.homeScreen);
            Get.offAndToNamed(Routes.homeScreen);
          },),
        ],
      )),
    );
  }

  @override
  void dispose() {
    NotificationService().endCurrentCall();
    super.dispose();
  }
}