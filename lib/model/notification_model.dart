class MyNotification {
  String _cmptName;
  String _brief;
  String _coverImageUrl;
  String _detailPageUrl;
  String _notifyTime;

  MyNotification(
      {String cmptName,
        String brief,
        String coverImageUrl,
        String detailPageUrl,
        String notifyTime}) {
    this._cmptName = cmptName;
    this._brief = brief;
    this._coverImageUrl = coverImageUrl;
    this._detailPageUrl = detailPageUrl;
    this._notifyTime = notifyTime;
  }

  String get cmptName => _cmptName;
  set cmptName(String cmptName) => _cmptName = cmptName;
  String get brief => _brief;
  set brief(String brief) => _brief = brief;
  String get coverImageUrl => _coverImageUrl;
  set coverImageUrl(String coverImageUrl) => _coverImageUrl = coverImageUrl;
  String get detailPageUrl => _detailPageUrl;
  set detailPageUrl(String detailPageUrl) => _detailPageUrl = detailPageUrl;
  String get notifyTime => _notifyTime;
  set notifyTime(String notifyTime) => _notifyTime = notifyTime;

  MyNotification.fromJson(Map<String, dynamic> json) {
    _cmptName = json['cmptName'];
    _brief = json['brief'];
    _coverImageUrl = json['coverImageUrl'];
    _detailPageUrl = json['detailPageUrl'];
    _notifyTime = json['notifyTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cmptName'] = this._cmptName;
    data['brief'] = this._brief;
    data['coverImageUrl'] = this._coverImageUrl;
    data['detailPageUrl'] = this._detailPageUrl;
    data['notifyTime'] = this._notifyTime;
    return data;
  }
}
