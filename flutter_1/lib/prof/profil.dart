import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_1/ConnexionPage.dart';
import 'package:flutter_1/prof/acceuil.dart';
import 'package:flutter_1/prof/complainte.dart';
import 'package:flutter_1/prof/infos_basiques_prof.dart';
import 'package:flutter_1/prof/infos_contact_prof.dart';
import 'package:flutter_1/prof/notifications.dart';
import 'package:flutter_1/prof/reservations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_1/globals.dart' as globals;

void main() {
  runApp( const MyApp());
}

Color drawerHeaderColor =  const Color(0xFF0D8F4E);
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
        'profil': (context) => const profilProf(),
        'acceuil': (context) => const acceuilProf(),
        'reservations': (context) => const reservationsProf(),
        'complaintes': (context) => const complaintesProf(),
        'notifications': (context) => const notificationsProf(),
        'infosbasiques':(context)=>const infosBasiquesProf(),
        'infoscontact':(context)=>const infosContactProf(),
        'login':(context)=>const ConnexionPage(),
      },
      home: const profilProf(),
    );
  }
}
String name="";
String username = globals.globalDataP;
String password="";
String email="";
String phoneNumber="";
class profilProf extends StatefulWidget {
  const profilProf({Key? key}) : super(key: key);

  @override
  _profilProfState createState() => _profilProfState();
}

class _profilProfState extends State<profilProf> {
  @override
  void initState() {
    super.initState();
    fetchName();
    fetchPassword();
    fetchEmail();
    fetchNumber();// Call fetchData() when the widget initializes
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
        password = 'Error: $e'; // Set an error message if an exception occurs
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
            phoneNumber = data['phoneNumber']; // Set the fetched name in the state
          });
        } else {
          setState(() {
            phoneNumber = 'phoneNumber not found'; // Set a default message if 'name' is not available
          });
        }
      } else {
        setState(() {
          phoneNumber = 'Failed to fetch data'; // Set an error message if HTTP request fails
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
            email = data['email']; // Set the fetched name in the state
          });
        } else {
          setState(() {
            email = 'Password not found'; // Set a default message if 'name' is not available
          });
        }
      } else {
        setState(() {
          email = 'Failed to fetch data'; // Set an error message if HTTP request fails
        });
      }
    } catch (e) {
      setState(() {
        email = 'Error: $e'; // Set an error message if an exception occurs
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      title: Stack(
                        children: [

                          Image.asset(
                            "assets/proff.png",
                            width: 60, 
                            height: 60, 
                            fit: BoxFit.cover, 
                          ),
                          Positioned(
                            bottom: 10,
                            left: 60,
                            right: 20,
                            child: Container(
                              color: Colors.white.withOpacity(0), // You can customize the background color and opacity
                              padding: EdgeInsets.symmetric(vertical: 1.0),
                              child: Text(
                                username,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,// You can customize the text color
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),),

                        ],
                      ),
                      trailing: Image.asset('assets/logoEMSI.png'),
                      onTap: () {
                        // Your onTap logic here
                      },
                    ),
                    const SizedBox(height:20),
                    ListTile(
                        leading:
                        Image.asset('assets/prof/menu.png'),
                        title:Text('M        E         N        U', style: TextStyle(color: drawerHeaderColor, fontWeight: FontWeight.bold),),
                        onTap:(){
                          Navigator.pushNamed(context, 'profil');
                        }
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                leading: Image.asset('assets/prof/reservations.png'),
                title:Text("R E S E R V A T I O N S",style: TextStyle(color: drawerHeaderColor, fontSize: 13),),
                onTap:() {
                  Navigator.pushNamed(context,'reservations');
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
                leading: Image.asset('assets/prof/complaints.png'),
                title:Text("C O M P L A I N T E S",style: TextStyle(color: drawerHeaderColor, fontSize: 13),),
                onTap:() {
                  Navigator.pushNamed(context,'complaintes');
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
                leading: Image.asset('assets/prof/profile.png'),
                title:Text("P R O F I L",style: TextStyle(color: drawerHeaderColor, fontSize: 13)),
                onTap:(){
                  Navigator.pushNamed(context, 'profil');
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
                leading: Image.asset('assets/prof/notifications.png'),
                title:Text("N O T I F I C A T I O N S",style: TextStyle(color: drawerHeaderColor, fontSize: 13),),
                onTap:() {
                  Navigator.pushNamed(context,'notifications');
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
                leading: Image.asset('assets/prof/logout.png'),
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
                      Image.asset("assets/proff.png", width: 120, 
                        height: 120, ), 
                      const SizedBox(width: 3), 
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 35,),
              ListTile(
                title:const Text("Informations basiques:",style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                trailing:Image.asset("assets/prof/edit.png", alignment: Alignment.bottomRight,),
                onTap:() {
                  Navigator.pushNamed(context,'infosbasiques');
                },
              ),
              const Divider(
                color: Colors.black87, 
                thickness: 0, 
                indent: 40, 
                endIndent: 20, 
                height: 0,
              ),
              ListTile(
                leading: Image.asset("assets/prof/name.png", alignment: Alignment.bottomRight,),
                title: Text('$name',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                subtitle: const Text("Nom complet", style: TextStyle(color: Colors.black87, fontSize: 11)),
              ),
              const Divider(
                color: Colors.black87, // Couleur du trait
                thickness: 0, // Épaisseur du trait
                indent: 40, // Marge à gauche
                endIndent: 20,
                height: 0,
              ),
              ListTile(
                leading: Image.asset("assets/prof/username.png", alignment: Alignment.bottomRight,),
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
                leading: Image.asset("assets/prof/padlock.png", alignment: Alignment.bottomRight,),
                title:Text('$password',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
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
                title:const Text("Informations de contact:",style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
                trailing:Image.asset("assets/prof/edit.png", alignment: Alignment.bottomRight,),
                onTap:() {
                  Navigator.pushNamed(context,'infoscontact');
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
                leading: Image.asset("assets/prof/phone.png", alignment: Alignment.bottomRight,),
                title:Text('$phoneNumber',style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 13),),
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
                leading: Image.asset("assets/prof/mail.png", alignment: Alignment.bottomRight,),
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
