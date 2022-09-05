import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';

Widget appBarWidgets({required context, required dynamic store}) {
  return StoreProvider<dynamic>(
      store: store,
      child: StoreConnector<dynamic, dynamic>(
          converter: (store) => store.state,
          builder: (context, state) {
            if(state.loginState!="logged") {
              return AppBar(
                title: Text(
                  'TeamWeight',
                  style: GoogleFonts.pacifico(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      )),
                ),
              );
            }
            else{
              return AppBar(
                title: Text(
                  'TeamWeight',
                  style: GoogleFonts.pacifico(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      )),

                ),
                  actions: <Widget> [
                   /*
                    IconButton(
                        icon: const Icon(Icons.settings),
                        onPressed: () => {
                          print("Click on settings button")
                        }
                    ),
                    */

                    Padding(
                        padding: const  EdgeInsets.only(top:5.00,right:5.00),
                        child: PopupMenuButton(
                        child:CircleAvatar(
                              radius: 28,
                              backgroundImage: Image.memory(base64.decode(state.user.imageprofil)).image,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                value: 0,
                                child: Row(
                                  children:[
                                    CircleAvatar(
                                      radius: 15,
                                      backgroundImage: Image.memory(base64.decode(state.user.imageprofil)).image,
                                    ),
                                    const Padding(
                                        padding: const  EdgeInsets.only(left:5.00),
                                        child:Text("Geoffrey"),
                                    )
                                  ]
                                )
                              ),
                              PopupMenuItem<int>(
                                  value: 1,
                                  child: Row(
                                      children:[
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundImage: Image.memory(base64.decode(state.user.imageprofil)).image,
                                        ),
                                        const Padding(
                                          padding: const  EdgeInsets.only(left:5.00),
                                          child:Text("Geoffrey"),
                                        )
                                      ]
                                  )
                              ),
                          ],
                            onSelected:(value){
                              if(value == 0){
                                print("My account menu is selected 1.");
                              }else if(value == 1){
                                print("Settings menu is selected 2.");
                              }
                            }
                        ),
                    ),
                  ]
              );
            }
          }));
}


