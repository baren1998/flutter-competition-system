import 'package:flutter/material.dart';
import '../config/service_url.dart';
import '../service/service_method.dart';
import '../model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {

  bool _isLogin = false;  // 用户是否登录
  String _userName = '';
  String _email = '';
  bool _hasNewMessage = false; // 有没有新通知

  bool get isLogin => _isLogin;
  String get userName => _userName;
  String get email => _email;
  bool get hasNewMessage => _hasNewMessage;

  void changeHasNewMessage() {
    _hasNewMessage = false;
    notifyListeners();
  }

  void loginSuccess(User user) {
    _isLogin = true;
    _userName = user.name;
    _email = user.email;
    notifyListeners();
    newMessage();
  }

  void newMessage() async {
    // 从缓存中取出用户上次登录的时间，并且判断是否有新消息
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
//      DateTime lastLogin = DateTime.parse(prefs.getString("lastLogin"));
      String lastLoginStr = prefs.getString('${_userName}-lastLogin');
      if(lastLoginStr != null && lastLoginStr != '') {
        DateTime lastLogin = DateTime.parse(lastLoginStr);
        request(servicePath['getLastNotifyTime']).then((value) {
          DateTime lastNotify = DateTime.parse(value);
          // 如果最后一次通知时间晚于该用户的最后一次登录时间，则说明有新通知
          if (lastNotify.isAfter(lastLogin)) {
            _hasNewMessage = true;
            notifyListeners();
          }
        });
      } else {
        _hasNewMessage = true;
        notifyListeners();
      }
      // 更新用户的最后登陆时间
      prefs.setString('${_userName}-lastLogin', DateTime.now().toString());
    } catch(e) {
      print(e);
    }
  }
}