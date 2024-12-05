import 'package:flutter/material.dart';
import 'package:flutter_1/prof/complainte.dart';
import 'package:flutter_1/prof/notifications.dart';
import 'package:flutter_1/prof/profil.dart';
import 'package:flutter_1/prof/reservations.dart';


void main() {
  runApp(const MyApp());
}
Color drawerHeaderColor = const Color(0xFF0D8F4E);
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      routes: {
        'notifications': (context) => const notificationsProf(),
        'acceuil': (context) => const acceuilProf(),
        'complaintes': (context) => const complaintesProf(),
        'reservations': (context) =>  const reservationsProf(),
        'profil': (context) => const profilProf(),
      },
      home: const acceuilProf(),
    );
  }
}

class acceuilProf extends StatelessWidget {
  const acceuilProf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(39.0), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.white,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'A C C E U I L',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
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
                  children:[
                    ListTile(
                      leading:
                      Image.asset("assets/proff.png"),
                      trailing:
                      Image.asset('assets/logoEMSI.png'),
                    ),
                    const SizedBox(height:20),
                    ListTile(
                        leading:
                        Image.asset('assets/prof/menu.png'),
                        title:Text('M        E         N        U', style: TextStyle(color: drawerHeaderColor, fontWeight: FontWeight.bold),),
                        onTap:(){
                          Navigator.pushNamed(context, 'acceuil');
                        }
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Image.asset('assets/prof/home.png'),
                title:Text("A C C E U I L",style: TextStyle(color: drawerHeaderColor, fontSize: 13),),
                onTap:() {
                  Navigator.pushNamed(context,'acceuil');
                },
              ),
              const SizedBox(height: 37),
              ListTile(
                leading: Image.asset('assets/prof/reservations.png'),
                title:Text("R E S E R V A T I O N S",style: TextStyle(color: drawerHeaderColor, fontSize: 13),),
                onTap:() {
                  Navigator.pushNamed(context,'reservations');
                },
              ),
              const SizedBox(height: 37),
              ListTile(
                leading: Image.asset('assets/prof/complaints.png'),
                title:Text("C O M P L A I N T E S",style: TextStyle(color: drawerHeaderColor, fontSize: 13),),
                onTap:() {
                  Navigator.pushNamed(context,'complaintes');
                },
              ),
              const SizedBox(height: 37),
              ListTile(
                leading: Image.asset('assets/prof/profile.png'),
                title:Text("P R O F I L",style: TextStyle(color: drawerHeaderColor, fontSize: 13)),
                onTap:(){
                  Navigator.pushNamed(context, 'profil');
                },
              ),
              const SizedBox(height: 37),
              ListTile(
                leading: Image.asset('assets/prof/notifications.png'),
                title:Text("N O T I F I C A T I O N S",style: TextStyle(color: drawerHeaderColor, fontSize: 13),),
                onTap:() {
                  Navigator.pushNamed(context,'notifications');
                },
              ),
              const SizedBox(height: 37),
              ListTile(
                leading: Image.asset('assets/prof/logout.png'),
                title:Text("D E C O N N E X I O N",style: TextStyle(color: drawerHeaderColor, fontSize: 13),),
                onTap:() {
                  Navigator.pushNamed(context,'');
                },
              ),
            ]
        ),
      ),


    );}}