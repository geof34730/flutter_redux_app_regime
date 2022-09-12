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
                actions: const[
                  SizedBox(),
                ],
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
                    Padding(
                        padding: const  EdgeInsets.only(top:5.00,right:5.00),
                        //child: PopupMenuButton(
                        child:InkWell(
                          onTap: (){
                              Scaffold.of(context).openEndDrawer();
                          },
                          child:CircleAvatar(
                              radius: 28,
                              backgroundImage: Image.memory(base64.decode(state.user.imageprofil)).image,
                              child: Stack(
                                children: const  [
                                 Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(
                                        Icons.arrow_drop_down_outlined,
                                        size:18.0
                                    ),
                                  )
                                ],
                              ),
                            ),
                        )
                       // ),
                    ),
                  ]
              );
            }
          }));
}


