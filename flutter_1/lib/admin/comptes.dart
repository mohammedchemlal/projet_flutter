import 'package:flutter/material.dart';
import 'package:flutter_1/ConnexionPage.dart';
import 'package:flutter_1/admin/acceuil.dart';
import 'package:flutter_1/admin/complaintes.dart';
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
Color addButtonColor = const Color(0xFFC62B20);
Color accusernColor = Colors.white;
int userToDelete = 0;
int requeteInsertion = 0;
int requeteModification = 0;
int? selectedAcc;
List<dynamic> filteredList=[];
String a = globals.globalDataA;
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des utilisateurs',
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
      home: const comptesAdmin(),
    );
  }
}
class comptesAdmin extends StatefulWidget {
  const comptesAdmin({Key? key}) : super(key: key);
  @override
  _affichage createState() => _affichage();
}
class _affichage extends State<comptesAdmin> {
  List<dynamic> list = [];
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usertypeController = TextEditingController();
  TextEditingController batimentController = TextEditingController();
  TextEditingController coursController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchAndSetAcc();
  }
  void _showAddAcc(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter un compte'),
          content: Column(
            children: [
              TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'password'),
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'nom'),
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: const InputDecoration(labelText: 'GSM'),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: usertypeController,
                decoration: const InputDecoration(labelText: 'User Type'),
              ),
              TextFormField(
                controller: batimentController,
                decoration: const InputDecoration(labelText: 'Batiment'),
              ),
              TextFormField(
                controller: coursController,
                decoration: const InputDecoration(labelText: 'Cours'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); 
              },
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: (usernameController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty &&
                  nameController.text.isNotEmpty &&
                  phoneNumberController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  usertypeController.text.isNotEmpty &&
                  coursController.text.isNotEmpty
              )
                  ? () {
                addAcc(
                  usernameController.text,
                  passwordController.text,
                  nameController.text,
                  phoneNumberController.text,
                  emailController.text,
                  usertypeController.text,
                  batimentController.text,
                  coursController.text,
                );
                Navigator.of(context).pop();
              }
                  : null,
              child: const Text('Valider'),
            ),
          ],
        );
      },
    );
  }
  Future<List<dynamic>> fetchAcc() async {
    const String url =
        'http://10.0.2.2/api_flutter_1/retrieve/getInfoAccounts.php';
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
  Future<void> fetchAndSetAcc() async {
    var fetchedAcc =
    await fetchAcc();
    setState(() {
      list = fetchedAcc;
    });
  }
  Future<void> deleteAcc() async {
    const String url = 'http://10.0.2.2/api_flutter_1/insert/deleteAccount.php';

    try {
      var response = await http.post(Uri.parse(url), body: {
        'idU': userToDelete.toString(),
      });

      if (response.statusCode == 200) {
        // Handle success
        print('Compte supprimé avec succès');

        fetchAndSetAcc();
      } else {
      
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addAcc(String username, String password, String name,String phonenumber, String email, String usertype,String batiment,String cours) async {
    String url = 'http://10.0.2.2/api_flutter_1/insert/addAccount.php'; 

    //  les valeurs envoi
    print('Nom  : $username');
    print('Mot de passe : $password');
    

    try {
      
      var response = await http.post(
        Uri.parse(url),
        body: {
          'username': username,
          'password': password,
          'name': name,
          'phoneNumber': phoneNumber,
          'email': email,
          'userType':usertype,
          'batiment': batiment,
          'cours': cours,

        },
      );

   
      if (response.statusCode == 200) {
        print('L\'utilisateur a été ajouté avec succès.');
      } else {
        print('Erreur lors de l\'ajout de l\'agent de sécurité : ${response.body}');
      }
    } catch (e) {
      print('Erreur lors de la requête HTTP : $e');
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
                'Comptes ',
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
                        Navigator.pushNamed(context, 'comptes');
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
                color: Colors.grey[300], 
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: list.isEmpty
                    ? const Center(
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
                      color: const Color(0xFFC62B20),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        title: Text(
                          '${list[i]['name']}',
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
                              'UserType: ${list[i]['userType']}',
                              style: const TextStyle(
                                fontSize: 14,
                                color:
                                Colors.grey,
                              ),
                            ),
                            Text(
                              'Username: ${list[i]['username']}',
                              style: const TextStyle(
                                fontSize: 14,
                                color:
                                Colors.grey,
                              ),
                            ),
                            Text(
                              'Password: ${list[i]['password']}',
                              style: const TextStyle(
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
                                userToDelete= int.tryParse('${list[i]['idU']}') ?? 0;
                                String nomCours= '${list[i]['name']}';
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
                                          'Voulez-vous vraiment supprimer user $nomCours ? '),
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
                                            deleteAcc();
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
                  backgroundColor:drawerHeaderColor,
                  title: const Text(
                    'Ajouter un compte',
                    style: TextStyle(color: Colors.white, fontSize: 20,),
                  ),
                  content: Container(
                    height: 500.0, 
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextFormField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nom',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextFormField(
                          controller: phoneNumberController,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextFormField(
                          controller:  usertypeController,
                          decoration: const InputDecoration(
                            labelText: 'UserType',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextFormField(
                          controller: batimentController,
                          decoration: const InputDecoration(
                            labelText: 'Batiment',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextFormField(
                          controller: coursController,
                          decoration: const InputDecoration(
                            labelText: 'Cours',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); 
                      },
                      child: const Text(
                        'Annuler',
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 16, 
                        ),
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: drawerHeaderColor, backgroundColor: Colors.white, 
                        elevation: 4, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), 
                        ),
                      ),
                      onPressed: () {
                        addAcc(
                          usernameController.text,
                          passwordController.text,
                          nameController.text,
                          phoneNumberController.text,
                          emailController.text,
                          usertypeController.text,
                          batimentController.text,
                          coursController.text,
                        );
                        Navigator.of(context).pop(); 
                      },
                      child: const Text(
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
          backgroundColor: addButtonColor,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        bottomSheet: const SizedBox(height: 350,
        )
    );
  }
}