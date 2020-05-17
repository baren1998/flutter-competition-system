import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttercompetitionsystem/routers/application.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../service/service_method.dart';
import '../../../config/service_url.dart';
import '../../../provider/user_provider.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import '../../../model/user_model.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    //TODO: 通过缓存获取用户的登录信息
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 设置适配尺寸为1920x1080
    ScreenUtil.init(context, width: 1920, height: 1080, allowFontScaling: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('赛伴——大数据竞赛自动发布与通知系统'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Container(
          width: ScreenUtil().setWidth(814),
          height: ScreenUtil().setHeight(544),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(width: 1.0, color: Colors.black38)
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(20)),
              _loginBar(),
              SizedBox(height: ScreenUtil().setHeight(36)),
              _inputForm(),
              SizedBox(height: ScreenUtil().setHeight(40)),
              _accessAccount(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginBar() {
    return Container(
      width: ScreenUtil().setWidth(766),
      height: ScreenUtil().setHeight(64),
      padding: EdgeInsets.only(left: 32.0, top: 12.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromRGBO(216, 248, 255, 1.0), Colors.lightBlue[200]],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight
          )
      ),
      child: Text(
        '登录',
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(24),
        ),
      ),
    );
  }

  // 输入表单
  Widget _inputForm() {
    return Form(
      key: _formKey,
      autovalidate: true,
      child: Column(
        children: <Widget>[
          // 用户名输入框
          Container(
            width: ScreenUtil().setWidth(460),
            height: ScreenUtil().setHeight(64),
            padding: EdgeInsets.only(left: 8.0, top: 24.0),
            child: TextFormField(
              autofocus: true,
              maxLines: 1,
              controller: _unameController,
              decoration: InputDecoration(
                hintText: '用户名',
                icon: Icon(Icons.person),
              ),
              // 校验用户名
              validator: (value) {
                return value.trim().length >= 6 ? null : '用户名不能少于6位';
              },
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(36)),
          // 密码输入框
          Container(
            width: ScreenUtil().setWidth(460),
            height: ScreenUtil().setHeight(64),
            padding: EdgeInsets.only(left: 8.0, top: 24.0),
            child: TextFormField(
              controller: _pwdController,
              obscureText: true,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: '密码',
                icon: Icon(Icons.lock),
              ),
              // 校验密码
              validator: (value) {
                return value.trim().length >= 6 ? null : '密码不能少于6位';
              },
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(48)),
          Container(
            width: ScreenUtil().setWidth(460),
            height: ScreenUtil().setHeight(64),
            child: RaisedButton(
              color: Colors.lightBlue[300],
              child: Text('登录'),
              textColor: Colors.white,
              onPressed: () {
                if((_formKey.currentState as FormState).validate()) {
                  //TODO: 提交数据
                  String userName = _unameController.text;
                  String password = _pwdController.text;
                  login(context, userName, password);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  // 没有账户？点击注册
  Widget _accessAccount(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
          Application.router.navigateTo(context, '/register');
        },
        child: Container(
          width: ScreenUtil().setWidth(360),
          height: ScreenUtil().setHeight(52),
          child: Center(
            child: Text(
              '没有账户？点击注册',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext context, String userName, String password) {
    // 对密码进行SHA1加密
    var bytes = utf8.encode(password);
    var digest = sha1.convert(bytes).toString();
    var requestBody = {
      'userName': userName,
      'password': digest,
    };
    post(servicePath['login'], requestBody).then((value) {
      if(value == 'Login failed') {
        // 提示用户 用户名或者密码错误
        showToast('用户名或密码错误', Colors.redAccent);
      }
      else if(value is Map) {
        // 若果返回的value为Map类型，则说明登陆成功，跳转到首页并更新缓存
        showToast("登陆成功", Colors.green[400]);
        User user = User.fromJson(value);
        print('${user.name}-${user.email}-${user.registerTime}');
        Provider.of<UserProvider>(context, listen: false).loginSuccess(user);
        Application.router.navigateTo(context, '/home');
      }
      else {
        showToast('网络请求似乎出了一点问题，请稍后重试', Colors.redAccent);
      }
    });
  }

  void showToast(String message, Color bgColor) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: bgColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}