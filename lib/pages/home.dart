/// author: liusilong
/// date: 2021/3/22 2:55 PM
/// description:
///
///
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/book/1');
          },
        ),
      ),
    );
  }
}
