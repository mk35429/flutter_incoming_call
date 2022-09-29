

import 'package:flutter/material.dart';
import 'package:flutter_incoming_call_example/home_screen.dart';
import 'package:flutter_incoming_call_example/ongoing_call.dart';
import 'package:flutter_incoming_call_example/routes.dart';
import 'package:get/get.dart';

class RoutesGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch (settings.name) {
      case Routes.homeScreen:
        return GetPageRoute(
            routeName: settings.name, page: () => HomeScreen(), settings: settings,);
      case Routes.ongoingScreen:
        return GetPageRoute(
          routeName: settings.name, page: () => const OnGoingScreen(), settings: settings,);
      default:
        return GetPageRoute(
            routeName: settings.name, page: () => _errorRoute(), settings: settings);
    }
    }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('No Such screen found in route generator'),
      ),
    );
  }
  }