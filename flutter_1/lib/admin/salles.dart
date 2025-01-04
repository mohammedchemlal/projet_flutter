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
import 'package:flutter_1/admin/reservations.dart';
import 'package:flutter_1/admin/salles.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_1/globals.dart' as globals;

void main() {
  runApp(const MyApp());
}
String a = globals.globalDataA;
Color drawerHeaderColor = const Color(0xFFC62B20);
Color addButtonColor = const Color(0xFFC62B20);
Color salleNumeroColor = Colors.white;
int numToDelete = 0;
int requeteInsertion = 0;
int requeteModification = 0;
int? selectedBatiment; // Your list of items
List<Map<String, dynamic>> filteredList = [];
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
      home: const sallesAdmin(),
    );
  }
}

class sallesAdmin extends StatefulWidget {
  const sallesAdmin({Key? key}) : super(key: key);

  @override
  _affichage createState() => _affichage();
}

class _affichage extends State<sallesAdmin> {
  List<dynamic> list = [];
  TextEditingController etageController = TextEditingController();
  TextEditingController batimentController = TextEditingController();
  TextEditingController numController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAndSetComplaintes();
  }

  void _showAddSalleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajouter une salle'),
          content: Column(
            children: [
              TextFormField(
                controller: numController,
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
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fermer le dialogue
              },
              child: Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: (etageController.text.isNotEmpty &&
                      batimentController.text.isNotEmpty &&
                      numController.text.isNotEmpty)
                  ? () {
                      // Ajouter la salle
                      addSalle(
                        numController.text,
                        etageController.text,
                        batimentController.text,
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

  Future<List<dynamic>> fetchComplaintes() async {
    final String url =
        'http://10.0.2.2/api_flutter_1/retrieve/getInfoSalles.php'; 

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

  Future<void> deleteSalle() async {
    final String url = 'http://10.0.2.2/api_flutter_1/insert/deleteSalle.php';

    try {
      var response = await http.post(Uri.parse(url), body: {
        'num': numToDelete.toString(),
      });

      if (response.statusCode == 200) {
        print('Salle deleted successfully');
        fetchAndSetComplaintes();
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addSalle(String numero, String etage, String batiment) async {
    final String url = 'http://10.0.2.2/api_flutter_1/insert/addSalle.php';

    try {
      var response = await http.post(Uri.parse(url),
          body: {'etage': etage, 'batiment': batiment, 'num': numero});

      if (response.statusCode == 200) {
        print('Salle added successfully');
        fetchAndSetComplaintes();
      } else {
        print('HTTP Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> updateSalle(String etage, String batiment, String num,
      int numActuel, int etageActuel, int batimentActuel) async {
    final String url = 'http://10.0.2.2/api_flutter_1/insert/update.php';

    try {
      var response = await http.post(Uri.parse(url), body: {
        'etage': etage,
        'batiment': batiment,
        'num': num,
        'numActuel': numActuel.toString(),
        'batimentActuel': batimentActuel.toString(),
        'etageActuel': etageActuel.toString(),
      });

      if (response.statusCode == 200) {
        // Handle success
        print('Salle updated successfully');
        // Update the UI by fetching the updated list of salles
        fetchAndSetComplaintes();
      } else {
        // Handle other HTTP status codes
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(39.0), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.white,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'S A L L E S ',
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
                      Navigator.pushNamed(context, 'sallesA');
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
              color: Colors.grey[300],  // Adjust the color to your preference
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
    'Salle: E${list[i]['num']}',
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
    numToDelete =
    int.tryParse('${list[i]['num']}') ?? 0;
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
    'Voulez-vous vraiment supprimer la salle $numToDelete ? '),
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
    deleteSalle();
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
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    TextEditingController etageController =
                                        TextEditingController();
                                    TextEditingController batimentController =
                                        TextEditingController();
                                    TextEditingController numController =
                                        TextEditingController();

                                    etageController.text =
                                        list[i]['etage'].toString();
                                    batimentController.text =
                                        list[i]['batiment'].toString();
                                    numController.text =
                                        list[i]['num'].toString();

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
                                            'Modifier la salle',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          content: Container(
                                            height:
                                                200.0, // Set a smaller height
                                            padding: EdgeInsets.all(8.0),

                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  controller: numController,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'Numéro de salle',
                                                    labelStyle: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller: etageController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Étage',
                                                    labelStyle: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                TextFormField(
                                                  controller:
                                                      batimentController,
                                                  decoration: InputDecoration(
                                                    labelText: 'Bâtiment',
                                                    labelStyle: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          contentPadding: EdgeInsets.all(8.0),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // Fermer le dialogue
                                              },
                                              child: Text(
                                                'Annuler',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                try {
                                                  int numActuel = int.tryParse(
                                                          '${list[i]['num']}') ??
                                                      0;
                                                  int etageActuel = int.tryParse(
                                                          '${list[i]['etage']}') ??
                                                      0;
                                                  int batimentActuel = int.tryParse(
                                                          '${list[i]['batiment']}') ??
                                                      0;

                                                  // Mettre à jour la salle
                                                  updateSalle(
                                                    etageController.text,
                                                    batimentController.text,
                                                    numController.text,
                                                    numActuel,
                                                    etageActuel,
                                                    batimentActuel,
                                                  );
                                                } catch (e) {
                                                  print(
                                                      'Error parsing integers: $e');
                                                }

                                                Navigator.of(context)
                                                    .pop(); // Fermer le dialogue
                                              },
                                              child: Text('Valider'),
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Text(
          '©Ecole Maroccaine de Science de Ingenieur-2024',
          textAlign: TextAlign.center,
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
                backgroundColor:drawerHeaderColor,
                title: Text(
                  'Ajouter une salle',
                  style: TextStyle(color: Colors.white, fontSize: 20,),
                ),
                content: Container(
                  height: 200.0, // Set a smaller height
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: numController,
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
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Fermer le dialogue
                    },
                    child: Text(
                      'Annuler',
                      style: TextStyle(
                        color: Colors.white, 
                        fontSize: 16, 
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.white, 
                     foregroundColor: drawerHeaderColor, 
                      elevation: 4, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), 
                      ),
                    ),
                    onPressed: () {
                      addSalle(
                        numController.text,
                        etageController.text,
                        batimentController.text,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Valider',
                      style: TextStyle(
                        fontSize: 16, 
                      ),
                    ),
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
      bottomSheet: SizedBox(height: 10),
    );
  }
}
