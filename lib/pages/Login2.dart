import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  double sw;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  /// 接受表单中输入框内容
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ///点击登陆按钮弹出框文字状态
  final ValueNotifier<String> _dialogNotifier = ValueNotifier<String>("登录中…");

  ///控制错误提示是否显示
  final ValueNotifier<bool> _loginErrorMsgNotifier = ValueNotifier<bool>(false);

  ///控制密码是否可见
  final ValueNotifier<bool> _obscureTextNotifier = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    sw = window.physicalSize.width / window.devicePixelRatio;

    ///当前这一帧build完成之后就会调用 _afterLayout
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  void _afterLayout(_) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _loginMain(),
          _loginErrorMag(),
        ],
      ),
    );
  }

  Widget _loginMain() {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            _loginTop(),
            _loginForm(),
          ],
        ),
      ),
    );
  }

  Widget _loginErrorMag() {
    return ValueListenableBuilder(
      valueListenable: _loginErrorMsgNotifier,
      builder: (context, value, _) {
        return value
            ? Center(
                child: Container(
                  width: 290,
                  height: 210,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(22.5),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 40, bottom: 25),
                        child: Icon(Icons.clear, color: Color(0xFFFF4A4A), size: 70.0),
                      ),
                      Text(
                        '账号或密码错误',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container();
      },
    );
  }

  Widget _loginTop() {
    return Container(
      width: 314.0,
      height: 86.0,
      margin: const EdgeInsets.only(top: 60.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/login_title_bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          '登 录',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
//          _formMobileField(),
//          _formPasswordField(),
          _formField("name"),
          _formField("passw"),
          _formSubmitBtn(),
        ],
      ),
    );
  }

  Widget _formField(type) {
    return Container(
      width: 385.0,
      height: 77.0,
      margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      child: ValueListenableBuilder(
        valueListenable: _obscureTextNotifier,
        builder: (context, value, _) {
          return TextFormField(
            controller: type == "name" ? _mobileController : _passwordController,
            cursorColor: Colors.blue,
            obscureText: value,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            style: TextStyle(
              fontSize: 27.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              textBaseline: TextBaseline.ideographic,
            ),
            decoration: InputDecoration(
              hintText: type == "name" ? "输入账号" : "输入密码",
              hintStyle: TextStyle(
                color: Colors.black26,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              prefixIcon: Container(
                width: 50.0,
                height: 41.0,
                margin: const EdgeInsets.only(left: 40.0, right: 30.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(type == "name" ? "assets/images/phone_icon.png" : "assets/images/pass_icon.png"),
                    // fit: BoxFit.none,
                  ),
                ),
              ),
              suffixIcon: type == "name" ? SizedBox() : GestureDetector(
                onTap: () {
                  _obscureTextNotifier.value = !value;
                },
                child: Container(
                  width: 35.0,
                  height: 41.0,
                  margin: const EdgeInsets.only(right: 30.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: value == true ? AssetImage("assets/images/pass_hide_icon.png") : AssetImage("assets/images/pass_show_icon.png"),
                      // fit: BoxFit.none,
                    ),
                  ),
                ),
              ),
            ),
//        onSaved: (value) {
//          _pwd = value;
//        },
          );
        },
      ),
    );
  }

  Widget _formMobileField() {
    return Container(
      width: 385.0,
      height: 77.0,
      margin: const EdgeInsets.only(top: 51.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      child: TextFormField(
        controller: _mobileController,
        cursorColor: Colors.blue,
        style: TextStyle(
          fontSize: 27.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
          textBaseline: TextBaseline.ideographic,
        ),
        decoration: InputDecoration(
          hintText: '输入账号',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 30,
          ),
          prefixIcon: Container(
            width: 50.0,
            height: 41.0,
            margin: const EdgeInsets.only(left: 40.0, right: 30.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/phone_icon.png"),
                // fit: BoxFit.none,
              ),
            ),
          ),
        ),
//        onSaved: (value) {
//          _name = value;
//        },
      ),
    );
  }

  Widget _formPasswordField() {
    return Container(
      width: 385.0,
      height: 77.0,
      margin: const EdgeInsets.only(top: 38.0, bottom: 57.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
      child: ValueListenableBuilder(
        valueListenable: _obscureTextNotifier,
        builder: (context, value, _) {
          return TextFormField(
            controller: _passwordController,
            cursorColor: Colors.blue,
            obscureText: value,
            style: TextStyle(
              fontSize: 27.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              textBaseline: TextBaseline.ideographic,
            ),
            decoration: InputDecoration(
              hintText: '输入密码',
              hintStyle: TextStyle(
                color: Colors.black26,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 30,
              ),
              prefixIcon: Container(
                width: 50.0,
                height: 41.0,
                margin: const EdgeInsets.only(left: 40.0, right: 30.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/pass_icon.png"),
                    // fit: BoxFit.none,
                  ),
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  _obscureTextNotifier.value = !value;
                },
                child: Container(
                  width: 35.0,
                  height: 41.0,
                  margin: const EdgeInsets.only(right: 30.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: value == true ? AssetImage("assets/images/pass_hide_icon.png") : AssetImage("assets/images/pass_show_icon.png"),
                      // fit: BoxFit.none,
                    ),
                  ),
                ),
              ),
            ),
//        onSaved: (value) {
//          _pwd = value;
//        },
          );
        },
      ),
    );
  }

  Widget _formSubmitBtn() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.

          ScaffoldMessenger
              .of(context)
              .showSnackBar(SnackBar(content: Text('Processing Data')));
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
      ),
      child: Text(
        '登 录',
        style: TextStyle(
          fontSize: 30.0,
        ),
      ),
    );
  }

  /// 登陆处理函数
  void loginHandler() async {
    _showLoginDialog();
    _dialogNotifier.value = "登录中…";
    String mobile = _mobileController.text;
    String password = _passwordController.text;
//    final HttpService _httpService = HttpService();
//    Map<String, dynamic> params = {"mobile": mobile, "password": password};
//    // Map<String, dynamic> params = {"mobile": "17600850543", "password": "627515"};
//    await _httpService.doLogin(params).then((res) async {
//      StoringData().setItem(key: 'token', value: res['token']);
//      _dialogNotifier.value = "登陆成功";
//      await _closeLoginDialog();
//      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
//    }).catchError((e) async {
//      print("login error >>> $e");
//      Navigator.of(context).pop();
//      _loginErrorMsgNotifier.value = true;
//      var _duration = new Duration(seconds: 2);
//      await new Future.delayed(
//          _duration, () => _loginErrorMsgNotifier.value = false);
//    });
  }

  /// 关闭弹框
  Future<void> _closeLoginDialog() async {
    var _duration = new Duration(seconds: 1);
    await new Future.delayed(_duration, () => Navigator.of(context).pop());
  }

  /// 弹出登录中弹窗
  void _showLoginDialog() {
    showDialog(
      // 传入 context
      context: context,
      // 构建 Dialog 的视图
      builder: (_) => Padding(
        padding: EdgeInsets.all(16),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: 412.5,
                height: 434.5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/dialog_bg.png'),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ValueListenableBuilder(
                    valueListenable: _dialogNotifier,
                    builder: (context, value, _) {
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 150.0, bottom: 58.5),
                            child: Icon(Icons.check_circle, color: Colors.white, size: 75.5),
                          ),
                          Text(
                            value,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
