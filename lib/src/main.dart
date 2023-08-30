import 'package:flutter/material.dart';
import 'package:nimulo_app/src/core/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'ui/pages/home_page.dart';
import 'ui/themes/default_theme.dart';
import './utils/logger.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AuthService(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final appName = "Nimulo - A Language Learning App";

  @override
  Widget build(BuildContext context) {
    //watch for when the auth status changes
    final authStatus = context.watch<AuthService>().status;
    logger.d("Auth status changed to: $authStatus");

    return MaterialApp(
      title: appName,
      theme: defaultTheme,
      home: MyHomePage(title: appName),
    );
  }
}
