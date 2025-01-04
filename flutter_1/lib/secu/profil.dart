import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_1/ConnexionPage.dart';
import 'package:flutter_1/secu/complaintes.dart';
import 'package:flutter_1/secu/notifications.dart';
import 'package:flutter_1/secu/reservations.dart';
import 'infos_basiques.dart';
import 'infos_contact.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_1/globals.dart' as globals;

void main() {
  runApp( const MyApp());
}
Color drawerHeaderColor =  const Color(0xFF2755CE);
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      theme: ThemeData.light(),  // Default light theme
      darkTheme: ThemeData.dark(), // Dark theme
      themeMode: ThemeMode.light,

      routes: {
        'profilS': (context) => const profil(),
        'reservationsS': (context) => const reservations(),
        'complaintesS': (context) => const complaintes(),
        'notificationsS': (context) => const notifications(),
        'infosbasiquesS':(context)=>const infosBasiques(),
        'infoscontactS':(context)=>const infosContact(),
        'login':(context)=>const ConnexionPage(),
      },
      home: const profil(),
    );
  }

}

String name="";
String username=globals.globalDataS;
String password="";
String email="";
String phoneNumber="";
Color textColor = Colors.black;
class profil extends StatefulWidget {
  const profil({Key? key}) : super(key: key);

  @override
  _profil createState() =>_profil();
}
class _profil extends State<profil>{
  String? password;

  @override
  void initState() {
    super.initState();
    fetchName();
    fetchPassword();
    fetchEmail();
    fetchNumber();
  }

  Future<void> fetchName() async {
    final String url = 'http://10.0.2.2/api_flutter_1/retrieve/retrievename.php';
    try {
      var response = await http.post(Uri.parse(url), body: {
        'username': username,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data.containsKey('name')) {
          setState(() {
            name = data['name']; 
          });
        } else {
          setState(() {
            name = 'Name not found'; 
          });
        }
      } else {
        setState(() {
          name = 'Failed to fetch data'; 
        });
      }
    } catch (e) {
      setState(() {
        name = 'Error: $e'; 
      });
    }
  }
  Future<void> fetchPassword() async {
    final String url = 'http://10.0.2.2/api_flutter_1/retrieve/retrievepassword.php';
    try {
      var response = await http.post(Uri.parse(url), body: {
        'username': username,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data.containsKey('password')) {
          setState(() {
            password = data['password']; 
          });
        } else {
          setState(() {
            password = 'Password not found'; 
          });
        }
      } else {
        setState(() {
          password = 'Failed to fetch data'; 
        });
      }
    } catch (e) {
      setState(() {
        password = 'Error: $e';
      });
    }
  }
  Future<void> fetchNumber() async {
    final String url = 'http://10.0.2.2/api_flutter_1/retrieve/retrievephone.php';
    try {
      var response = await http.post(Uri.parse(url), body: {
        'username': username,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data.containsKey('phoneNumber')) {
          setState(() {
            phoneNumber = data['phoneNumber']; 
          });
        } else {
          setState(() {
            phoneNumber = 'phoneNumber not found'; 
          });
        }
      } else {
        setState(() {
          phoneNumber = 'Failed to fetch data'; 
        });
      }
    } catch (e) {
      setState(() {
        phoneNumber = 'Error: $e'; 
      });
    }
  }
  Future<void> fetchEmail() async {
    final String url = 'http://10.0.2.2/api_flutter_1/retrieve/retrieveemail.php';
    try {
      var response = await http.post(Uri.parse(url), body: {
        'username': username,
      });

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data.containsKey('email')) {
          setState(() {
            email = data['email']; 
          });
        } else {
          setState(() {
            email = 'Password not found'; 
          });
        }
      } else {
        setState(() {
          email = 'Failed to fetch data'; 
        });
      }
    } catch (e) {
      setState(() {
        email = 'Error: $e'; 
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(39.0), 
        child: AppBar(
          backgroundColor: Colors.white,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'P R O F I L',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      title: Stack(
                        children: [
                          Image.asset(
                            "assets/3azi.png",
                            width: 60,
                            height: 60, 
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 10,
                            left: 60,
                            right: 20,
                            child: Container(
                              color: Colors.white.withOpacity(0),
                              padding: EdgeInsets.symmetric(vertical: 1.0),
                              child: Text(
                                username,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),),

                        ],
                      ),
                      trailing: Image.asset('assets/logoEMSI.png'),
                      onTap: () {
                      
                      },
                    ),
                    const SizedBox(height:20),
                    ListTile(
                        leading:
                        Image.asset('assets/secu/menu.png'),
                        title:Text('M        E         N        U', style: TextStyle(color: drawerHeaderColor, fontWeight: FontWeight.bold),),
                        onTap:(){
                          Navigator.pushNamed(context, 'profilS');
                        }
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                leading: Image.asset('assets/secu/reservations.png'),
                title:Text("R E S E R V A T I O N S",style: TextStyle(color: drawerHeaderColor, fontSize: 13),),
                onTap:() {
                  Navigator.pushNamed(context,'reservationsS');
                },
              ),
              const SizedBox(height: 25),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],  // Adjust the color to your preference
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              const SizedBox(height: 25),
              ListTile(
                leading: Image.asset('assets/secu/complaints.png'),
                title:Text("C O M P L A I N T E S",style: TextStyle(color: drawerHeaderColor, fontSize: 13),),
                onTap:() {
                  Navigator.pushNamed(context,'complaintesS');
                },
              ),
              const SizedBox(height: 25),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],  // Adjust the color to your preference
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              const SizedBox(height: 25),
              ListTile(
                leading: Image.asset('assets/secu/profile.png'),
                title:Text("P R O F I L",style: TextStyle(color: drawerHeaderColor, fontSize: 13)),
                onTap:(){
                  Navigator.pushNamed(context, 'profilS');
                },
              ),
              const SizedBox(height: 25),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],  // Adjust the color to your preference
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              const SizedBox(height: 25),
              ListTile(
                leading: Image.asset('assets/secu/notifications.png'),
                title:Text("N O T I F I C A T I O N S",style: TextStyle(color: drawerHeaderColor, fontSize: 13),),
                onTap:() {
                  Navigator.pushNamed(context,'notificationsS');
                },
              ),
              const SizedBox(height: 25),
              Container(
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],  // Adjust the color to your preference
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              const SizedBox(height: 25),
              ListTile(
                leading: Image.asset('assets/secu/logout.png'),
                title: Text(
                  "D E C O N N E X I O N",
                  style: TextStyle(color: drawerHeaderColor, fontSize: 13),
                ),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context)
                      {
                        return AlertDialog(
                          title: Text('Message de confirmation',
                            style: TextStyle(color: drawerHeaderColor),),
                          content: Text(
                              'Voulez-vous vraiment vous déconnecter?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Non',
                                style: TextStyle(color: drawerHeaderColor),),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'login');
                              },
                              child: Text(
                                'Oui',
                                style: TextStyle(color: drawerHeaderColor),),
                            ),
                          ],
                        );
                      });
                },
              ),
            ]
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 0,left:10,right: 60, bottom: 0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/3azi.png",width: 120,
                            height: 120,),
                      const SizedBox(width: 3), 
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 35,),
              ListTile(
                title:const Text("Informations basiques:",style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                trailing:Image.asset("assets/secu/edit.png", alignment: Alignment.bottomRight,),
                onTap:() {
                  Navigator.pushNamed(context,'infosbasiquesS');
                },
              ),
              const Divider(
                color: Colors.black87, // Couleur du trait
                thickness: 0, // Épaisseur du trait
                indent: 40, // Marge à gauche
                endIndent: 20, // Marge à droit
                height: 0,
              ),
              ListTile(
                leading: Image.asset("assets/secu/name.png", alignment: Alignment.bottomRight,),
                title:Text('$name',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                subtitle: const Text("Nom complet", style: TextStyle(color: Colors.black87, fontSize: 11)),
              ),
              const Divider(
                color: Colors.black87, // Couleur du trait
                thickness: 0, // Épaisseur du trait
                indent: 40, // Marge à gauche
                endIndent: 20, // Marge à droit
                height: 0,
              ),
              ListTile(
                leading: Image.asset("assets/secu/username.png", alignment: Alignment.bottomRight,),
                title:Text(username,style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                subtitle: const Text("Nom d'utilisateur", style: TextStyle(color: Colors.black87, fontSize: 11)),
              ),
              const Divider(
                color: Colors.black87, // Couleur du trait
                thickness: 0, // Épaisseur du trait
                indent: 40, // Marge à gauche
                endIndent: 20, // Marge à droit
                height: 0,
              ),
              ListTile(
                leading: Image.asset("assets/secu/padlock.png", alignment: Alignment.bottomRight,),
                title: Text('$password',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                subtitle: const Text("Mot de passe", style: TextStyle(color: Colors.black87, fontSize: 11)),
              ),
              const Divider(
                color: Colors.black87, // Couleur du trait
                thickness: 0, // Épaisseur du trait
                indent: 40, // Marge à gauche
                endIndent: 20, // Marge à droit
                height: 0,
              ),
              const SizedBox(height: 20,),
              ListTile(
                title:Text("Informations de contact:",style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                trailing:Image.asset("assets/secu/edit.png", alignment: Alignment.bottomRight,),
                onTap:() {
                  Navigator.pushNamed(context,'infoscontactS');
                },
              ),
              const Divider(
                color: Colors.black87, // Couleur du trait
                thickness: 0, // Épaisseur du trait
                indent: 40, // Marge à gauche
                endIndent: 20, // Marge à droit
                height: 0,
              ),
              ListTile(
                leading: Image.asset("assets/secu/phone.png", alignment: Alignment.bottomRight,),
                title: Text('$phoneNumber',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                subtitle: const Text("Numéro de téléphone", style: TextStyle(color: Colors.black87, fontSize: 11)),
              ),
              const Divider(
                color: Colors.black87, // Couleur du trait
                thickness: 0, // Épaisseur du trait
                indent: 40, // Marge à gauche
                endIndent: 20, // Marge à droit
                height: 0,
              ),
              ListTile(
                leading: Image.asset("assets/secu/mail.png", alignment: Alignment.bottomRight,),
                title:Text('$email',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                subtitle: const Text("Adresse e-mail", style: TextStyle(color: Colors.black87, fontSize: 11)),
              ),

            ],
          ),
        ),),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // Set your desired height here
        child: SizedBox(
          height: 50.0, // Adjust this to match preferredSize height
          child: BottomAppBar(
            color: Colors.transparent,
            child: Center(
              child: Text(
               '©Ecole Maroccaine de Science de Ingenieur-2024',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0, // Adjust font size if needed// Change text color if needed
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
