import 'package:flutter/material.dart';

/// 这里继承自 InheritedWidget 这个类
/// 可以在 weiget 中通过上下文获取到环境变量
/// 当然 也可把 主题和一些全局 设置放到这里
class ENV extends InheritedWidget {
  static String appName; // 系统名称
  static String envName; // 运行环境
  static String baseUrl; // 基础url

  ENV({
    @required String appName,
    @required String envName,
    @required String baseUrl,
    @required Widget child,
  }) : super(child: child){
    ENV.appName = appName;
    ENV.envName = envName;
    ENV.baseUrl = baseUrl;
  }
  // 这里 是在 weiget 中拿到当前环境变量的关键
  static ENV of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: ENV);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}