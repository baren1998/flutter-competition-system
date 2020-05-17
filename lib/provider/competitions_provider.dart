import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/competition_model.dart';
import '../config/service_url.dart';
import '../service/service_method.dart';
import 'dart:convert';

class CompetitionsProvider with ChangeNotifier {

  int _pages = 1;  // 当前分类的总分页数
  int _currentPage = 1; // 当前选择的页面数
  List<Competition> _competitionList = [];
  // 0-全部 1-算法赛 2-创新应用赛 3-学习赛，默认为0-全部
  int _cmptType = 0;

  List<Competition> get competitionList => _competitionList;
  int get pages => _pages;
  int get currentPage => _currentPage;
  int get cmptType => _cmptType;

  void updateCompetitions(List<Competition> list) {
    _competitionList = list;
    notifyListeners();
  }

  // 改变TabBar中的比赛类型
  void changeCmptType(int type) {
    _currentPage = 1;
    _pages = 1;
    _cmptType = type;
    _competitionList.clear();
    notifyListeners();

    // 重新进行网络请求
    getRequest(_currentPage - 1);
  }

  // 跳转到某一页
  void changeCurrentPage(int page) {
    _currentPage = page;
    _competitionList.clear();
    notifyListeners();

    // 重新进行网络请求
    getRequest(_currentPage - 1);
  }

  // 减少一页
  void pageDecrement() {
    _currentPage--;
    _competitionList.clear();
    notifyListeners();

    // 重新进行网络请求
    getRequest(_currentPage - 1);
  }

  // 增加一页
  void pageIncrement() {
    _currentPage++;
    _competitionList.clear();
    notifyListeners();

    // 重新进行网络请求
    getRequest(_currentPage - 1);
  }

  // 网络请求
  void getRequest(int pageNum) {
    // 对比赛分类进行判断，决定使用哪个API请求数据
    if(_cmptType == 0) {
      requestAllCompetitions(pageNum);
    } else{
      requestCompetitionsByType(pageNum, _cmptType);
    }
  }

  // 通过API请求全部竞赛信息
  void requestAllCompetitions(int pageNum) {
    var queryParams = {'pageNum': pageNum};
    request(servicePath['findAllCompetitionsByPage'], queryParams: queryParams).then((value) {
      List<Map> contentList = (value['content'] as List).cast();
      _pages = value['totalPages'];
      _competitionList = contentList.map((item) => Competition.fromJson(item)).toList();
      notifyListeners();
    });
  }

  // 通过API请求分类竞赛信息
  void requestCompetitionsByType(int pageNum, int type) {
    var queryParams = {'pageNum': pageNum, 'type': type};
    request(servicePath['findCompetitionsByTypeAndPage'], queryParams: queryParams).then((value) {
      List<Map> contentList = (value['content'] as List).cast();
      _pages = value['totalPages'];
      _competitionList = contentList.map((item) => Competition.fromJson(item)).toList();
      notifyListeners();
    });
  }
}