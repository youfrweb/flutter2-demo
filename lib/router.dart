
import 'package:flutter/material.dart';
import 'package:flutter2_demo/pages/myCustomForm.dart';
import 'package:flutter2_demo/pages/myHomePage.dart';
import 'package:flutter2_demo/pages/myInput.dart';
import 'package:flutter2_demo/pages/stateLessWidgetDemo.dart';

/// 路由配置

final routes = {
  '/': (context, {arguments}) => MyHomePage(),
  '/form': (context, {arguments}) => MyCustomForm(arguments: arguments),
  '/stateLessWidgetDemo': (context, {arguments}) => StateLessWidgetDemo(),
  '/myInput': (context, {arguments}) => MyInput(),
};

// 处理参数传递
Route<dynamic> onGenerateRoute (RouteSettings settings) {
  // 获取声明的路由页面函数
  var pageBuilder = routes[settings.name];
  if (pageBuilder != null) {
    if (settings.arguments != null) {
      // 创建路由页面并携带参数
      return MaterialPageRoute(
          builder: (context) =>
              pageBuilder(context, arguments: settings.arguments));
    } else {
      return MaterialPageRoute(
          builder: (context) => pageBuilder(context));
    }
  }
  return MaterialPageRoute(builder: (context) => MyHomePage());
}