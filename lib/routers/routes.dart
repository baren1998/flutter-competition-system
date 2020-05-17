import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routes {
  static String root = '/';
  static String homePage = '/home';
  static String loginPage = '/login';
  static String registerPage = '/register';

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          print('ERROR===>ROUTE WAS NOT FOUND');
        }
    );

    router.define(homePage, handler: homeHandler);
    router.define(loginPage, handler: loginHandler);
    router.define(registerPage, handler: registerHandler);
  }
}