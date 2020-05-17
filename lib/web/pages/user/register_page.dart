import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:fluttercompetitionsystem/routers/application.dart';
import '../../../service/service_method.dart';
import '../../../config/service_url.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController1 = new TextEditingController();
  TextEditingController _pwdController2 = new TextEditingController();  // 确认密码
  TextEditingController _emailController = new TextEditingController();

  // 邮箱正则
  final String _regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";

  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('赛伴——大数据竞赛自动发布与通知系统'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Container(
          width: ScreenUtil().setWidth(814),
          height: ScreenUtil().setHeight(648),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24.0)),
              border: Border.all(width: 1.0, color: Colors.black38)
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(20)),
              _registerBar(),
              SizedBox(height: ScreenUtil().setHeight(36)),
              _inputForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerBar() {
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
        '注册',
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
              controller: _pwdController1,
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
          SizedBox(height: ScreenUtil().setHeight(36)),
          // 确认密码输入框
          Container(
            width: ScreenUtil().setWidth(460),
            height: ScreenUtil().setHeight(64),
            padding: EdgeInsets.only(left: 8.0, top: 24.0),
            child: TextFormField(
              controller: _pwdController2,
              obscureText: true,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: '确认密码',
                icon: Icon(Icons.lock),
              ),
              // 校验密码
              validator: (value) {
                return value == _pwdController1.text ? null : '两次输入密码必须一致';
              },
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(36)),
          // Email输入框
          Container(
            width: ScreenUtil().setWidth(460),
            height: ScreenUtil().setHeight(64),
            padding: EdgeInsets.only(left: 8.0, top: 24.0),
            child: TextFormField(
              controller: _emailController,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: '邮箱',
                icon: Icon(Icons.email),
              ),
              // 校验密码
              validator: (value) {
                return RegExp(_regexEmail).hasMatch(value.trim()) ? null : '邮箱格式错误';
              },
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(48)),
          Container(
            width: ScreenUtil().setWidth(460),
            height: ScreenUtil().setHeight(64),
            child: RaisedButton(
              color: Colors.lightBlue[300],
              child: Text('注册'),
              textColor: Colors.white,
              onPressed: () {
                if((_formKey.currentState as FormState).validate()) {
                  //TODO: 提交数据
                  String userName = _unameController.text;
                  String password = _pwdController1.text;
                  String email = _emailController.text;
                  register(context, userName, password, email);
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void register(BuildContext context, String userName, String password, String email) {
    var queryParams = {'userName' : userName};
    request(servicePath['findUserByName'], queryParams: queryParams).then((value) {
      if(value == 'OK') {
        // 对密码进行SHA1加密
        var bytes = utf8.encode(password);
        var digest = sha1.convert(bytes).toString();
        var now = DateTime.now().toString();
        var registerTime = now.substring(0, now.indexOf('.'));
        print(registerTime);
        var requestBody = {
          'userName': userName,
          'password': digest,
          'email' : email,
          'registerTime': registerTime
        };
        return post(servicePath['register'], requestBody);
      } else {
        return Future(() => '用户名已存在');
      }
    }).then((value) {
      if(value == '用户名已存在') {
        showToast('用户名已存在');
      } else if(value == 'REGISTER FAILED') {
        showToast('注册失败，请稍后再试');
      } else {
        showToast('注册成功');
        Application.router.navigateTo(context, '/login');
      }
    });
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green[400],
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}