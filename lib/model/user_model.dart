class User {
  int _id;
  String _name;
  String _email;
  String _registerTime;

  User({int id, String name, String email, String registerTime}) {
    this._id = id;
    this._name = name;
    this._email = email;
    this._registerTime = registerTime;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get name => _name;
  set name(String name) => _name = name;
  String get email => _email;
  set email(String email) => _email = email;
  String get registerTime => _registerTime;
  set registerTime(String registerTime) => _registerTime = registerTime;

  User.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _registerTime = json['registerTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['email'] = this._email;
    data['registerTime'] = this._registerTime;
    return data;
  }
}
