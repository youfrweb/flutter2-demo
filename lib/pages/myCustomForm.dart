import 'package:flutter/material.dart';

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
  String _title = '111';
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
  }

  Widget _formModal() {
    final List<Map> _formItem = [
      {"key": "name", "cn": "用户名", "value": "", "icon": Icons.person},
      {"key": "password", "cn": "密码", "value": "", "icon": Icons.lock},
    ];
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
              child: Column(
                children: _formItem
                    .map((item) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                            decoration: InputDecoration(
                                labelText: '输入${item["cn"]}',
                                icon: Icon(item["icon"]),
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                ),
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
                          ),
                    ))
                    .toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //如果表单有效，则Validate返回true，否则返回false。
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  print('用户名：${_formItem[0]["value"]}  密码： ${_formItem[1]["value"]}');
//                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
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
}
