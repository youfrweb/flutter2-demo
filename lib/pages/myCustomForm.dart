import 'package:flutter/material.dart';
import 'package:flutter2_demo/main-navigator.dart';
import 'package:flutter2_demo/pages/myDio.dart';

class MyCustomForm extends StatefulWidget {
  final arguments;
  MyCustomForm({Key key, this.arguments}) : super(key: key);
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';

  final ValueNotifier<bool> _eyeIconNotifier = ValueNotifier(true);
  @override
  void initState() {
    super.initState();
    print('widget.arguments ${widget.arguments}');
    _title = widget.arguments != null ? widget.arguments["title"] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Container(
        alignment: Alignment.center,
        child: _formModal(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goBack,
        tooltip: 'back',
        child: Icon(Icons.arrow_left),
      ),
    );
  }

  _goBack () {
    Navigator.pop(context);
//    MyRouteDelegate.of(context).push('/');
//      void _removeLast() {
//    final delegate = MyRouteDelegate.of(context);
//    final stack = delegate.stack;
//    delegat e.remove(stack.last);
//    if (stack.length >= 2) {
//      delegate.remove(stack[stack.length - 1]);
//    }
//  }
  }

  final List<Map> _formItem = [
    {"key": "name", "cn": "用户名", "value": "", "icon": Icons.person},
    {"key": "password", "cn": "密码", "value": "", "icon": Icons.lock},
  ];

  Widget _formModal() {
    return Container(
      width: 400.0,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("登录", style: TextStyle(fontSize: 20.0)),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _formList(),
            ),
            ElevatedButton(
              onPressed: () {
                //如果表单有效，则Validate返回true，否则返回false。
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('用户名：${_formItem[0]["value"]}  密码： ${_formItem[1]["value"]}')));
                  _handleLogin(_formItem);
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              ),
              child: Text('登录'),
            ),
          ],
        ),
      ),
    );
  }

  _handleLogin (item) {
    MyDio().postRequestFunction({
      'name': item[0]["value"],
      'password': item[1]["value"]
    }).then((res) => {
      print('login :$res')
    }).catchError((e){
      print('login :$e');
    });
  }


  Widget _formList() {
    return Column(
      children: _formItem.map((item) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder(
          valueListenable: _eyeIconNotifier,
          builder: (context, value, _) {
            return TextFormField(
              obscureText: item["key"] == "name" ? false : value,
              decoration: InputDecoration(
                labelText: '输入${item["cn"]}',
                prefixIcon: Icon(item["icon"]),
                suffixIcon: _eyePassword(item["key"], value),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onSaved: (value) {
                item["value"] = value;
              },
              validator: (value) {
                /// 添加验证
                if (value.isEmpty) {
                  return '请填写${item["cn"]}';
                }
                return null;
              },
            );
          }
        ),
      ))
          .toList(),
    );
  }

  Widget _eyePassword(key, value) {
    return key == "name" ? SizedBox()
        : GestureDetector(
        onTap: (){
          _eyeIconNotifier.value = !value;
        },
        child: Icon(value ? Icons.visibility : Icons.visibility_off));
  }


}
