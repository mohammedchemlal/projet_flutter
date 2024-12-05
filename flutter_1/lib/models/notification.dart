import 'package:flutter_1/models/users.dart';

class notifs{
  int idN;
  String notif;
  users user;

  notifs(
      this.idN,
      this.notif,
      this.user,
      );

  Map<String, dynamic> toJson() =>
      {
        'idS':idN.toString(),
        'name': notif,
        'user':user,
      };
}