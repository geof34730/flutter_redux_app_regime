import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:core';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../_state/store_user.dart';
import '../_state/store_connect.dart';
import '../_models/user.dart';


class poidsView extends StatefulWidget {
  final dynamic store;
   poidsView({Key? key,required context, required this.store}) : super(key: key);
    @override
   _poidsView createState() => _poidsView();

}
class _poidsView extends State<poidsView> {
  bool modifyProfile=false;
  final controllerEmailLogin = TextEditingController();
  @override
  void initState() {
    dynamic store = widget.store;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      dynamic store = widget.store;
      double widthContainer = MediaQuery.of(context).size.width * 0.8;
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text('viewPoids')
                          ]
                      ),
                    ]
                ),
              ]
          );
    }
}


