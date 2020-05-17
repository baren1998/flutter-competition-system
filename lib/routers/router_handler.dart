import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../web/pages/user/login_page.dart';
import '../web/pages/user/register_page.dart';
import '../web/pages/home/home_page.dart';


Handler homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return HomePage();
    }
);

Handler loginHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return LoginPage();
  }
);

Handler registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return RegisterPage();
    }
);