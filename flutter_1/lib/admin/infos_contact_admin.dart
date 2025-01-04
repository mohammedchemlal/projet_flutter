import 'package:flutter/material.dart';
import 'package:flutter_1/prof/profil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_1/globals.dart' as globals;
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
      home: infosContactAdmin(),
    );
  }
}
String usernam=globals.globalDataA;
TextEditingController mail = TextEditingController();
TextEditingController phone = TextEditingController();
class infosContactAdmin extends StatelessWidget {
  const infosContactAdmin({Key? key}) : super(key: key);
  Future<void> validateEmail() async {
    String newMail = mail.text;

    if (newMail.isNotEmpty) {
      try {
        var response = await http.post(
          Uri.parse('http://10.0.2.2/api_flutter_1/validate/validateEmail.php'),
          body: {
            "email": newMail,
            "currentUsername":usernam,
          },
        );

        if (response.statusCode == 200) {
        
          mail.text="";
        } else {
          
          print("HTTP request failed with status: ${response.statusCode}, ${response.reasonPhrase}");
        }
      } catch (e) {
       
        print("Error: $e");
      }

    } else {
  
      print("Please enter a name");
    }
  }
  Future<void> validatePhone() async {
    String phoneNumber = phone.text;

    if (phoneNumber.isNotEmpty) {
      try {
        var response = await http.post(
          Uri.parse('http://10.0.2.2/api_flutter_1/validate/validatePhone.php'),
          body: {
            "phoneNumber": phoneNumber,
            "currentUsername":usernam,
          },
        );

        if (response.statusCode == 200) {
          phone.text="";
        } else {
          print("HTTP request failed with status: ${response.statusCode}, ${response.reasonPhrase}");
        }
      } catch (e) {
        print("Error: $e");
      }

    } else {
      print("Please enter a name");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(39.0), 
        child: AppBar(
          backgroundColor: drawerHeaderColor,
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'INFOS DE CONTACT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          titleSpacing: 30,
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
                title:Text('Modification des informations de contact', style: TextStyle(fontWeight: FontWeight.bold, color: drawerHeaderColor, fontSize: 16),
                ),),
              const Padding(
                padding: EdgeInsets.only(bottom: 30.0),),
              const SizedBox(height: 50,),
              const Align(
                alignment: Alignment.centerLeft,
                child:
                Text(
                  'Veuillez saisir un nouveau numéro de téléphone:',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                ),
              ),
              SizedBox(
                height: 30,
                child: TextField(
                  controller: phone,
                  cursorColor: drawerHeaderColor,
                  decoration: InputDecoration(
                    hintText: 'Numéro de téléphone',
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
                    String phoneNumber = phone.text;
                    RegExp r = RegExp(r'^(06|07)\d{8}$');
                    if (phoneNumber.isNotEmpty) {
                      if(r.hasMatch(phoneNumber)) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Message de confirmation',
                                style: TextStyle(color: drawerHeaderColor),),
                              content: Text(
                                  'Voulez-vous vraiment modifier votre numéro de téléphone?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Non',
                                    style: TextStyle(
                                        color: drawerHeaderColor),),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    validatePhone();
                                    phone.clear();
                                    Fluttertoast.showToast(msg: "Votre numéro de téléphone a été modifié avec succés!");
                                  },
                                  child: Text(
                                    'Oui',
                                    style: TextStyle(
                                        color: drawerHeaderColor),),
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
                                    'Veuillez respecter la syntaxe dun numéro de téléphone'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            }
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
              const SizedBox(height: 40,),
              const Align(
                alignment: Alignment.centerLeft,
                child:
                Text(
                  'Veuillez saisir une nouvelle adresse e-mail',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                ),
              ),
              SizedBox(
                height: 30,
                child: TextField(
                  controller: mail,
                  cursorColor: drawerHeaderColor,
                  decoration: InputDecoration(
                    hintText: 'Adresse e-mail',
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
                    String email = mail.text;
                    RegExp r = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if(email.isNotEmpty) {
                      if(r.hasMatch(email)){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Message de confirmation',
                                style: TextStyle(color: drawerHeaderColor),),
                              content: Text(
                                  'Voulez-vous vraiment modifier votre addresse email?'),
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
                                    validateEmail();
                                    mail.clear();
                                    Fluttertoast.showToast(msg: "Votre adresse e-mail a été modifiée avec succés!");
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
                                    'Veuillez respecter la syntaxe dun email'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            }
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
