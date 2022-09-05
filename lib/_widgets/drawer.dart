import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:convert';
import 'package:colored_json/colored_json.dart';


ListView drawerWidget({
  required context,
  required dynamic store
}){


  print("drawer 1");
  return  ListView(
    padding: EdgeInsets.zero,
    children:  <Widget>[
      const SizedBox(
        height: 75,
        child:DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.red,
          ),
          child: Text(
            'DEBUG TOOLS GEOFFREY',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
      ),

      StoreConnector<dynamic, dynamic>(
          converter: (store) => store.state.globalState,
          builder: (context, globalState) {
            print("drawer 2");
            return SingleChildScrollView(child:Container(
              color: Colors.black,
              padding: const EdgeInsets.all(20.00),
              child:ColoredJson(
                data: '['+jsonEncode(globalState)+']',
                indentLength: 10,
                keyColor: Colors.green,
                backgroundColor: Colors.black,
                boolColor: Colors.white,
                nullColor: Colors.redAccent,
                stringColor: Colors.cyan,
                curlyBracketColor: Colors.yellow,
                doubleColor: Colors.deepOrange,
                squareBracketColor: Colors.amber,
                commaColor: Colors.yellow,
                colonColor: Colors.purple,
                intColor: Colors.lime,
                textStyle: const TextStyle(
                  fontSize: 15,
                  letterSpacing: 2,
                ),
              ),
            ));
          }
      ),
    ],
  );
}