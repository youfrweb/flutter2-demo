
import 'package:flutter/material.dart';
import 'package:flutter2_demo/pages/myCustomForm.dart';
import 'package:flutter2_demo/pages/myHomePage.dart';
import 'package:flutter2_demo/pages/stateLessWidgetDemo.dart';

/// 路由配置
final routes = {
  '/': (context, {arguments}) => MyHomePage(),
  '/form': (context, {arguments}) => MyCustomForm(arguments: arguments),
  '/stateLess': (context, {arguments}) => StateLessWidgetDemo(),
};

// 处理参数传递
Route<dynamic> onGenerateRoute (RouteSettings settings) {
  // 获取声明的路由页面函数
  var pageBuilder = routes[settings.name];
  if (pageBuilder != null) {
    if (settings.arguments != null) {
      // 创建路由页面并携带参数
      // settings: RouteSettings(name: settings.name) 设置浏览器的 url
      return MaterialPageRoute(
          builder: (context) =>
              pageBuilder(context, arguments: settings.arguments), settings: RouteSettings(name: settings.name));
    } else {
      return MaterialPageRoute(
          builder: (context) => pageBuilder(context), settings: RouteSettings(name: settings.name));
    }
  }
  return MaterialPageRoute(builder: (context) => MyHomePage(), settings: RouteSettings(name: settings.name));
}