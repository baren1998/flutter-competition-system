import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import '../../../provider/competitions_provider.dart';
import '../../../model/competition_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CompetitionListView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<CompetitionsProvider>(
      builder: (context, provider, child) {
        List competitions = provider.competitionList;
        // 如果数据为空，则显示加载指示器
        if(competitions == null || competitions.length == 0) {
          return Container(
            margin: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
            height: ScreenUtil().setHeight(600),
            width: ScreenUtil().setWidth(1640),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        // 不为空，则显示数据
        else {
          return ListView.builder(
            shrinkWrap: true,
            // 设置不允许滚动
            physics: NeverScrollableScrollPhysics(),
            itemCount: competitions.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  _competitionItem(competitions[index]),
                  SizedBox(height: ScreenUtil().setHeight(40.0))
                ],
              );
            },
          );
        }
      },
    );
  }

  // 竞赛信息单项视图
  Widget _competitionItem(Competition competition) {
    return Material(
      child: InkWell(
        onTap: () async {
          // 点击跳转到竞赛详情页面
          String url = competition.detailPageUrl;
          if(await canLaunch(url)) {
            await launch((url));
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Container(
          height: ScreenUtil().setHeight(252),
          width: ScreenUtil().setWidth(1640),
          child: Row(
            children: <Widget>[
              _competitionCover(competition.iconUrl),
              _competitionInfoCombine(competition),
              _onGoingTag()
            ],
          ),
        ),
      ),
    );
  }

  // 中间部分信息组合视图
  Widget _competitionInfoCombine(Competition competition) {
    return Container(
      height: ScreenUtil().setHeight(252),
      width: ScreenUtil().setWidth(1328),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(24.0), top: ScreenUtil().setHeight(20.0)),
      child: Column(
        children: <Widget>[
          // 标题和标签组件
          Row(
            children: <Widget>[
              _competitionTitle(competition.raceName),
              SizedBox(width: ScreenUtil().setWidth(16.0)),
              _competitionTag(competition.tag),
            ],
          ),
          SizedBox(height: ScreenUtil().setHeight(8.0)),
          Row(
            children: <Widget>[
              // 赛事简要和举办方组件
              Column(
                children: <Widget>[
                  _competitionBrief(competition.brief),
                  SizedBox(height: ScreenUtil().setHeight(8.0)),
                  _competitionSponsor(competition),
                ],
              ),
              // 赛事奖励、团队、举办时间
              SizedBox(width: ScreenUtil().setWidth(58.0)),
              _competitionReward(competition.reward),
              SizedBox(width: ScreenUtil().setWidth(16.0)),
              _competitionTeam(competition.teamNum),
              SizedBox(width: ScreenUtil().setWidth(16.0)),
              _competitionSchedule(competition),
            ],
          )
        ],
      ),
    );
  }

  // 竞赛图片
  Widget _competitionCover(String coverImageUrl) {
    return Container(
      height: ScreenUtil().setHeight(252),
      width: ScreenUtil().setWidth(252),
      child: Image.network(coverImageUrl, fit: BoxFit.fill),
    );
  }

  // 竞赛标题
  Widget _competitionTitle(String title) {
    return Container(
      height: ScreenUtil().setHeight(51),
      width: ScreenUtil().setWidth(1000),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(8.0), ScreenUtil().setHeight(8.0),
          ScreenUtil().setWidth(8.0), ScreenUtil().setHeight(12.0)),
      child: Text(
        title,
        textAlign: TextAlign.start,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
          fontSize: ScreenUtil().setSp(24.0),
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  // 赛事简要
  Widget _competitionBrief(String brief) {
    return Container(
        height: ScreenUtil().setHeight(96),
        width: ScreenUtil().setWidth(600),
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(8.0)),
        child: Text(
          '赛事简要：${brief}',
          textAlign: TextAlign.start,
          maxLines: 4,
          overflow: TextOverflow.clip,
          style: TextStyle(
              height: 1.5,
              color: Colors.black38,
              fontSize: ScreenUtil().setSp(14.0),
          ),
        ),
    );
  }

  // 举办方
  Widget _competitionSponsor(Competition competition) {
    return Container(
      height: ScreenUtil().setHeight(52),
      width: ScreenUtil().setWidth(580),
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        children: <Widget>[
          SizedBox(width: ScreenUtil().setWidth(8.0)),
          Text(
            '举办方: ',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black38,
              fontSize: ScreenUtil().setSp(16.0),
              decoration: TextDecoration.none
            ),
          ),
          SizedBox(width: ScreenUtil().setWidth(8.0)),
          _competitionSponsorDetail(competition),
        ],
      ),
    );
  }
  // 举办方详情
  Widget _competitionSponsorDetail(Competition competition) {
    // 判断举办方类型，1-图片 2-文字
    if(competition.sponsorType == 1) {
      return Image.network(competition.sponsor);
    }
    else {
      return Container(
        width: ScreenUtil().setWidth(400),
        child: Text(
          competition.sponsor,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: Colors.black38,
              fontSize: ScreenUtil().setSp(16.0)
          ),
        ),
      );
    }
  }

  // 比赛奖励
  Widget _competitionReward(String reward) {
    return Container(
      height: ScreenUtil().setHeight(144),
      width: ScreenUtil().setWidth(144),
      padding: EdgeInsets.only(top: 12.0),
      child: Column(
        children: <Widget>[
          Text(
            '奖励',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black38,
              fontSize: ScreenUtil().setSp(16.0),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(24.0)),
          Text(
            reward,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(24.0),
            ),
          )
        ],
      ),
    );
  }

  // 参赛团队
  Widget _competitionTeam(int team) {
    return Container(
      height: ScreenUtil().setHeight(144),
      width: ScreenUtil().setWidth(120),
      padding: EdgeInsets.only(top: 12.0),
      child: Column(
        children: <Widget>[
          Text(
            '队伍',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(16.0),
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(24.0)),
          Text(
            team.toString(),
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(24.0),
            ),
          )
        ],
      ),
    );
  }

  // 比赛举办时间
  Widget _competitionSchedule(Competition competition) {
    String startTimestamp = competition.startTime;
    String startTime = startTimestamp.substring(0, startTimestamp.indexOf('T'));
    String endTimestamp = competition.endTime;
    String endTime = endTimestamp.substring(0, endTimestamp.indexOf('T'));
    return Container(
      height: ScreenUtil().setHeight(144),
      width: ScreenUtil().setWidth(334),
      padding: EdgeInsets.only(top: 12.0),
      child: Column(
        children: <Widget>[
          Text(
            '举办时间',
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black38,
                fontSize: ScreenUtil().setSp(16.0),
                decoration: TextDecoration.none
            ),
          ),
          SizedBox(height: ScreenUtil().setHeight(24.0)),
          Text(
            '${startTime}~${endTime}',
            maxLines: 2,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(24.0),
                decoration: TextDecoration.none
            ),
          )
        ],
      ),
    );
  }

  // 比赛标签
  Widget _competitionTag(String tag) {
    return Container(
      height: ScreenUtil().setHeight(32),
      width: ScreenUtil().setWidth(104),
      padding: EdgeInsets.only(left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(135,208,104, 1.0),
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Center(
        child: Text(
          tag,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: ScreenUtil().setSp(16.0),
            fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }

  // 进行中标签
  Widget _onGoingTag() {
    return Container(
      height: ScreenUtil().setHeight(252),
      width: ScreenUtil().setWidth(60),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 247, 230, 1.0),
      ),
      child: Center(
        child: Container(
          width: ScreenUtil().setWidth(30),
          child: Text(
            '进行中',
            maxLines: 3,
            style: TextStyle(
              height: 1.5,
              color: Color.fromRGBO(250, 140, 22, 1.0),
              fontSize: ScreenUtil().setSp(24.0),
            ),
          ),
        )
      ),
    );
  }
}