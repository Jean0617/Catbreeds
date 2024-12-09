import 'package:flutter/material.dart';

import 'package:catbreeds/screens/home_screen.dart';

class AppRoutes {

  //ROUTES APP
  static const String home = '/';

  static Map<String, Widget Function(BuildContext)> buildRoutes(){
    return {
      home: (_) => const HomeScreen()
    };
  }

}