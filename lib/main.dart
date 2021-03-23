import 'package:flutter/material.dart';
import 'package:flutter2_demo/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // MaterialApp是我们使用 Flutter开发中最常用的符合Material Design设计理念的入口Widget。
    // 你可以将它类比成为网页中的<html></html>，且它自带路由、主题色，<title>等功能。
    return MaterialApp(
      title: 'Flutter Demo',
//      routes: routes,

//      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: onGenerateRoute,
    );
  }
}



