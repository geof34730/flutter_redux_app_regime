import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../_state/store.dart';
import 'package:validators/validators.dart';
import 'widgets/loginFormState1.dart';
import 'widgets/loginFormState2.dart';
import 'widgets/register.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:colored_json/colored_json.dart';

class LoginPage extends StatelessWidget {
  final Store<dynamic> store;

  LoginPage({
    required this.store,
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final dartMap = {
    "id": 24,
    "name": "Manthan Khandale",
    "score": 7.6,
    "socials": null,
    "hobbies": [
      "Music",
      "Filmmaking",
    ],
    "isFlutterCool": true,
  };
  @override
  Widget build(BuildContext context) {
    return StoreProvider<dynamic>(
        store: store,
        child:Scaffold(
        drawer:  ListView(
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

                return Container(
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
                );
              }
              ),
          ],
        ),



        appBar: AppBar(
          title: Text(
            "Team Weight",
            style: GoogleFonts.pacifico(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 30.00,
                )),
          ),
        ),
        body: SingleChildScrollView(
          child: StoreConnector<dynamic, dynamic>(
            converter: (store) => store.state.loginState,
            builder: (context, loginState) {
              if(loginState=="email"){
                  return loginFormState1(context: context, formKey: _formKey,store:store);
              }
              else{
                if(loginState=="password") {
                  return loginFormState2(context: context, formKey: _formKey, store: store);
                }
                else{
                  return register(context: context, formKey: _formKey, store: store);
                }
              }
            },
          ),
        ))
    );
  }

}

