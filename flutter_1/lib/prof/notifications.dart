import 'package:flutter/material.dart';
import 'package:flutter_1/ConnexionPage.dart';
import 'package:flutter_1/prof/infos_basiques_prof.dart';
import 'package:flutter_1/prof/infos_contact_prof.dart';
import 'acceuil.dart';
import 'complainte.dart';
import 'profil.dart';
import 'reservations.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_1/globals.dart' as globals;
void main()

{
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
        'infosbasiques':(context)=>const infosBasiquesProf(),
        'infoscontact':(context)=>const infosContactProf(),
        'login':(context)=>const ConnexionPage(),
      },
      home: const notificationsProf(),
    );
  }
}
String user = globals.globalDataP;
class notificationsProf extends StatefulWidget {
  const notificationsProf({Key? key}) : super(key: key);

  @override
  State<notificationsProf> createState() => _notifState();
}
class _notifState extends State<notificationsProf>{
  List<dynamic> list = []; // Your list to hold notifications

  @override
  void initState() {
    super.initState();
    fetchAndSetNotifications(); // Fetch notifications when the widget initializes
  }
  Future<List<dynamic>> fetchNotifications(String versProf) async {
    var url = Uri.parse('http://10.0.2.2/api_flutter_1/retrieve/getNotifsProf.php'); // Replace with your PHP script URL

    try {
      var response = await http.post(
          url,
          body: {
            'vers': versProf,
          });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data as List<dynamic>; // Return the parsed JSON data as a list of dynamic objects
      } else {
        // Handle HTTP error status codes
        print('HTTP Error: ${response.statusCode}');
        return []; // Return an empty list if there's an error
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
      return []; // Return an empty list in case of exceptions
    }
  }

  Future<void> fetchAndSetNotifications() async {
    var fetchedNotifications = await fetchNotifications(user); // Call the function to fetch notifications
    setState(() {
      list = fetchedNotifications; // Set the fetched notifications to the list
    });
  }
  bool isConfirmed = false;
  List<bool> cardStates = List.generate(10, (index) => false);
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
              'N O T I F I C A T I O N S',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          titleSpacing: 90,
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
                            width: 50, // Adjust the width as needed
                            height: 50, // Adjust the height as needed
                            fit: BoxFit.cover, // or another BoxFit option depending on your layout requirements
                          ),
                          Positioned(
                            bottom: 10,
                            left: 60,
                            right: 20,
                            child: Container(
                              color: Colors.white.withOpacity(0), // You can customize the background color and opacity
                              padding: EdgeInsets.symmetric(vertical: 1.0),
                              child: Text(
                                user,
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
                          Navigator.pushNamed(context, 'notifications');
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
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 5, bottom: 0),
        child: list.isEmpty
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: list.length,
          itemBuilder: (ctx, i) {
            bool isConfirmed = cardStates[i];
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
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.notifications,
                      color: drawerHeaderColor,
                    ),
                  ),
                  title: Text(
                    list[i]['notif'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "Batiment: ${list[i]['batiment']}",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  onTap: null,
                ),
              ),
            );
          },
        ),
      ),
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