import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../_services/login.dart';
import 'dart:async';


Widget accueil({required context, required dynamic store}) {
  double widthContainer = MediaQuery.of(context).size.width * 0.8;
  final controllerEmailLogin = TextEditingController();

  return StoreProvider<dynamic>(
      store: store,
      child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                  Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: AlignmentDirectional.center,
                            padding: const EdgeInsets.all(10),
                            width: widthContainer,
                            child: Text('Bienvenue dans votre espace Team Weight',
                                style: GoogleFonts.pacifico(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.00,
                                        height: 1.2)),
                                textAlign: TextAlign.center),
                          ),
                           Container(
                            alignment: AlignmentDirectional.center,
                            padding: const EdgeInsets.all(10),
                            width: widthContainer,
                            child:Wrap(
                              spacing: 15.0, // gap between adjacent chips
                              runSpacing: 15.0,
                              children: [
                              for(var item in store.state.user.usersFamily ) avatarProFil(
                                          pseudo: item.pseudo,
                                          imgBase64: item.imageprofil
                                    )
                              ],
                            )
                          ),
                        ]
                  )
              ]
          )
  );
  }

  Row avatarProFil({required String pseudo,required String imgBase64}){
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children:[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0,),
                  child: CircleAvatar(
                    radius: 50.00,
                    backgroundImage: Image
                        .memory(
                        base64.decode(imgBase64))
                        .image,
                  ),
                ),
                Text(pseudo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    )
                ),
            ]
          )
        ]
  );
}