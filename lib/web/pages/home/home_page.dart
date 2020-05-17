import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'tabbar_wrapper.dart';
import 'competition_listview.dart';
import '../../../provider/competitions_provider.dart';
import 'pagination.dart';
import 'header.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    // 初始化时默认请求pageNum为0即第一页的数据
    Provider.of<CompetitionsProvider>(context, listen: false).requestAllCompetitions(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 设置适配尺寸为1920x1080
    ScreenUtil.init(context, width: 1920, height: 1080, allowFontScaling: false);

    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        MyHeader(),
        TabBarWrapper(),
        SizedBox(height: ScreenUtil().setHeight(40)),
        CompetitionListView(),
        MyPagination(),
        SizedBox(height: ScreenUtil().setHeight(80))
      ],
    );
  }
}