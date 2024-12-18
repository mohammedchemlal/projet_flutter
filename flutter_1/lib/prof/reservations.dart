import 'package:flutter/material.dart';
import 'package:flutter_1/ConnexionPage.dart';
import 'package:flutter_1/prof/acceuil.dart';
import 'package:flutter_1/prof/complainte.dart';
import 'package:flutter_1/prof/infos_basiques_prof.dart';
import 'package:flutter_1/prof/infos_contact_prof.dart';
import 'package:flutter_1/prof/notifications.dart';
import 'package:flutter_1/prof/profil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_1/globals.dart' as globals;
void main() {
  runApp(const MyApp());
}
Color drawerHeaderColor = const Color(0xFF0D8F4E);
String username = globals.globalDataP;
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
      home: const reservationsProf(),
    );
  }
}

class reservationsProf extends StatefulWidget {
  const reservationsProf({Key? key}) : super(key: key);

  @override
  State<reservationsProf> createState() => _notifState();
}
class _notifState extends State<reservationsProf>{
  List<dynamic> list = []; 
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
    final String url = 'http://192.168.1.9/api_flutter_1/retrieve/getReservations.php';

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
    var url = Uri.parse('http://192.168.1.9/api_flutter_1/send/sendNotifToSecu.php'); 
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
                color: Colors.green,
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
                          "assets/proff.png",
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

                      },
                    ),
                    const SizedBox(height:1),
                    ListTile(
                        leading:
                        Image.asset('assets/prof/menu.png'),
                        title:Text('M        E         N        U', style: TextStyle(color: drawerHeaderColor, fontWeight: FontWeight.bold),),

                        onTap:(){
                          Navigator.pushNamed(context, 'reservations');
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
                  color: Colors.grey[300],  
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
                  color: Colors.grey[300],  
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
                  color: Colors.grey[300],  
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
      list = filterByDate(selectedDate); 
      });
      }
      },
              style: ElevatedButton.styleFrom(backgroundColor: drawerHeaderColor,),
        child: Text('Choisir date',style: TextStyle(color: Colors.white),),
      ),),
      ListTile(
        leading:
        Text("Rafraichir les réservations:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        trailing:
      ElevatedButton(onPressed:() {
        fetchAndSetReservations();
      }, style: ElevatedButton.styleFrom(backgroundColor: drawerHeaderColor),
          child: Icon(Icons.refresh_rounded, color: Colors.white,)),),
      SizedBox(height: 23), 

      
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
                  leading: Image.asset("assets/prof/bookingnotif.png"),
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
                      SizedBox(height: 4), 
                      Text(
                        'Reservée pour le: ${list[i]['dateRes']}',
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
                  trailing: ElevatedButton(
                    child: Text("Demander ouverture",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold, color: Colors.green),),
                    onPressed: () {
                      sendData(
                        "Veuillez ouvrir la salle n°${list[i]['salle']}",
                        list[i]['salle'],
                        list[i]['batiment'],
                        username,
                      );
                    },
                  ),
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