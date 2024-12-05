import 'dart:convert';

import 'package:http/http.dart' as http;

class users {
  int idU;
  String name;
  String username;
  String password;
  String email;
  String phoneNumber;
  String userType;

  users(this.idU,
      this.name,
      this.username,
      this.password,
      this.phoneNumber,
      this.email,
      this.userType
      );

  Map<String, dynamic> toJson() =>
      {
        'idU': idU.toString(),
        'name': name,
        'username': username,
        'password': password,
        'email': email,
        'phoneNumber': phoneNumber,
        'userType': userType,
      };


}