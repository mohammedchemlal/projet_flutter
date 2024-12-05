import 'package:flutter/material.dart';
import 'package:flutter_1/ConnexionPage.dart';
import 'package:flutter_1/admin/acceuil.dart';
import 'package:flutter_1/admin/comptes.dart';
import 'package:flutter_1/admin/cours.dart';
import 'package:flutter_1/admin/dashboard.dart';
import 'package:flutter_1/admin/infos_basiques_admin.dart';
import 'package:flutter_1/admin/infos_contact_admin.dart';
import 'package:flutter_1/admin/profilAdmin.dart';
import 'package:flutter_1/admin/reservations.dart';
import 'package:flutter_1/admin/salles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_1/globals.dart' as globals;
void main() {
  runApp(const MyApp());
}

Color drawerHeaderColor = const Color(0xFFC62B20);
String a = globals.globalDataA;
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      routes: {
        'profilA': (context) => const profilAdmin(),
        'dashboard':(context) => const dashboardAdmin(),
        'acceuil': (context) => const acceuilAdmin(),
        'sallesA': (context) => const sallesAdmin(),
        'reservationsA': (context) => const reservationsAdmin(),
        'complaintesA': (context) => const complaintesAdmin(),
        'cours': (context) => const coursAdmin(),
        'infosbasiquesA':(context)=>const infosBasiquesAdmin(),
        'infoscontactA':(context)=>const infosContactAdmin(),
        'login':(context)=>const ConnexionPage(),
        'comptes':(context)=>const comptesAdmin(),
      },
      home: const complaintesAdmin(),
    );
  }
}

class complaintesAdmin extends StatefulWidget {
  const complaintesAdmin({Key? key}) : super(key: key);

  @override
  State<complaintesAdmin> createState() => _compState();
}
class _compState extends State<complaintesAdmin>{
  List<dynamic> list = []; 

  @override
  void initState() {
    super.initState();
    fetchAndSetComplaintes();
  }
  Future<List<dynamic>> fetchComplaintes() async {
    final String url = 'http://10.0.2.2/api_flutter_1/retrieve/getComplaintes.php'; 

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data as List<dynamic>; 
      } else {
        
        print('HTTP Error: ${response.statusCode}');
        return []; 
      }
    } catch (e) {
      
      print('Error: $e');
      return []; 
    }
  }

  Future<void> fetchAndSetComplaintes() async {
    var fetchedNotifications = await fetchComplaintes(); 
    setState(() {
      list = fetchedNotifications; 
    });
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
              'C O M P L A I N T E S',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          titleSpacing: 85,
        ),
      ),
      drawer: Drawer(
        child: Column(children: [
          DrawerHeader(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  title: Stack(
                    children: [
                      Image.asset(
                        "assets/piconline2.png",
                        width: 50, 
                        height: 50, 
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
                            a,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),),

                    ],),
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
                      Navigator.pushNamed(context, 'complaintesA');
                    }),
              ],
            ),),
          ListTile(
              leading: Image.asset('assets/admin/dashboard.png'),
              title: Text(
                "D A S H B O A R D ",
                style: TextStyle(color: drawerHeaderColor, fontSize: 11),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'dashboard');
              }),
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Image.asset('assets/admin/class.png'),
            title: Text(
              "S A L L E S",
              style: TextStyle(color: drawerHeaderColor, fontSize: 11),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'sallesA');
            },
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Image.asset('assets/admin/reservations.png'),
            title: Text(
              "R E S E R V A T I O N S",
              style: TextStyle(color: drawerHeaderColor, fontSize: 11),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'reservationsA');
            },
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  // Adjust the color to your preference
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Image.asset('assets/admin/profile.png'),
            title: Text("P R O F I L",
                style: TextStyle(color: drawerHeaderColor, fontSize: 11)),
            onTap: () {
              Navigator.pushNamed(context, 'profilA');
            },
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  // Adjust the color to your preference
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
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
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
              leading: Image.asset('assets/admin/complaintes.png'),
              title: Text(
                "C O M P L A I N T E S",
                style: TextStyle(color: drawerHeaderColor, fontSize: 11),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'complaintesA');
              }),
          const SizedBox(height: 10),
          Container(
            height: 1,
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],  
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            leading: Image.asset('assets/admin/logout.png'),
            title: Text(
              "D E C O N N E X I O N",
              style: TextStyle(color: drawerHeaderColor, fontSize: 11),
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
        ),),
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 5, bottom: 0),
        child: list.isEmpty
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: list.length,
          itemBuilder: (ctx, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Card(
                color: drawerHeaderColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: Image.asset("assets/admin/angryComp.png"),
                  title: Text(
                    'Descriptif: ${list[i]['text']}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Auteur: ${list[i]['auteur']}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Coupable: ${list[i]['coupable']}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Jour: ${list[i]['jour']}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
 
                      Text(
                        'Heure: ${list[i]['heure']}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Salle: ${list[i]['numSalle']}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Batiment: ${list[i]['batiment']}',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                        ),
                      ),
                      
                    ],
                  ),
                  onTap: null,
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), 
        child: SizedBox(
          height: 50.0, 
          child: BottomAppBar(
            color: Colors.transparent,
            child: Center(
              child: Text(
                '©Ecole Maroccaine de Science de Ingenieur-2024',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0, 
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}