import 'package:flutter/material.dart';
import 'package:flutter_1/ConnexionPage.dart';
import 'package:flutter_1/secu/complaintes.dart';
import 'package:flutter_1/secu/infos_basiques.dart';
import 'package:flutter_1/secu/infos_contact.dart';
import 'package:flutter_1/secu/notifications.dart';
import 'package:flutter_1/secu/profil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_1/globals.dart' as globals;
void main() {
  runApp(const MyApp());
}
Color drawerHeaderColor = const Color(0xFF3366FF);
String username=globals.globalDataS;
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Example',
      routes: {
        'profilS': (context) => const profil(),
        'reservationsS': (context) => const reservations(),
        'complaintesS': (context) => const complaintes(),
        'notificationsS': (context) => const notifications(),
        'infosbasiquesS':(context)=>const infosBasiques(),
        'infoscontactS':(context)=>const infosContact(),
        'login':(context)=>const ConnexionPage(),
      },
      home: const reservations(),
    );
  }
}

class reservations extends StatefulWidget {
  const reservations({Key? key}) : super(key: key);

  @override
  State<reservations> createState() => _notifState();
}
class _notifState extends State<reservations>{
  List<dynamic> list = []; // Your list to hold notifications
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
    fetchAndSetReservations();
  }
  List<dynamic> filterByDate(DateTime selectedDate) {
    return list.where((reservation) {
      DateTime reservationDate = DateTime.parse(reservation['dateRes']);
      return reservationDate.year == selectedDate.year &&
          reservationDate.month == selectedDate.month &&
          reservationDate.day == selectedDate.day;
    }).toList();
  }

  Future<List<dynamic>> fetchReservations() async {
    final String url = 'http://10.0.2.2/api_flutter_1/retrieve/getReservationsForSecu.php';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {'username': username},
      );

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


  Future<void> fetchAndSetReservations() async {
    var fetched = await fetchReservations(); 
    setState(() {
      list = fetched; 
    });
  }
  Future<void> sendData(
      String notif,
      String salle,
      String batiment,
      String prof,
      ) async {
    var url = Uri.parse('http://10.0.2.2/api_flutter_1/send/sendNotifToSecu.php'); 

    try {
      var response = await http.post(
        url,
        body: {
          'notif': notif,
          'salle': salle,
          'batiment': batiment,
          'de': prof,
        },
      );
      if (response.statusCode == 200) {
        print('Data sent successfully');
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  bool isConfirmed = false;
  List<bool> cardStates = List.generate(10, (index) => false);
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
              'R E S E R V A T I O N S',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          titleSpacing: 30,
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
                        // Your onTap logic here
                      },
                    ),
                    const SizedBox(height:20),
                    ListTile(
                        leading:
                        Image.asset('assets/secu/menu.png'),
                        title:Text('M        E         N        U', style: TextStyle(color: drawerHeaderColor, fontWeight: FontWeight.bold),),
                        onTap:(){
                          Navigator.pushNamed(context, 'reservationsS');
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
                  color: Colors.grey[300],  
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
                  color: Colors.grey[300],  
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
                  color: Colors.grey[300],  
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
                  color: Colors.grey[300],  
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
      body: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 5, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading:
              Text("Trier par date:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              trailing:
              ElevatedButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2050),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                      list = filterByDate(selectedDate); // Filter the list based on selected date
                    });
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: drawerHeaderColor,),
                child: Text('Choisir date',style: TextStyle(color: Colors.white),),
              ),),
            SizedBox(height: 23), // Adjust spacing

            // ListView.builder to display filtered reservations
            Expanded(
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
                        leading: Icon(Icons.timeline),
                        title: Text(
                          'E${list[i]['salle']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Etage: ${list[i]['etage']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Batiment: ${list[i]['batiment']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4), // Adjust this height according to your preference
                            Text(
                              'Reservée pour le: ${list[i]['dateRes']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Reservée pour le prof: ${list[i]['prof']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Horaire: ${list[i]['heure']}',
                              style: TextStyle(
                                fontSize: 14,
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
}