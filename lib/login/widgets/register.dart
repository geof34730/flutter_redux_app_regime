import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../_state/store.dart';

Widget register({required context, required formKey, required dynamic store}) {
  double widthContainer = MediaQuery.of(context).size.width * 0.8;

  int _value = 1;
  List<Map<String, String>> dummyList=[{"id":"1","subtitle":"ddd","title":'dddd'}];
  return StoreProvider<dynamic>(
      store: store,
      child:Form(
          key: formKey,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height-kToolbarHeight),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: AlignmentDirectional.center,
                            padding: const EdgeInsets.all(10),
                            width: widthContainer,
                            child: Text("Inscrivez-vous",
                                style: GoogleFonts.pacifico(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.00,
                                        height: 1.2)),
                                textAlign: TextAlign.center),
                          ),

                          Row(
                            children:[
                              Container(
                                alignment: AlignmentDirectional.topStart,
                                padding: const EdgeInsets.all(5),
                                width: 160.00,
                                child:ListTile(
                                    leading: const Icon(Icons.male),
                                    title: const Text("Homme"),
                                    onTap: () => print("ListTile")
                                )
                              ),
                              Container(
                                  alignment: AlignmentDirectional.topStart,
                                  padding: const EdgeInsets.all(5),
                                  width: 160.00,
                                  child:ListTile(
                                      leading: const Icon(Icons.female),
                                      title: const Text("Femme"),
                                      onTap: () => print("ListTile")
                                  )
                              ),
                            ]
                          ),

                          Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              padding: const EdgeInsets.all(10),
                              width: widthContainer,
                              child: TextFormField(
                                //controller: controllerEmailLogin..text = 'geoffrey.petain@gmail.com',
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: 'Nom',
                                  labelText: 'Nom',
                                ),
                                validator: (val) => val!='' ? "Merci de saisir votre nom" : null,
                              )
                          ),
                          Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              padding: const EdgeInsets.all(10),
                              width: widthContainer,
                              child: TextFormField(
                                //controller: controllerEmailLogin..text = 'geoffrey.petain@gmail.com',
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: 'Prénom',
                                  labelText: 'Prénom',
                                ),
                                validator: (val) => val!='' ? "Merci de saisir votre prénom" : null,
                              )
                          ),
                          Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              padding: const EdgeInsets.all(10),
                              width: widthContainer,
                              child: TextFormField(
                                //controller: controllerEmailLogin..text = 'geoffrey.petain@gmail.com',
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.person),
                                  hintText: 'Pseudonyme',
                                  labelText: 'Pseudonyme',
                                ),
                                validator: (val) => val!='' ? "Merci de saisir votre Pseudonyme" : null,
                              )
                          ),

                          Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              padding: const EdgeInsets.all(10),
                              width: widthContainer,
                              child: TextFormField(
                                //controller: controllerEmailLogin..text = 'geoffrey.petain@gmail.com',
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.straighten),
                                  hintText: 'Taille (en cm)',
                                  labelText: 'Taille (en cm)',
                                ),
                                validator: (val) => val!='' ? "Merci de saisir votre Taille (en cm)" : null,
                              )
                          ),
                          Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              padding: const EdgeInsets.all(10),
                              width: widthContainer,
                              child: TextFormField(
                                //controller: controllerEmailLogin..text = 'geoffrey.petain@gmail.com',
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.cake),
                                  hintText: 'Date de naissance',
                                  labelText: 'Date de naissance',
                                ),
                                validator: (val) => val!='' ? "Merci de saisir votre Date de naissance" : null,
                              )
                          ),
                          Container(
                              child: Column(children: [
                                Row(mainAxisSize: MainAxisSize.min, children: [
                                  ElevatedButton.icon(
                                    onPressed:(){},
                                    icon: const Icon(
                                      Icons.check,
                                      size: 19.0,
                                    ),
                                    label: const Text("VALIDER", style: TextStyle(fontSize: 19)),
                                  ),
                                ])
                              ]
                              )
                          ),
                          /*
                          Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              padding: const EdgeInsets.all(10),
                              width: widthContainer,
                              child: TextFormField(
                                //controller: controllerEmailLogin..text = 'geoffrey.petain@gmail.com',
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.key),
                                  hintText: 'Mot de passe',
                                  labelText: 'Mot de passe',
                                ),
                                validator: (val) => val!='' ? "Merci de saisir votre mot de passe" : null,
                              )
                          ),
                          Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              padding: const EdgeInsets.all(10),
                              width: widthContainer,
                              child: TextFormField(
                                //controller: controllerEmailLogin..text = 'geoffrey.petain@gmail.com',
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.key),
                                  hintText: 'Confirmation mot de passe',
                                  labelText: 'Confirmation mot de passe',
                                ),
                                validator: (val) => val!='' ? "Merci de confirmer votre pot de passe" : null,
                              )
                          ),
*/



                        ]))
              ])));
}

