import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_1/ConnexionPage.dart';
import 'package:flutter_1/secu/infos_basiques.dart';
import 'package:flutter_1/secu/infos_contact.dart';
import 'package:flutter_1/secu/notifications.dart';
import 'package:flutter_1/secu/profil.dart';
import 'package:flutter_1/secu/reservations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_1/globals.dart' as globals;

void main() {
  runApp(const MyApp());
}
Color drawerHeaderColor = const Color(0xFF2755CE);
TextEditingController complainte = TextEditingController();
String? selectedProf;
String? selectedSalle;
String? selectedHeure;
String? selectedJour;
String secu=globals.globalDataS;
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
      home: const complaintes(),
    );
  }
}
class complaintes extends StatefulWidget {
  const complaintes({Key? key}) : super(key: key);

  @override
  _complainteState createState() => _complainteState();
}

class _complainteState extends State<complaintes> {
  late List<String> sallesData = ["207","204","208"];
  late List<String> profData = [];
  late List<String> heures = ["8h30-10h20","10h30-12h20","14h-15h50","16h-17h50"];
  late List<String> jours = ["Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"];


  @override
  void initState() {
    super.initState();
    fetchAndSetProfsData();
    fetchAndSetSallesData();
  }
  void resetDropdownValue() {
    setState(() {
      selectedProf = null;
      selectedSalle = null;
      selectedJour = null;
      selectedHeure=null;
    });
  }
  Future<bool> sendDataToPHP() async {
    final String url = 'http://10.0.2.2/api_flutter_1/insert/insertcomplaintaboutprof.php'; // Replace with your PHP script URL
    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          'text': complainte.text,
          'numSalle': selectedSalle.toString(),
          'auteur': secu,
          'coupable': selectedProf.toString(),
          'jour': selectedJour.toString(),
          'heure': selectedHeure.toString(),
          'username': secu
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == "Success") {
          print('Data sent successfully');
          print('Response: ${response.body}');
          return true; // Request successful
        } else {
          print('Failed to send data. Error: ${data['error']}');
          return false; // Request failed
        }
      } else {
        print('Failed to send data. Error: ${response.statusCode}, ${response.reasonPhrase}');
        return false; // Request failed
      }
    } catch (e) {
      print('Failed to send data. Error: $e');
      return false; // Request failed
    }
  }
  Future<List<String>> fetchSallesData(String username) async {
    final url = Uri.parse('http://10.0.2.2/api_flutter_1/retrieve/retrieveclassfrombatiment.php'); // Replace with your API endpoint

    try {
      final response = await http.post(
        url,
        body: json.encode({'username': username}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<String> numList = data.map((item) => item.toString()).toList();
        return numList;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return []; // Return an empty list or handle the error accordingly
    }
  }

  Future<void> fetchAndSetSallesData() async {
    try {
      final data = await fetchSallesData(secu); // Replace with the actual username
      setState(() {
        sallesData = data;
      });
    } catch (e) {
      print('Failed to fetch data: $e');
    }
  }
  Future<List<String>> fetchProfData() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2/api_flutter_1/retrieve/retrieveprofessors.php'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<String> profList = data.map((item) => item.toString()).toList();
        return profList;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return []; // Return an empty list or handle the error accordingly
    }
  }
  Future<void> fetchAndSetProfsData() async {
    try {
      final data = await fetchProfData();
      setState(() {
        profData = data;
      });
    } catch (e) {
      print('Failed to fetch data: $e');
    }
  }

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
              ' C O M P L A I N T E S',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          titleSpacing: 65,
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
                                secu,
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
                        Image.asset('assets/secu/menu.png'),
                        title:Text('M        E         N        U', style: TextStyle(color: drawerHeaderColor, fontWeight: FontWeight.bold),),
                        onTap:(){
                          Navigator.pushNamed(context, 'complaintesS');
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
      //... (other scaffold properties)
      body: Container(
        child: Padding(
        padding: const EdgeInsets.only(top: 30,left: 10,right: 60, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading:Image.asset("assets/secu/complaintepage.png"),
              title:Text('Rédaction de complaintes', style: TextStyle(fontWeight: FontWeight.bold, color: drawerHeaderColor, fontSize: 16),
              ),),
            Align(
              alignment: Alignment.centerLeft,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextField(
                      maxLength: 100,
                      maxLines: 11,
                    controller: complainte,
                    cursorColor: drawerHeaderColor,
                    decoration: InputDecoration(
                      hintText: 'Rédigez votre complainte(1-100 caractères)',
                      hintStyle: TextStyle(fontSize: 12,),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: drawerHeaderColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: drawerHeaderColor,
                        ),
                      ),
                    ),
                  ),),
                ),
              ),),
            Align(
              alignment: Alignment.centerLeft,
            child: DropdownButton<String>(
              padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 0),
              hint: Text(
                'Sélectionnez une salle:',
                style: TextStyle(color: drawerHeaderColor, fontSize: 11),
              ),
              iconEnabledColor: drawerHeaderColor,
              borderRadius: BorderRadius.horizontal(),
              value: selectedSalle, // Set the selected value
              onChanged: (String? newValue) {
                setState(() {
                  selectedSalle = newValue; // Update the selected value
                });
              },
              items: sallesData.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),),
            const SizedBox(height: 10,),
            Align(
              alignment: Alignment.centerLeft,
              child: DropdownButton<String>(
                padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 0),
                hint: Text(
                  'Sélectionnez un prof:',
                  style: TextStyle(color: drawerHeaderColor, fontSize: 11),
                ),
                iconEnabledColor: drawerHeaderColor,
                borderRadius: BorderRadius.horizontal(),
                value: selectedProf, // Set the selected value
                onChanged: (String? newValue) {
                  setState(() {
                    selectedProf = newValue; // Update the selected value
                  });
                  // Perform actions based on the newValue if needed
                },
                items: profData.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),),
            Align(
              alignment: Alignment.centerLeft,
              child: DropdownButton<String>(
                padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 0),
                hint: Text(
                  'Sélectionnez un jour:',
                  style: TextStyle(color: drawerHeaderColor, fontSize: 11),
                ),
                iconEnabledColor: drawerHeaderColor,
                borderRadius: BorderRadius.horizontal(),
                value: selectedJour, // Set the selected value
                onChanged: (String? newValue) {
                  setState(() {
                    selectedJour = newValue; // Update the selected value
                  });
                  // Perform actions based on the newValue if needed
                },
                items: jours.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),),
            Align(
              alignment: Alignment.centerLeft,
              child: DropdownButton<String>(
                padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 0),
                hint: Text(
                  'Sélectionnez une heure:',
                  style: TextStyle(color: drawerHeaderColor, fontSize: 11),
                ),
                iconEnabledColor: drawerHeaderColor,
                borderRadius: BorderRadius.horizontal(),
                value: selectedHeure, // Set the selected value
                onChanged: (String? newValue) {
                  setState(() {
                    selectedHeure = newValue; // Update the selected value
                  });
                  // Perform actions based on the newValue if needed
                },
                items: heures.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),),
          const SizedBox(height: 12,),
            Align(
            alignment: Alignment.centerLeft,
           child: ElevatedButton(
            onPressed: () async{
              String c = complainte.text;
              bool function = await sendDataToPHP();
              if(c.isNotEmpty && selectedProf!=null && selectedHeure!=null && selectedJour!=null){
                if(!function){
                Fluttertoast.showToast(msg: "Votre complainte a été envoyée!");
                  complainte.clear();
                  resetDropdownValue();
              }}
              else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Veuillez remplir tous les champs'),
                    duration: Duration(seconds: 3),
                  ),);
              }
            },
   style: ElevatedButton.styleFrom(
     foregroundColor: Colors.white, backgroundColor: drawerHeaderColor, // Text color
     padding: const EdgeInsets.only(top: 0,left:0,right: 80, bottom: 0), // Button padding
     shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(8), // Button border radius
     ),),
   child: const Text('                                  E N V O Y E R                               ',textAlign: TextAlign.center,
     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
     ,
   ),
 ),),
          ],
        ),
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
