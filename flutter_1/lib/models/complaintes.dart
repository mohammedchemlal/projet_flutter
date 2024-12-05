import 'package:flutter_1/models/users.dart';

class complaintes{
  int idC;
  String text;
  users user;

  complaintes(
      this.idC,
      this.text,
      this.user,
      );

  Map<String, dynamic> toJson() =>
      {
        'idS':idC.toString(),
        'name': text,
        'user':user,
      };
}