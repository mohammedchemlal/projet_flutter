import 'package:flutter/material.dart';
import 'package:flutter_1/ConnexionPage.dart';
import 'package:flutter_1/admin/acceuil.dart';
import 'package:flutter_1/admin/complaintes.dart';
import 'package:flutter_1/admin/comptes.dart';
import 'package:flutter_1/admin/cours.dart';
import 'package:flutter_1/admin/dashboard.dart';
import 'package:flutter_1/admin/infos_basiques_admin.dart';
import 'package:flutter_1/admin/infos_contact_admin.dart';
import 'package:flutter_1/admin/profilAdmin.dart';
import 'package:flutter_1/admin/salles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_1/globals.dart' as globals;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
void main() {
  runApp(const MyApp());
}
Color drawerHeaderColor = const Color(0xFFC62B20);
Color addButtonColor = const Color(0xFFC62B20);
Color salleNumeroColor = Colors.white;
String? selectedProf;
int deleteById = 0;
int requeteInsertionRES = 0;
int requeteModificationRES = 0;
String? selectedheure;
String a=globals.globalDataS;
List<String> heure =
["8h30-10h20","10h30-12h20","14h-15h50","16h-17h50"];

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
        'infosbasiques':(context)=>const infosBasiquesAdmin(),
        'infoscontact':(context)=>const infosContactAdmin(),
        'login':(context)=>const ConnexionPage(),
        'comptes':(context)=>const comptesAdmin(),
      },
      home: const reservationsAdmin(),
    );
  }
}

class reservationsAdmin extends StatefulWidget {
  const reservationsAdmin({Key? key}) : super(key: key);

  @override
  _reservations createState() => _reservations();
}

class _reservations extends State<reservationsAdmin> {
  List<dynamic> list = [];
  TextEditingController salleController = TextEditingController();
  TextEditingController etageController = TextEditingController();
  TextEditingController batimentController = TextEditingController();
  TextEditingController dateResController = TextEditingController();
  TextEditingController profController = TextEditingController();

  late List<String> profData = [];
  @override
  void initState() {
    super.initState();
    fetchAndSetComplaintes();
    fetchAndSetProfsData();
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter une réservation'),
          content: Column(
            children: [
              TextFormField(
                controller: salleController,
                decoration: InputDecoration(labelText: 'Numéro de salle'),
              ),
              TextFormField(
                controller: etageController,
                decoration: InputDecoration(labelText: 'Étage'),
              ),
              TextFormField(
                controller: batimentController,
                decoration: InputDecoration(labelText: 'Bâtiment'),
              ),
              TextFormField(
                controller: batimentController,
                decoration: InputDecoration(labelText: 'Date de réservation'),
              ),
              TextFormField(
                controller: batimentController,
                decoration: InputDecoration(labelText: 'Professeur'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: (salleController.text.isNotEmpty &&
                  etageController.text.isNotEmpty &&
                  batimentController.text.isNotEmpty &&
                  dateResController.text.isNotEmpty &&
                  profController.text.isNotEmpty)
                  ? () {
                // Ajouter la salle
                addReservation(
                  salleController.text as int,
                  etageController.text as int,
                  batimentController.text as int,
                  dateResController.text,
                  selectedProf.toString(),
                  selectedheure.toString(),
                );
                Navigator.of(context).pop(); 
              }
                  : null, 
              child: Text('Valider'),
            ),
          ],
        );
      },
    );
  }

  Future<List<String>> fetchProfData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.1.9/api_flutter_1/retrieve/retrieveprofessorsusername.php'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<String> profList = data.map((item) => item.toString()).toList();
        return profList;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
      return []; 
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

  Future<List<dynamic>> fetchComplaintes() async {
    final String url =
        'http://192.168.1.9/api_flutter_1/retrieve/getReservation.php'; 

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data as List<
            dynamic>; 
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
    var fetchedComplaintes =
    await fetchComplaintes(); 
    setState(() {
      list = fetchedComplaintes; 
    });
  }

  Future<void> deleteReservation() async {
    final String url =
        'http://192.168.1.9/api_flutter_1/insert/deleteReservation.php';

    try {
      var response = await http.post(Uri.parse(url), body: {
        'idR': deleteById.toString(), 
      });

      if (response.statusCode == 200) {
        
        print('Salle supprimée avec succès');
        fetchAndSetComplaintes();
      } else {
        print('Erreur HTTP : ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur : $e');
    }
  }

  Future<void> addReservation(int salle, int etage, int batiment,
      String dateRes, String prof, String heure) async {
    final String url = 'http://192.168.1.9/api_flutter_1/insert/addReservation.php';

    try {
      var response = await http.post(Uri.parse(url), body: {
        'salle': salle.toString(),
        'etage': etage.toString(),
        'batiment': batiment.toString(),
        'dateRes': dateRes,
        'heure': selectedheure.toString(),
        'prof': selectedProf.toString(),
      });

      if (response.statusCode == 200) {
        print('Reservation added successfully');
        fetchAndSetComplaintes();
      } else {
        print('HTTP Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateReservation(
      int salle,
      int etage,
      int batiment,
      String dateRes,
      String heure,
      String prof,
      int salleActuel,
      int etageActuel,
      int batimentActuel,
      int dateResActuel,
      int heureActuel, 
      int profActuel,
    // change le type
      ) async {
    final String url =
        'http://192.168.1.9/api_flutter_1/insert/updateReservation.php';

    try {
      var response = await http.post(Uri.parse(url), body: {
        'salle': salle.toString(),
        'etage': etage.toString(),
        'batiment': batiment.toString(),
        'dateRes': dateRes,
        'heure': heure,
        'prof': prof,
        'salleActuel': salleActuel.toString(),
        'etageActuel': etageActuel.toString(),
        'batimentActuel': batimentActuel.toString(),
        'dateResActuel': dateResActuel.toString(),
        'heureActuel': heureActuel.toString(),
        'profActuel': profActuel.toString(),
      });

      if (response.statusCode == 200) {
        print('Reservation updated successfully');
        fetchAndSetComplaintes();
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
        const Size.fromHeight(39.0),
        child: AppBar(
          backgroundColor: Colors.white,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'R E S E R V A T I O N S ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          titleSpacing: 30,
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
                      Navigator.pushNamed(context, 'reservationsA');
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
              color: Colors.grey[300],  // Adjust the color to your preference
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
              color: Colors.grey[300],  // Adjust the color to your preference
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
              color: Colors.grey[300],  // Adjust the color to your preference
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: list.isEmpty
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.builder(
                itemCount: list.length,
                itemBuilder: (ctx, i) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Color(0xFFC62B20),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8),
                      title: Text(
                        'Réservation n°:${list[i]['idR']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: salleNumeroColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Salle: E${list[i]['salle']}',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                              Colors.grey,
                            ),
                          ),
                          Text(
                            'Etage: ${list[i]['etage']}',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                              Colors.grey,
                            ),
                          ),
                          Text(
                            'Batiment: ${list[i]['batiment']}',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                              Colors.grey,
                            ),
                          ),
                          Text(
                            'Date de réservation: ${list[i]['dateRes']}',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                              Colors.grey,
                            ),
                          ),
                          Text(
                            'Heure de réservation: ${list[i]['heure']}',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                              Colors.grey,
                            ),
                          ),
                          Text(
                            'Professeur: ${list[i]['prof']}',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                              Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              deleteById =
                                  int.tryParse('${list[i]['idR']}') ?? 0;

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
                                    ),
                                    backgroundColor:
                                    const Color(0xFFC62B20),
                                    title: Text(
                                      'Confirmation',
                                      style:
                                      TextStyle(color: Colors.white),
                                    ),
                                    content: Text(
                                        'Voulez-vous vraiment supprimer la réservation n°:$deleteById ? '),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Annuler',
                                          style: TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          deleteReservation();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Supprimer',
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      onTap: null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: const Color(0xFFC62B20),
                title: Text(
                  'Ajouter une reservation',
                  style: TextStyle(color: Colors.white),
                ),
                content: Container(
                  height: 352.0, 
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: salleController,
                        decoration: InputDecoration(
                          labelText: 'Numéro de salle',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextFormField(
                        controller: etageController,
                        decoration: InputDecoration(
                          labelText: 'Étage',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextFormField(
                        controller: batimentController,
                        decoration: InputDecoration(
                          labelText: 'Bâtiment',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                      ),
                      DateTimeField(
                        format: DateFormat("yyyy-MM-dd"), 
                        controller: dateResController,
                        decoration: InputDecoration(
                          labelText: 'Date de réservation',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        onShowPicker: (context, currentValue) async {
                          return showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            initialDate: currentValue ?? DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                        },
                      ),
                      DropdownButtonFormField<String>(
                        value: selectedheure, 
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedheure =
                                newValue; 
                          });
                        },
                        items: heure.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Heure',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: Color.fromARGB(255, 201, 186, 185),
                      ),
                      DropdownButtonFormField<String>(
                        value: selectedProf, // Valeur sélectionnée
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedProf =
                                newValue; // Mettre à jour
                          });
                        },
                        items: profData.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Enseignant',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        dropdownColor: Color.fromARGB(255, 201, 186, 185),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); 
                    },
                    child: Text(
                      'Annuler',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      addReservation(
                        int.parse(salleController.text),
                        int.parse(etageController.text),
                        int.parse(batimentController.text),
                        dateResController.text,
                        selectedProf.toString(),
                        selectedheure.toString(),
                      );
                      Navigator.of(context).pop(); // Fermer le dialogue
                    },
                    child: Text('Valider'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
        backgroundColor: addButtonColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
