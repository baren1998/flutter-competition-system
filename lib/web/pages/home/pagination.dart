import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import '../../../provider/competitions_provider.dart';

class MyPagination extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<CompetitionsProvider>(
      builder: (context, provider, child) {
        int totalPage = provider.pages;
        List<Widget> pagination = [];
        // 添加上一页
        pagination.add(_previousPage(provider));
        pagination.add(SizedBox(width: ScreenUtil().setWidth(20)));
        // 添加分页按钮
        for(int i = 1; i <= totalPage; i++) {
          pagination.add(_paginationItem(i, provider));
          pagination.add(SizedBox(width: ScreenUtil().setWidth(20)));
        }
        // 添加下一页
        pagination.add(_nextPage(provider));

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: pagination,
        );
      },
    );
  }

  // 自定义分页按钮(index从1开始)
  Widget _paginationItem(int index, CompetitionsProvider provider) {
    int currentPage = provider.currentPage;
    bool isSelected = currentPage == index;
    return Container(
      width: ScreenUtil().setWidth(48.0),
      height: ScreenUtil().setHeight(48.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: RaisedButton(
        onPressed: () {
          provider.changeCurrentPage(index);
        },
        color: isSelected ? Colors.lightBlueAccent : Colors.white,
        child: Center(
          child: Text(
            index.toString(),
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: ScreenUtil().setSp(14.0),
                fontWeight: FontWeight.w400
            ),
          ),
        ),
      ),
    );
  }

  // 上一页按钮
  Widget _previousPage(CompetitionsProvider provider) {
    int currentPage = provider.currentPage;
    // 如果当前页面为1，则说明没有上一页，禁用该按钮
    bool disabled = currentPage == 1;
    return Container(
      width: ScreenUtil().setWidth(48.0),
      height: ScreenUtil().setHeight(48.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: RaisedButton(
        color: Colors.white,
        onPressed: disabled ? null : () {
          provider.pageDecrement();
        },
        disabledTextColor: Colors.black38,
        child: Center(
          child: Text(
            '<',
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(16.0),
                fontWeight: FontWeight.w400
            ),
          ),
        ),
      ),
    );
  }

  // 下一页按钮
  Widget _nextPage(CompetitionsProvider provider) {
    int currentPage = provider.currentPage;
    int totalPage = provider.pages;
    // 如果已经为最后一页，则禁用该按钮
    bool disabled = currentPage == totalPage;
    return Container(
      width: ScreenUtil().setWidth(48.0),
      height: ScreenUtil().setHeight(48.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: RaisedButton(
        color: Colors.white,
        onPressed: disabled ? null : () {
          provider.pageIncrement();
        },
        disabledTextColor: Colors.black38,
        child: Center(
          child: Text(
            '>',
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(16.0),
                fontWeight: FontWeight.w400
            ),
          ),
        ),
      ),
    );
  }
}