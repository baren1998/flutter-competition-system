import 'package:flutter/material.dart';
import 'package:fluttercompetitionsystem/provider/notification_provider.dart';
import 'package:fluttercompetitionsystem/provider/user_provider.dart';
import 'web/pages/home/home_page.dart';
import 'package:provider/provider.dart';
import 'provider/tabbar_provider.dart';
import 'provider/competitions_provider.dart';
import 'package:fluro/fluro.dart';
import 'routers/application.dart';
import 'routers/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 初始化路由
    final router = Router();


    Routes.configureRoutes(router);
    Application.router = router;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TabBarProvider()),
        ChangeNotifierProvider(create: (_) => CompetitionsProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
        title: '赛伴————大数据竞赛自动发布与通知系统',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.lightBlue,
        ),
        home: HomePage()
      ),
    );
  }
}
