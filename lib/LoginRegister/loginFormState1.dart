import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:regime_redux_v2/_class/loader.dart';
import 'package:validators/validators.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../_services/login.dart';
import 'dart:async';
class loginFormState1 extends StatefulWidget {
  final dynamic store;
  final dynamic context;

  loginFormState1({Key? key,required this.context,  required this.store}) : super(key: key);
  @override
  _loginFormState1 createState() => _loginFormState1();

}

class _loginFormState1 extends State<loginFormState1>{
  bool passwordEdit=true;
  bool disabledButtonSubmit = true;

  @override
  void initState() {
    dynamic store = widget.store;
    dynamic context = widget.context;
    super.initState();
  }
  final _formLoginState1 = GlobalKey<FormState>();
  final  TextEditingController  controllerEmailLogin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double widthContainer = MediaQuery
        .of(context)
        .size
        .width * 0.8;
    controllerEmailLogin.text = 'geoffrey.petain@gmail.com';

    dynamic store=widget.store;
    return StoreProvider<dynamic>(
        store: store,
        child: Form(
            key: _formLoginState1,
            child: Row(
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
                              child: Text('Bienvenue sur Team Weight,',
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
                              child: Text(
                                  'L\'application qui vous permet de suivre le poids de votre Teams, votre famille et de suivre sont évolution.',
                                  maxLines: 10,
                                  softWrap: true,
                                  style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.00,
                                      )),
                                  textAlign: TextAlign.center),
                            ),
                            Container(
                              alignment: AlignmentDirectional.center,
                              padding: const EdgeInsets.all(10),
                              width: widthContainer,
                              child: Text(
                                  'Merci de saisir votre email pour vous identifier ou pour vous inscrire.',
                                  style: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.00,
                                      )),
                                  textAlign: TextAlign.center),
                            ),
                            Container(
                                constraints: const BoxConstraints(
                                    maxWidth: 600),
                                padding: const EdgeInsets.all(10),
                                width: widthContainer,
                                child: TextFormField(
                                  controller: controllerEmailLogin,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.person),
                                    hintText: 'Saisissez votre Email',
                                    labelText: 'Email',
                                  ),
                                  validator: (val) =>
                                  !isEmail(val!)
                                      ? "Merci de saisir un email valide"
                                      : null,
                                )),
                            Container(
                                child: Column(children: [
                                  Row(mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            if (_formLoginState1.currentState!.validate()) {
                                                Loader(context: context,snackBar: true).showLoader();
                                                ServiceLogin().sendEmailLogin(email: controllerEmailLogin.text, store: store).then((value) =>{
                                                    Loader(context: context,snackBar: true).hideLoader()
                                                }
                                              );
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.check,
                                            size: 19.0,
                                          ),
                                          label: const Text("VALIDER",
                                              style: TextStyle(fontSize: 19)),
                                        ),
                                      ])
                                ]))
                          ])
                ]
            )
        )
    );
  }
}