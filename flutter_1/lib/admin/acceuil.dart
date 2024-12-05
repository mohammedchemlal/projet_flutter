import 'package:flutter/material.dart';
import 'package:flutter_1/admin/complaintes.dart';
import 'package:flutter_1/admin/comptes.dart';
import 'package:flutter_1/admin/cours.dart';
import 'package:flutter_1/admin/dashboard.dart';
import 'package:flutter_1/admin/infos_basiques_admin.dart';
import 'package:flutter_1/admin/infos_contact_admin.dart';
import 'package:flutter_1/admin/profilAdmin.dart';
import 'package:flutter_1/admin/reservations.dart';
import 'package:flutter_1/admin/salles.dart';

void main() {
  runApp(const MyApp());
}

Color drawerHeaderColor = const Color(0xFFC62B20);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      routes: {
        'profil': (context) => const profilAdmin(),
        'acceuil': (context) => const acceuilAdmin(),
        'salles': (context) => const sallesAdmin(),
        'comptes': (context) => const comptesAdmin(),
        'dashboard': (context) => const dashboardAdmin(),
        'reservations': (context) => const reservationsAdmin(),
        'cours': (context) => const coursAdmin(),
        'complaintes': (context) => const complaintesAdmin(),
        'infosbasiques':(context)=>const infosBasiquesAdmin(),
        'infoscontact':(context)=>const infosContactAdmin(),
      },
      home: const acceuilAdmin(),
    );
  }
}

class acceuilAdmin extends StatelessWidget {
  const acceuilAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(height: 10);
    return Scaffold(
    appBar: PreferredSize(
    preferredSize: const Size.fromHeight(39.0), 
    child: AppBar(
    backgroundColor: Colors.white,
    title: const Align(
    alignment: Alignment.centerLeft,
    child: Text(
    'A C C E U I L',
    style: TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.red,
    fontSize: 20,
    ),
    textAlign: TextAlign.center,
    ),
    ),
    titleSpacing: 100,
    ),
    ),
    drawer: Drawer(
    child: Column(
    children: [
    DrawerHeader(
    child: Column(
    children: [
    ListTile(
    leading: Image.asset('assets/piconline2.png'),
    trailing: Image.asset('assets/logoEMSI.png'),
    ),
    const SizedBox(height: 10),
    ListTile(
    leading: Image.asset('assets/admin/menu.png'),
    title: Text(
    'M        E         N        U',
    style: TextStyle(
    color: drawerHeaderColor,
    fontWeight: FontWeight.bold),
    ),
    onTap: () {
    Navigator.pushNamed(context, 'acceuil');
    }),
    ],
    ),
    ),
    ListTile(
    leading: Image.asset('assets/admin/home.png'),
    title: Text(
    "A C C E U I L",
    style: TextStyle(color: drawerHeaderColor, fontSize: 11),
    ),
    onTap: () {
    Navigator.pushNamed(context, 'acceuil');
    },
    ),
    const SizedBox(height: 20),
    ListTile(
    leading: Image.asset('assets/admin/class.png'),
    title: Text(
    "S A L L E S",
    style: TextStyle(color: drawerHeaderColor, fontSize: 11),
    ),
    onTap: () {
    Navigator.pushNamed(context, 'salles');
    },
    ),
    const SizedBox(height: 20),
    ListTile(
    leading: Image.asset('assets/admin/reservations.png'),
    title: Text(
    "R E S E R V A T I O N S",
    style: TextStyle(color: drawerHeaderColor, fontSize: 11),
    ),
    onTap: () {
    Navigator.pushNamed(context, 'reservations');
    },
    ),
    const SizedBox(height: 20),
    ListTile(
    leading: Image.asset('assets/admin/cours.png'),
    title: Text(
    "C O U R S",
    style: TextStyle(color: drawerHeaderColor, fontSize: 11),
    ),
    onTap: () {
    Navigator.pushNamed(context, 'cours');
    },
    ),
    const SizedBox(height: 20),
    ListTile(
    leading: Image.asset('assets/admin/profile.png'),
    title: Text("P R O F I L",
    style: TextStyle(color: drawerHeaderColor, fontSize: 11)),
    onTap: () {
    Navigator.pushNamed(context, 'profil');
    },
    ),
    const SizedBox(height: 20),
    ListTile(
    leading: Image.asset('assets/admin/comptes.png'),
    title: Text(
    "C O M P T E S",
    style: TextStyle(color: drawerHeaderColor, fontSize: 11),
    ),
    onTap: () {
    Navigator.pushNamed(context, 'comptes');
    },
    ),
    const SizedBox(height: 20),
    ListTile(
    leading: Image.asset('assets/admin/dashboard.png'),
    title: Text(
    "D A S H B O A R D ",
    style: TextStyle(color: drawerHeaderColor, fontSize: 11),
    ),
    onTap: () {
    Navigator.pushNamed(context, 'dashboard');
    }),
    const SizedBox(height: 20),
    ListTile(
    leading: Image.asset('assets/admin/logout.png'),
    title: Text(
    "D E C O N N E X I O N",
    style: TextStyle(color: drawerHeaderColor, fontSize: 11),
    ),
    onTap: () {
    Navigator.pushNamed(context, '');
    },
    ),
    ]
    ),),
      body: const Column(children: []),
    );
  }
}
