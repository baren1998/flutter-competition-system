import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:fluttercompetitionsystem/provider/notification_provider.dart';
import 'package:fluttercompetitionsystem/provider/user_provider.dart';
import 'package:fluttercompetitionsystem/routers/application.dart';
import 'package:provider/provider.dart';
import '../notification/notification_dialog.dart';

class MyHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(1920),
      height: ScreenUtil().setHeight(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _notification(),
          SizedBox(width: ScreenUtil().setWidth(24)),
          _loginButton(),
          SizedBox(width: ScreenUtil().setWidth(80)),
          CircleAvatar(
            child: Image.asset(
              'images/avatar1.jpg',
              width: ScreenUtil().setWidth(80),
              height: ScreenUtil().setHeight(80),
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(8)),
          _userInfo(),
        ],
      )
    );
  }

  Widget _userInfo() {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Container(
          width: ScreenUtil().setWidth(276),
          height: ScreenUtil().setHeight(72),
          padding: EdgeInsets.only(left: 16.0, top: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                provider.userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: ScreenUtil().setSp(20),
                  decoration: TextDecoration.none
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(8.0)),
              Text(
                provider.email,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: ScreenUtil().setSp(20),
                  decoration: TextDecoration.none
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _loginButton() {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Container(
          width: ScreenUtil().setWidth(144),
          height: ScreenUtil().setHeight(44),
          child: RaisedButton(
            color: Colors.lightBlue[300],
            child: Text(
              '登录',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(18.0),
              ),
            ),
            onPressed: provider.isLogin ? null : () {
              Application.router.navigateTo(context, '/login');
            },
          ),
        );
      },
    );
  }

  Widget _notification() {
    return Consumer<UserProvider>(
      builder: (context, provider, child) {
        return Container(
          width: ScreenUtil().setWidth(160),
          height: ScreenUtil().setHeight(44),
          child: RaisedButton(
            color: provider.hasNewMessage ? Colors.deepOrange : Colors.white,
            onPressed: provider.isLogin ? () {
              provider.changeHasNewMessage();
              Provider.of<NotificationProvider>(context, listen: false).pullNotifications();
              showDialog(
                context: context,
                builder: (context) {
                  return NotificationDialog();
                }
              );
            } : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.message, color: provider.hasNewMessage ? Colors.white : Colors.black38),
                SizedBox(width: ScreenUtil().setWidth(12)),
                Text(
                  provider.hasNewMessage ? '有新通知' : '消息通知',
                  style: TextStyle(
                    color: provider.hasNewMessage ? Colors.white : Colors.black38,
                    fontSize: ScreenUtil().setSp(20),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}