import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import '../../../provider/notification_provider.dart';
import '../../../model/notification_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationDialog extends Dialog {

  @override
  Widget build(BuildContext context) {
    return Material(
      type:MaterialType.transparency,
      child: Center(
        child: Container(
          width: ScreenUtil().setWidth(688),
          height: ScreenUtil().setHeight(908),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: ScreenUtil().setHeight(24)),
              _titleBar(context),
              SizedBox(height: ScreenUtil().setHeight(24)),
              Container(
                width: ScreenUtil().setWidth(640),
                height: ScreenUtil().setHeight(760),
                child: Consumer<NotificationProvider>(
                builder: (_, provider, child) {
                  if(provider.notifications.length == 0) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else return ListView.builder(
                    itemCount: provider.notifications.length,
                    itemBuilder: (_, index) {
                      return _notificationItem(provider.notifications[index]);
                    },
                  );
                },
              ),
              ),
            ],
          )
        ),
      ),
    );
  }

  // 标题Bar组件
  Widget _titleBar(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(640),
      height: ScreenUtil().setHeight(60),
      padding: EdgeInsets.only(left: 24.0, right: 12.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color.fromRGBO(216, 248, 255, 1.0), Colors.lightBlue[200]],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight
          )
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '消息通知',
              style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(24),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: Colors.lightBlue[200],
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.close, size: 40, color: Colors.white),
              ),
            )
          )
        ],
      )
    );
  }

  // 内部ListView单项
  Widget _notificationItem(MyNotification notification) {
    return Container(
//      width: ScreenUtil().setWidth(592),
//      height: ScreenUtil().setHeight(160),
      margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(24)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(52),
            width: ScreenUtil().setWidth(592),
            child: Center(
              child: Text(
                DateTime.parse(notification.notifyTime).toString(),
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: ScreenUtil().setSp(18),
                ),
              ),
            ),
          ),
          SizedBox(height: 0.5, width: ScreenUtil().setWidth(592)),
          Container(
//            height: ScreenUtil().setHeight(108),
//            width: ScreenUtil().setWidth(592),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            child: ListTile(
              leading: Image.network(notification.coverImageUrl),
              title: Text(
                notification.cmptName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: ScreenUtil().setSp(18),
                ),
              ),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  notification.brief,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: ScreenUtil().setSp(16),
                  ),
                ),
              ),
              trailing: Material(
                color: Colors.white,
                child: InkWell(
                  child: Icon(Icons.keyboard_arrow_right, size: 42),
                  onTap: () async {
                    String url = notification.detailPageUrl;
                    if(await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
              )
            ),
          ),
        ],
      ),
    );
  }
}