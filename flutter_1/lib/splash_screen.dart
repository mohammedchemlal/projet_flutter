import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_1/admin/comptes.dart';
import 'package:flutter_1/prof/acceuil.dart';
import 'package:flutter_1/prof/complainte.dart';
import 'package:flutter_1/prof/infos_basiques_prof.dart';
import 'package:flutter_1/prof/infos_contact_prof.dart';
import 'package:flutter_1/prof/notifications.dart';
import 'package:flutter_1/prof/profil.dart';
import 'package:flutter_1/prof/reservations.dart';
import 'package:flutter_1/secu/complaintes.dart';
import 'package:flutter_1/secu/infos_basiques.dart';
import 'package:flutter_1/secu/infos_contact.dart';
import 'package:flutter_1/secu/notifications.dart';
import 'package:flutter_1/secu/profil.dart';
import 'package:flutter_1/secu/reservations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_1/globals.dart' as globals;
import 'package:flutter_1/admin/complaintes.dart';
import 'package:flutter_1/admin/cours.dart';
import 'package:flutter_1/admin/dashboard.dart';
import 'package:flutter_1/admin/infos_basiques_admin.dart';
import 'package:flutter_1/admin/infos_contact_admin.dart';
import 'package:flutter_1/admin/profilAdmin.dart';
import 'package:flutter_1/admin/reservations.dart';
import 'package:flutter_1/admin/salles.dart';
import 'ConnexionPage.dart';

void main() {
  runApp(const MyApp());
}

Color drawerHeaderColor = const Color(0xFFC62B20);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentification',
      routes: {
        'notifications': (context) => const notificationsProf(),
        'complaintes': (context) => const complaintesProf(),
        'reservations': (context) =>  const reservationsProf(),
        'profil': (context) => const profilProf(),
        'infosbasiques':(context)=>const infosBasiquesProf(),
        'infoscontact':(context)=>const infosContactProf(),
        'profilA': (context) => const profilAdmin(),
        'sallesA': (context) => const sallesAdmin(),
        'comptes': (context) => const comptesAdmin(),
        'dashboard': (context) => const dashboardAdmin(),
        'reservationsA': (context) => const reservationsAdmin(),
        'complaintesA': (context) => const complaintesAdmin(),
        'cours': (context) => const coursAdmin(),
        'infosbasiquesA':(context)=>const infosBasiquesAdmin(),
        'infoscontactA':(context)=>const infosContactAdmin(),
        'profilS': (context) => const profil(),
        'reservationsS': (context) => const reservations(),
        'complaintesS': (context) => const complaintes(),
        'notificationsS': (context) => const notifications(),
        'infosbasiquesS':(context)=>const infosBasiques(),
        'infoscontactS':(context)=>const infosContact(),
        'login':(context)=>const ConnexionPage(),
      },
      home: const _SplashScreenState(),
    );
  }
}

class _SplashScreenState extends StatefulWidget {
  const _SplashScreenState({Key? key}) : super(key: key);

  @override
  __SplashScreenStateState createState() => __SplashScreenStateState();
}

class __SplashScreenStateState extends State<_SplashScreenState> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
          () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => ConnexionPage(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.redAccent,
            Colors.greenAccent,
            Colors.blueAccent,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logoEMSI.png",
                width: 350,
              ),
              Text('myEMSISalles'),
              const SizedBox(height: 40),
              Lottie.network(
                "https://lottie.host/76bbb7c4-07e5-4c52-89a6-c9523fc5b5e5/A78TDs9WH9.json",
                height: 50,
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.transparent,
          child: Text("©Ecole Maroccaine de Science de Ingenieur-2024", textAlign: TextAlign.center,
          ),
        ),
        ),
      );
  }
}
