import 'package:flutter/material.dart';
import 'package:flutter2_demo/app_config.dart';
import 'package:flutter2_demo/router/router.dart';

void main() {
  var configuredApp = ENV(
    appName: 'appName-pro',
    envName: "production",
    baseUrl: "http://yapi.aixuexi.com/mock/597",
    child: MyApp(),
  );
  runApp(configuredApp);
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: onGenerateRoute,
      navigatorKey: navigatorKey, // 不添加无法正常 hot r or R
    );
  }
}
