import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../_state/store.dart';
import 'package:validators/validators.dart';
import 'widgets/loginFormState1.dart';
import 'widgets/loginFormState2.dart';


class LoginPage extends StatelessWidget {
  final Store<dynamic> store;

  LoginPage({
    required this.store,
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StoreProvider<dynamic>(
        store: store,
        child:Scaffold(
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
          child: StoreConnector<dynamic, int>(
            converter: (store) => store.state.loginState,
            builder: (context, loginState) {
              print(loginState);
              if(loginState==1){
                  return loginFormState1(context: context, formKey: _formKey,store:store);
              }
              else{
                  return loginFormState2(context: context, formKey: _formKey,store:store);
              }
            },
          ),
        ))
    );
  }

}
