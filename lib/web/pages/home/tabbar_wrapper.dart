import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import '../../../provider/tabbar_provider.dart';
import '../../../provider/competitions_provider.dart';

class TabBarWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myTabBarWrapper(context);
  }

  // 自定义TabBar包装
  Widget _myTabBarWrapper(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(1920),
      height: ScreenUtil().setHeight(320),
      // 设置层叠组件
      child: Stack(
        children: <Widget>[
          Container(
            // 设置背景渐变色
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color.fromRGBO(173, 240, 242, 1.0), Color.fromRGBO(47, 154, 210, 1.0)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight
                )
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(88.0)),
              child: Text(
                '赛伴——大数据竞赛自动发布与通知系统',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(36.0),
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: _myTabBar(context),
          )
        ],
      ),
    );
  }

  // 自定义TabBar
  Widget _myTabBar(BuildContext context) {
    return Container(
        width: ScreenUtil().setWidth(1920),
        height: ScreenUtil().setHeight(70),
        decoration: BoxDecoration(
          // 设置背景色，且设置不透明度为20%
          color: Color.fromRGBO(94, 82, 82, 0.2)
        ),
        child: Center(
          child: Container(
            width: ScreenUtil().setWidth(1016),
            child: Row(
              children: <Widget>[
                _myTabBarItem(context, '全部', 0),
                _myTabBarItem(context, '算法赛', 1),
                _myTabBarItem(context, '创新应用赛', 2),
                _myTabBarItem(context, '学习赛', 3),
              ],
            ),
          ),
        ),
    );
  }

  // TabBar单项(一共有全部，算法赛，创新应用赛，新人赛四个单项，对应index分别为0,1,2,3)
  Widget _myTabBarItem(BuildContext context, String title, int index) {
      return Consumer2<TabBarProvider, CompetitionsProvider>(
        builder: (context, tabBarProvider, cmptProvider, child) {
          int selected = tabBarProvider.selected;
          if(selected == null) {
            selected = 0;
          }
          return Material(
            // 设置选中时的颜色
            color: index == selected ? Colors.lightBlueAccent : Color.fromRGBO(94, 82, 82, 0.4),
            child: InkWell(
              onTap: () {
                tabBarProvider.changeSelected(index);
                // 切换后的逻辑
                cmptProvider.changeCmptType(index);
              },
              child: Container(
                height: ScreenUtil().setHeight(70),
                width: ScreenUtil().setWidth(254),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(24),
                      fontWeight: FontWeight.w200,
                      decoration: TextDecoration.none
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
  }
}