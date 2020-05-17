class Competition {
  int _id;
  String _raceName;
  int _sponsorType;
  String _sponsor;
  String _brief;
  String _task;
  String _schedule;
  int _teamNum;
  String _reward;
  String _rule;
  int _type;
  String _tag;
  int _dataSourceType;
  String _startTime;
  String _endTime;
  String _updateTime;
  String _iconUrl;
  String _detailPageUrl;

  Competition(
      {int id,
        String raceName,
        int sponsorType,
        String sponsor,
        String brief,
        String task,
        String schedule,
        int teamNum,
        String reward,
        String rule,
        int type,
        String tag,
        int dataSourceType,
        String startTime,
        String endTime,
        String updateTime,
        String iconUrl,
        String detailPageUrl}) {
    this._id = id;
    this._raceName = raceName;
    this._sponsorType = sponsorType;
    this._sponsor = sponsor;
    this._brief = brief;
    this._task = task;
    this._schedule = schedule;
    this._teamNum = teamNum;
    this._reward = reward;
    this._rule = rule;
    this._type = type;
    this._tag = tag;
    this._dataSourceType = dataSourceType;
    this._startTime = startTime;
    this._endTime = endTime;
    this._updateTime = updateTime;
    this._iconUrl = iconUrl;
    this._detailPageUrl = detailPageUrl;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get raceName => _raceName;
  set raceName(String raceName) => _raceName = raceName;
  int get sponsorType => _sponsorType;
  set sponsorType(int sponsorType) => _sponsorType = sponsorType;
  String get sponsor => _sponsor;
  set sponsor(String sponsor) => _sponsor = sponsor;
  String get brief => _brief;
  set brief(String brief) => _brief = brief;
  String get task => _task;
  set task(String task) => _task = task;
  String get schedule => _schedule;
  set schedule(String schedule) => _schedule = schedule;
  int get teamNum => _teamNum;
  set teamNum(int teamNum) => _teamNum = teamNum;
  String get reward => _reward;
  set reward(String reward) => _reward = reward;
  String get rule => _rule;
  set rule(String rule) => _rule = rule;
  int get type => _type;
  set type(int type) => _type = type;
  String get tag => _tag;
  set tag(String tag) => _tag = tag;
  int get dataSourceType => _dataSourceType;
  set dataSourceType(int dataSourceType) => _dataSourceType = dataSourceType;
  String get startTime => _startTime;
  set startTime(String startTime) => _startTime = startTime;
  String get endTime => _endTime;
  set endTime(String endTime) => _endTime = endTime;
  String get updateTime => _updateTime;
  set updateTime(String updateTime) => _updateTime = updateTime;
  String get iconUrl => _iconUrl;
  set iconUrl(String iconUrl) => _iconUrl = iconUrl;
  String get detailPageUrl => _detailPageUrl;
  set detailPageUrl(String detailPageUrl) => _detailPageUrl = detailPageUrl;

  Competition.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _raceName = json['raceName'];
    _sponsorType = json['sponsorType'];
    _sponsor = json['sponsor'];
    _brief = json['brief'];
    _task = json['task'];
    _schedule = json['schedule'];
    _teamNum = json['teamNum'];
    _reward = json['reward'];
    _rule = json['rule'];
    _type = json['type'];
    _tag = json['tag'];
    _dataSourceType = json['dataSourceType'];
    _startTime = json['startTime'];
    _endTime = json['endTime'];
    _updateTime = json['updateTime'];
    _iconUrl = json['iconUrl'];
    _detailPageUrl = json['detailPageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['raceName'] = this._raceName;
    data['sponsorType'] = this._sponsorType;
    data['sponsor'] = this._sponsor;
    data['brief'] = this._brief;
    data['task'] = this._task;
    data['schedule'] = this._schedule;
    data['teamNum'] = this._teamNum;
    data['reward'] = this._reward;
    data['rule'] = this._rule;
    data['type'] = this._type;
    data['tag'] = this._tag;
    data['dataSourceType'] = this._dataSourceType;
    data['startTime'] = this._startTime;
    data['endTime'] = this._endTime;
    data['updateTime'] = this._updateTime;
    data['iconUrl'] = this._iconUrl;
    data['detailPageUrl'] = this._detailPageUrl;
    return data;
  }
}
