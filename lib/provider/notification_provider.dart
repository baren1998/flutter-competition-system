import 'package:flutter/material.dart';
import '../config/service_url.dart';
import '../service/service_method.dart';
import '../model/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  List _notifications = [];

  List get notifications => _notifications;

  void pullNotifications() {
    request(servicePath['pullNotification']).then((value) {
      _notifications = (value as List).map((e) => MyNotification.fromJson(e)).toList();
      notifyListeners();
    });
  }
}