import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:convert';
import 'package:colored_json/colored_json.dart';

StoreProvider drawerWidget({required context, required dynamic store}) {
  return StoreProvider<dynamic>(
      store: store,
      child: StoreConnector<dynamic, dynamic>(
          converter: (store) => store,
          builder: (context, store) {
            dynamic myState=store.state;
            if(myState.user.imageprofil!=null) {
              myState.user.imageprofil=myState.user.imageprofil.substring(0, 50);
            }
            dynamic myStateJson=jsonEncode(myState);


            return Material(
              child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                SizedBox(
                  height: 75,
                   child: Container(
                      height:75.00,
                      decoration: const BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Row(
                        children: [
                          IconButton(
                            icon: const  Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                          ),
                           const Text(
                              'DEBUG TOOLS GEOFFREY',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                    ]),
                  ),
                ),
                SingleChildScrollView(
                    child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(20.00),
                  child: ColoredJson(
                    data:  '[$myStateJson]',
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
                )),
              ],
              ));
          }));
}
