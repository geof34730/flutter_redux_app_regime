import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../_class/loader.dart';
import '../../_services/login.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class loginFormState2 extends StatefulWidget {
  final dynamic store;
  final dynamic formKey;
   loginFormState2({Key? key,required context, required this.formKey, required this.store}) : super(key: key);
    @override
   _loginFormState2 createState() => _loginFormState2();

}

class _loginFormState2 extends State<loginFormState2> {
  bool passwordEdit = true;
  bool disabledButtonSubmit = true;
  String messageErrorPassword = '';

  @override
  void initState() {
    dynamic store = widget.store;
    dynamic formKey = widget.formKey;
    super.initState();
  }

  final controllerPasswordLogin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic store = widget.store;
    dynamic formKey = widget.formKey;
    double widthContainer = MediaQuery.of(context).size.width * 0.8;
    return StoreProvider<dynamic>(
        store: store,
        child: Form(
            key: formKey,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery
                              .of(context)
                              .size
                              .height - kToolbarHeight),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: AlignmentDirectional.center,
                              padding: const EdgeInsets.all(10),
                              width: widthContainer,
                              child: Text(
                                  'Bienvenue, saisissez votre mot de passe,',
                                  style: GoogleFonts.pacifico(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 30.00,
                                          height: 1.2
                                      )
                                  ),
                                  textAlign: TextAlign.center),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              padding: const EdgeInsets.all(10),
                              width: widthContainer,
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: controllerPasswordLogin..text,
                                obscureText: passwordEdit,
                                decoration: InputDecoration(
                                  labelText: 'Mot de passe',
                                  hintText: 'Saisissez votre mot de passe',
                                  //icon: Icon(Icons.key),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      passwordEdit
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Theme
                                          .of(context)
                                          .primaryColorDark,
                                    ),
                                    onPressed: () {
                                      passwordEdit = !passwordEdit;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ),
                            (messageErrorPassword != ''
                                ?
                            Container(
                                constraints: const BoxConstraints(maxWidth: 600),
                                padding: const EdgeInsets.all(10),
                                width: widthContainer,
                                child: Text(
                                  messageErrorPassword,
                                  style: const TextStyle(
                                      height: 0.3,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                )
                            )
                                :
                            SizedBox()
                            ),
                            Container(
                                constraints: const BoxConstraints(maxWidth: 600),
                                padding: const EdgeInsets.all(10),
                                width: widthContainer,
                                child: FlutterPwValidator(
                                  controller: controllerPasswordLogin,
                                  minLength: 6,
                                  uppercaseCharCount: 1,
                                  numericCharCount: 3,
                                  specialCharCount: 1,
                                  width: 400,
                                  height: 110,
                                  onSuccess: () {
                                    setState(() {
                                      disabledButtonSubmit = false;
                                    });
                                  },
                                  onFail: () {
                                    setState(() {
                                      disabledButtonSubmit = true;
                                    });
                                  },
                                )
                            ),

                            Container(
                                child: Column(children: [
                                  Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed:
                                          (disabledButtonSubmit
                                              ?
                                              null
                                              :
                                              () {
                                                  if (formKey.currentState!.validate()) {
                                                    Loader(context: context,snackBar: true).showLoader();
                                                    Login().sendEmailPasswordLogin(password: controllerPasswordLogin.text,store: store,context: context).then((value) =>
                                                        {
                                                        if(value['statut'] == "error"){
                                                          Loader(context: context,snackBar: true).hideLoader(),
                                                            setState(() {
                                                              messageErrorPassword =
                                                              value['messageError']!;
                                                            }
                                                            )
                                                        }
                                                        else{
                                                          Loader(context: context,snackBar: true).hideLoader(),
                                                          }
                                                        });
                                                  }
                                                }
                                          ),
                                          icon: const Icon(
                                            Icons.check,
                                            size: 19.0,
                                          ),
                                          label: const Text(
                                              "VALIDER",
                                              style: TextStyle(fontSize: 19)
                                          ),
                                        ),
                                      ])
                                ])),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              padding: const EdgeInsets.all(10),
                              width: widthContainer,
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                                ),
                                onPressed: () {
                                  Login().sendEmailForgetPassword(email: store.state.user.email,store: store).then((value) {
                                        return _displayTextInputDialog(
                                          context: context,
                                          email: store.state.user.email,
                                          timerEnd: value["timeCodeValidate"]
                                        );
                                      });
                                },
                                child: const Text(
                                  "Mode de passe oublié ?",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ),
                            ),
                          ]))
                ])));
  }

  Future<void> _displayTextInputDialog({required BuildContext context,required String email,required int timerEnd}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: Text(
                'Saisissez le code à 6 chiffres que nous vous avons envoyé sur ${email}.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16.0)),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  autofocus: true,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 36.0),
                                  ),
                                ),
                              )),
                          SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 36.0),
                                  ),
                                ),
                              )),
                          SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 36.0),
                                  ),
                                ),
                              )),
                          SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 36.0),
                                  ),
                                ),
                              )),
                          SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 36.0),
                                  ),
                                ),
                              )),
                          SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    contentPadding:
                                    EdgeInsets.symmetric(vertical: 36.0),
                                  ),
                                ),
                              )),
                        ]),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Temps restants pour saisir votre code:",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 12.0
                                    ),
                                    softWrap: true,
                                  ),
                                  CountdownTimer(
                                    //endTime:endTime,
                                      endTime: timerEnd,
                                      textStyle: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold
                                      ),
                                      onEnd: () {
                                        Navigator.pop(context, true);
                                      },
                                      endWidget: const Center(
                                          child: Text('Terminé',
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                  FontWeight.bold
                                              )
                                          )
                                      )
                                  ),
                                ]
                            )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

}