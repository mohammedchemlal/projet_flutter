import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_1/api_connection/api_connection.dart';
import 'package:flutter_1/prof/profil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_1/globals.dart' as globals;
import '../models/users.dart';
String newName="";
const String errorMessage="";
String usernam=globals.globalDataA;
//vert: 0xFF0D8F4E   //bleu: 0xFF2755CE  //rouge: 0xFFC62B20
void main() {
  runApp(const MyApp());
}
Color drawerHeaderColor = const Color(0xFFC62B20);
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Navigation Example',
      routes: {
      },
      home: infosBasiquesAdmin(),
    );
  }
}
TextEditingController name = TextEditingController();
TextEditingController username = TextEditingController();
TextEditingController password = TextEditingController();
TextEditingController newPassword = TextEditingController();
TextEditingController newPassword2 = TextEditingController();

class infosBasiquesAdmin extends StatelessWidget {
  const infosBasiquesAdmin({Key? key}) : super(key: key);


  Future<void> validateName() async {
    String newName = name.text;
    if (newName.isNotEmpty) {
      try {
        var response = await http.post(
          Uri.parse('http://10.0.2.2/api_flutter_1/validate/validatename.php'),
          body: {
            "name": newName,
            "username": usernam,
          },
        );

        if (response.statusCode == 200) {
          // Handle successful response
          name.text="";
        } else {
          // Log the specific error code and reason
          print("HTTP request failed with status: ${response.statusCode}, ${response.reasonPhrase}");
        }
      } catch (e) {
        // Log the exception details
        print("Error: $e");
      }

    } else {
      // The TextField is empty
      print("Please enter a name");
    }
  }
  Future<void> validateUsername() async {
    String newUsername = username.text;
    if (newUsername.isNotEmpty) {
      try {
        var response = await http.post(
          Uri.parse('http://10.0.2.2/api_flutter_1/validate/validateusername.php'),
          body: {
            "username": newUsername,
            "currentUsername": usernam,
            // Other parameters you might need to send
          },
        );
        if (response.statusCode == 200) {
          // Handle successful response
          username.text="";
        } else {
          // Log the specific error code and reason
          print("HTTP request failed with status: ${response.statusCode}, ${response.reasonPhrase}");
        }
      } catch (e) {
        // Log the exception details
        print("Error: $e");
      }
    } else {
      // The TextField is empty
      print("Please enter a name");
    }
  }
  Future<void> validatePassword() async {
    String pass = newPassword.text;
    if (pass.isNotEmpty) {
      try {
        var response = await http.post(
          Uri.parse('http://10.0.2.2/api_flutter_1/validate/validatepassword.php'),
          body: {
            "currentUsername":usernam,
            "password": pass
          },
        );
        if (response.statusCode == 200 ) {
          newPassword.text="";
          print("yes");
        } else {
          // Log the specific error code and reason
          print("HTTP request failed with status: ${response.statusCode}, ${response.reasonPhrase}");
        }
      } catch (e) {
        // Log the exception details
        print("Error: $e");
      }

    } else {
      // The TextField is empty
      print("Please enter a name");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(39.0), // Adjust the height as needed
        child: AppBar(
          backgroundColor: drawerHeaderColor,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'INFOS BASIQUES',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          titleSpacing: 95,
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 30,left: 10,right: 60, bottom: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                leading:Image.asset("assets/admin/edit.png"),
                title:Text('Modifications des informations basiques du compte', style: TextStyle(fontWeight: FontWeight.bold, color: drawerHeaderColor, fontSize: 16),
                ),),
              const Padding(
                padding: EdgeInsets.only(bottom: 30.0),),
              const Align(
                alignment: Alignment.centerLeft,
                child:
                Text(
                  'Veuillez saisir un nouveau nom:',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                ),
              ),
              SizedBox(
                height: 30,
                child: TextField(
                  controller: name,
                  onChanged: (value) {
                    // Update the newName variable whenever the text changes
                    newName = value;
                  },
                  cursorColor: drawerHeaderColor,
                  decoration: InputDecoration(
                    hintText: 'Nom complet',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: -5.0),
                    focusedBorder:OutlineInputBorder(
                        borderRadius: const BorderRadius.only(),
                        borderSide: BorderSide(
                          color: drawerHeaderColor,
                        )
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderRadius: const BorderRadius.only(),
                      borderSide: BorderSide(
                        color: drawerHeaderColor,
                      ),),
                  ),),),
              const SizedBox(height: 7),
              Align(
                alignment: Alignment.centerRight,
                child:
                ElevatedButton(
                  onPressed: () async {
                    String n = name.text;
                    RegExp reg_ex=RegExp(r'^[A-Za-z]+(?: [A-Za-z]+)+$');
                    if(n.isNotEmpty) {
                      if (reg_ex.hasMatch(n)) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Message de confirmation',
                                style: TextStyle(color: drawerHeaderColor),),
                              content: Text(
                                  'Voulez-vous vraiment modifier votre nom?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Non',
                                    style: TextStyle(color: drawerHeaderColor),),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    validateName();
                                    username.clear();
                                    Fluttertoast.showToast(msg: "Votre nom a été modifié avec succés");
                                  },
                                  child: Text(
                                    'Oui',
                                    style: TextStyle(color: drawerHeaderColor),),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      else{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Erreur',
                                style: TextStyle(color: drawerHeaderColor),),
                              content: Text(
                                  'Veuillez respecter la syntaxe(NOM Prenom)!'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Veuillez remplir tous les champs'),
                          duration: Duration(seconds: 3),
                        ),);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: drawerHeaderColor, // Text color
                    padding: const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Button border radius
                    ),
                  ),
                  child: const Text(
                    'Valider',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),),
              const Align(
                alignment: Alignment.centerLeft,
                child:
                Text(
                  'Veuillez saisir un nouveau nom d’utilisateur:',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                ),
              ),
              SizedBox(
                height: 30,
                child: TextField(
                  controller: username,
                  cursorColor: drawerHeaderColor,
                  decoration: InputDecoration(
                    hintText: 'Nom d’utilisateur',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: -5.0),
                    focusedBorder:OutlineInputBorder(
                        borderRadius: const BorderRadius.only(),
                        borderSide: BorderSide(
                          color: drawerHeaderColor,
                        )
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderRadius: const BorderRadius.only(),
                      borderSide: BorderSide(
                        color: drawerHeaderColor,
                      ),),
                  ),),),
              const SizedBox(height: 7),
              Align(
                alignment: Alignment.centerRight,
                child:
                ElevatedButton(
                  onPressed: () async {
                    String user = username.text;
                    if(user.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Message de confirmation',
                              style: TextStyle(color: drawerHeaderColor),),
                            content: Text(
                                'Voulez-vous vraiment modifier votre nom dutilisateur?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Non',
                                  style: TextStyle(color: drawerHeaderColor),),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  validateUsername();
                                  username.clear();
                                  Fluttertoast.showToast(msg: "Votre nom d'utilisateur a été modifié avec succés");
                                },
                                child: Text(
                                  'Oui',
                                  style: TextStyle(color: drawerHeaderColor),),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    else{
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
                    padding: const EdgeInsets.only(top: 0,left:0,right: 0, bottom: 0), // Button padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Button border radius
                    ),),
                  child: const Text('Valider',textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
                    ,
                  ),
                ),),

              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child:
                Text(
                  'Veuillez saisir un nouveau mot de passe:(5 caractères au minimum)',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                ),
              ),
              SizedBox(
                height: 30,
                child: TextField(
                  controller: newPassword,
                  cursorColor: drawerHeaderColor,
                  decoration: InputDecoration(
                    hintText: 'Nouveau mot de passe',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: -5.0),
                    focusedBorder:OutlineInputBorder(
                        borderRadius: const BorderRadius.only(),
                        borderSide: BorderSide(
                          color: drawerHeaderColor,
                        )
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderRadius: const BorderRadius.only(),
                      borderSide: BorderSide(
                        color: drawerHeaderColor,
                      ),),
                  ),),),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child:
                Text(
                  'Veuillez confirmer le nouveau mot de passe:',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                ),
              ),
              SizedBox(
                height: 30,
                child: TextField(
                  controller: newPassword2,
                  cursorColor: drawerHeaderColor,
                  decoration: InputDecoration(
                    hintText: 'Nouveau mot de passe',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: -5.0),
                    focusedBorder:OutlineInputBorder(
                        borderRadius: const BorderRadius.only(),
                        borderSide: BorderSide(
                          color: drawerHeaderColor,
                        )
                    ),
                    enabledBorder:OutlineInputBorder(
                      borderRadius: const BorderRadius.only(),
                      borderSide: BorderSide(
                        color: drawerHeaderColor,
                      ),),
                  ),),),
              const SizedBox(height: 7),
              Align(
                alignment: Alignment.centerRight,
                child:
                ElevatedButton(
                  onPressed: () async {
                    RegExp passwordRegex = RegExp(r'^(?=.*[^\w\s]).{5,}$');
                    String newP = newPassword.text;
                    String newP2=newPassword2.text;
                    if(newP.isNotEmpty && newP2.isNotEmpty) {
                      if(passwordRegex.hasMatch(newP)) {
                        if (newP == newP2) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Message de confirmation',
                                  style: TextStyle(color: drawerHeaderColor),),
                                content: Text(
                                    'Voulez-vous vraiment modifier votre mot de passe?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      'Non',
                                      style: TextStyle(color: drawerHeaderColor),),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      validatePassword();
                                      newPassword.clear();
                                      newPassword2.clear();
                                      Fluttertoast.showToast(msg: "Votre mot de passe a été modifié avec succés");
                                    },
                                    child: Text(
                                      'Oui',
                                      style: TextStyle(color: drawerHeaderColor),),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Erreur',
                                  style: TextStyle(color: drawerHeaderColor),),
                                content: Text(
                                    'Les mots de passe ne sont pas identiques'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                      else{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Erreur',
                                style: TextStyle(color: drawerHeaderColor),),
                              content: Text(
                                  'Veuillez ajouter un caractère spécial à votre mot de passe ou vérifiez si votre mot de passe contient  caractéres'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Veuillez remplir tous les champs'),
                          duration: Duration(seconds: 3),
                        ),);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: drawerHeaderColor, 
                    padding: const EdgeInsets.only(top: 0,left:0,right: 0, bottom: 0), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), 
                    ),),
                  child: const Text('Valider',textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)
                    ,
                  ),
                ),),
            ],
          ),

        ),),
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