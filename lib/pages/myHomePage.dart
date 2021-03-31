import 'package:flutter/material.dart';
import 'package:flutter2_demo/app_config.dart';
import 'package:flutter2_demo/main-navigator.dart';
import 'package:flutter2_demo/pages/myCustomForm.dart';
//import 'package:flutter/cupertino.dart';
//Material 设计风格是为全平台设计的，不仅仅只是 Android 。当你使用 Flutter 编写一个 Material 风格的 app 时，它运行在任何平台上都是有着 Material 的设计展示，即使是在 iOS 下。但是如果你想要让你的 app 更像标准的 iOS 风格的话，那你就需要用到 Cupertino 库了。
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold通常被用作MaterialApp的子Widget，它会填充可用空间，占据整个窗口或设备屏幕。
    // Scaffold提供了大多数应用程序都应该具备的功能，
    // 例如顶部的appBar，底部的bottomNavigationBar，隐藏的侧边栏drawer等。
    return Scaffold(
      appBar: AppBar(
        title: Text(ENV.appName),
//        title: Text(ENV.appName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/form', arguments: {
                       "title": "登录页面"
                      });
//                      MyRouteDelegate.of(context).push('/form');
                    },
                    child: Text('page1'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {Navigator.of(context).pushNamed('/stateLess');},
                    child: Text('page2'),
                  ),
                ),
              ],
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
