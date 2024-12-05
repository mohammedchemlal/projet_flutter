import 'package:flutter/material.dart';
import 'package:flutter_1/ConnexionPage.dart';
import 'package:flutter_1/admin/acceuil.dart';
import 'package:flutter_1/admin/complaintes.dart';
import 'package:flutter_1/admin/comptes.dart';
import 'package:flutter_1/admin/cours.dart';
import 'package:flutter_1/admin/infos_basiques_admin.dart';
import 'package:flutter_1/admin/infos_contact_admin.dart';
import 'package:flutter_1/admin/profilAdmin.dart';
import 'package:flutter_1/admin/reservations.dart';
import 'package:flutter_1/admin/salles.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';
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
      home: const dashboardAdmin(),
    );
  }
}

class dashboardAdmin extends StatefulWidget {
  const dashboardAdmin({Key? key}) : super(key: key);

  @override
  _dashboardAdminState createState() => _dashboardAdminState();
}

class _dashboardAdminState extends State<dashboardAdmin> {
  late int complaintsCount = 0; //instancier s de toutes les buildcards
  late int CompteCount = 0;
  late int ReservationsCount = 0;
  late int SallesCount = 0;
  late double reservationsCount;
  late double NONreservationsCount;


  @override
  void initState() {
    super.initState();
    fetchComplaintsCount(); // déclarer la méthode ici
    fetchCompteCount();
    fetchReservationsCount();
    fetchSallesCount();
    fetchReservationsCountCercle();
    fetchNONreservationsCountCercle();
  }
  Future<int> getReservationsCountCercle() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2/api_flutter_1/retrieve/getdataSR.php'));

    if (response.statusCode == 200) {
      return int.tryParse(response.body) ?? 0;
    } else {
      throw Exception('Failed to load reservations count');
    }
  }

  Future<void> fetchReservationsCountCercle() async {
    try {
      final count = await getReservationsCountCercle();
      setState(() {
        reservationsCount = count.toDouble();
      });
    } catch (e) {
      // Handle errors
      print('Error fetching reservations count: $e');
    }
  }

  Future<int> getNONreservationsCountCercle() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2/api_flutter_1/retrieve/getdataSNR.php'));

    if (response.statusCode == 200) {
      return int.tryParse(response.body) ?? 0;
    } else {
      throw Exception('Failed to load non reservations count');
    }
  }

  Future<void> fetchNONreservationsCountCercle() async {
    try {
      final count = await getNONreservationsCountCercle();
      setState(() {
        NONreservationsCount = count.toDouble();
      });
    } catch (e) {
      // Handle errors
      print('Error fetching reservations count: $e');
    }
  }
  Future<int> getComplaintsCount() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2/api_flutter_1/retrieve/getdata.php'));

    if (response.statusCode == 200) {
      return int.tryParse(response.body) ?? 0;
    } else {
      throw Exception('Failed to load complaints count');
    }
  }

  Future<void> fetchComplaintsCount() async {
    try {
      final count = await getComplaintsCount(); //// changer nom  de la fonction
      setState(() {
        complaintsCount = count; //// changer complaintsCount
      });
    } catch (e) {
      // Handle errors
      print('Error fetching complaints count: $e');
    }
  }

  Future<int> getCompteCount() async {
    final response = await http.get(
        Uri.parse('http:////10.0.2.2/api_flutter_1/retrieve/getdataCompte.php'));

    if (response.statusCode == 200) {
      return int.tryParse(response.body) ?? 0;
    } else {
      throw Exception('Failed to load compte count');
    }
  }

  Future<void> fetchCompteCount() async {
    try {
      final count = await getCompteCount(); //// changer nom  de la fonction
      setState(() {
        CompteCount = count; //// changer complaintsCount
      });
    } catch (e) {
      // Handle errors
      print('Error fetching compte count: $e');
    }
  }

  Future<int> getReservationsCount() async {
    final response = await http.get(Uri.parse(
        'http:////10.0.2.2/api_flutter_1/retrieve/getdataReservation.php'));

    if (response.statusCode == 200) {
      return int.tryParse(response.body) ?? 0;
    } else {
      throw Exception('Failed to load reservations count');
    }
  }

  Future<void> fetchReservationsCount() async {
    try {
      final count =
          await getReservationsCount(); //// changer nom  de la fonction
      setState(() {
        ReservationsCount = count; //// changer complaintsCount
      });
    } catch (e) {
      // Handle errors
      print('Error fetching reservations count: $e');
    }
  }

  Future<int> getSallesCount() async {
    final response = await http.get(
        Uri.parse('http:////10.0.2.2/api_flutter_1/retrieve/getdataSalles.php'));

    if (response.statusCode == 200) {
      return int.tryParse(response.body) ?? 0;
    } else {
      throw Exception('Failed to load Salles count');
    }
  }

  Future<void> fetchSallesCount() async {
    try {
      final count = await getSallesCount(); //// changer nom  de la fonction
      setState(() {
        SallesCount = count; //// changer complaintsCount
      });
    } catch (e) {
      print('Error fetching Salles count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Salles Reservées": reservationsCount,
      "Salles non Reservées": NONreservationsCount,
    };
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(39.0), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.white,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'D A S H B O A R D',
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
                      Navigator.pushNamed(context, 'dashboard');
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
              color: Colors.grey[300],  
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
              color: Colors.grey[300],  // Adjust the color to your preference
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
      body: SafeArea(
        child: Column(
          // child: PieChart(dataMap: dataMap,chartRadius: MediaQuery.of(context).size.width / 1.7,
          //),
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            PieChart(
              dataMap: dataMap,
              chartRadius: MediaQuery.of(context).size.width / 2.0,
              colorList: [
               Colors.red,
                Colors.blueAccent,
              ],
              legendOptions: LegendOptions(
                legendPosition: LegendPosition.bottom,
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValuesInPercentage: true,
              ),
            ),

            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCard("assets/admin/calendar.png", "Reservations",
                      '$ReservationsCount'),
                  buildCard(
                      "assets/admin/classroom.png", "Salles", '$SallesCount'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCard("assets/admin/anger.png", "Complaintes",
                      '$complaintsCount'), /////////// !!!!!!! appeler le compteur
                  buildCard("assets/admin/team.png", "Comptes", '$CompteCount'),
                  //style: TextStyle(color: Colors.black),
                ],
              ),
            ),
          ],
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

  Widget buildCard(String imagePath, String title, String count) {
    return SizedBox(
      width: 140.0,
      height: 142.0,
      child: Card(
        color: drawerHeaderColor,
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(imagePath),
              SizedBox(height: 10.0),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                count,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}
