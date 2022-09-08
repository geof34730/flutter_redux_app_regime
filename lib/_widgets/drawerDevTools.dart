import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'dart:convert';
import 'package:colored_json/colored_json.dart';

StoreProvider drawerWidget({required context, required dynamic store}) {
  return StoreProvider<dynamic>(
      store: store,
      child: StoreConnector<dynamic, dynamic>(
          converter: (store) => store.state,
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: 75,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.red,
                    ),
                    child: Row(children: [
                      IconButton(
                        icon: new Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          print('close drawer');
                          Scaffold.of(context).closeDrawer();
                        },
                      ),
                      Text(
                        'DEBUG TOOLS GEOFFREY  ',
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
                    data: '[' + jsonEncode(state.globalState) + ']',
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
            );
          }));
}
