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
                            child: Text('Accueil user',
                                style: GoogleFonts.pacifico(
                                    textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 30.00,
                                        height: 1.2)),
                                textAlign: TextAlign.center),
                          ),
                        ]
                  )
              ]
          )

  );
}