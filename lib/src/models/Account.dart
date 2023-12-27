import 'package:new_one/main.dart';

class Account implements JsonSerializable {
  int? id;
  String? userName;
  String? email;
  String? emailConfirmed;
  List<String>? roles;

  Account(
      {this.id, this.userName, this.email, this.emailConfirmed, this.roles});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    emailConfirmed = json['emailConfirmed'];
    roles = json['roles'].cast<String>();
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['userName'] = userName;
    data['email'] = email;
    data['emailConfirmed'] = emailConfirmed;
    data['roles'] = roles;
    return data;
  }
}
