import 'package:flutter/material.dart';
import 'package:posty/screens/authentication_screen.dart';
import 'package:posty/screens/posts_screens.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'POSTY',
      home: AuthenticationScreen(),
    );
  }
}
