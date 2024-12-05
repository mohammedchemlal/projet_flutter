import 'package:flutter_1/models/salles.dart';
import 'package:flutter_1/models/users.dart';

class reservations{
  int idRes;
  String dateRes;
  salles salleRes;
  users profRes;

  reservations(
      this.idRes,
      this.dateRes,
      this.salleRes,
      this.profRes,
      );

  Map<String, dynamic> toJson() =>
      {
        'idS':idRes.toString(),
        'name': dateRes,
        'username': salleRes,
        'password':profRes,
      };
}