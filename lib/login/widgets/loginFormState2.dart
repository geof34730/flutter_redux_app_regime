import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../_class/loader.dart';
import '../../_services/login.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';


class loginFormState2 extends StatefulWidget {
  final dynamic store;
  final dynamic formKey;
   loginFormState2({Key? key,required context, required this.formKey, required this.store}) : super(key: key);
    @override
   _loginFormState2 createState() => _loginFormState2();

}

class _loginFormState2 extends State<loginFormState2>{
  bool passwordEdit=true;
  bool disabledButtonSubmit = true;
  String messageErrorPassword ='';

  @override
  void initState() {
    dynamic store = widget.store;
    dynamic formKey = widget.formKey;
    super.initState();
  }
  final controllerPasswordLogin = TextEditingController();
  @override
  Widget build(BuildContext context) {
    dynamic store=widget.store;
    dynamic formKey=widget.formKey;
    double widthContainer = MediaQuery.of(context).size.width * 0.8;

    // TODO: implement build
    return StoreProvider<dynamic>(
        store: store,
        child:Form(
            key: formKey,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height-kToolbarHeight),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: AlignmentDirectional.center,
                              padding: const EdgeInsets.all(10),
                              width: widthContainer,
                              child: Text('Bienvenue, saisissez votre mot de passe,',
                                  style: GoogleFonts.pacifico(
                                      textStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 30.00,
                                          height: 1.2)),
                                  textAlign: TextAlign.center),
                            ),
                            Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              padding: const EdgeInsets.all(10),
                              width: widthContainer,
                              child:TextFormField(
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
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      passwordEdit=!passwordEdit;
                                      setState(() { });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            (messageErrorPassword!=''
                            ?
                            Container(
                                constraints: const BoxConstraints(maxWidth: 600),
                                padding: const EdgeInsets.all(10),
                                width: widthContainer,
                                child:Text(
                                  messageErrorPassword,
                                  style: const TextStyle(
                                    height:0.3,
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
                                  height: 150,
                                  onSuccess: ()  {
                                    setState((){disabledButtonSubmit=false;});
                                  },
                                  onFail: (){
                                    setState((){disabledButtonSubmit=true;});
                                  },
                                )
                            ),

                            Container(
                                child: Column(children: [
                                  Row(mainAxisSize: MainAxisSize.min, children: [
                                    ElevatedButton.icon(
                                      onPressed: (disabledButtonSubmit
                                          ?
                                          null
                                          :
                                          () {
                                          if (formKey.currentState!.validate()) {
                                            Loader(context: context,snackBar: true).showLoader();
                                            Login().sendEmailPasswordLogin(password: controllerPasswordLogin.text, store: store, context: context).then((value) =>
                                              {
                                              if(value['statut']=="error"){
                                                Loader(context: context,snackBar: true).hideLoader(),
                                                setState((){
                                                  messageErrorPassword=value['messageError']!;
                                                })
                                              }
                                            });
                                          }
                                      }
                                      ),
                                      icon: const Icon(
                                        Icons.check,
                                        size: 19.0,
                                      ),
                                      label: const Text("VALIDER",
                                          style: TextStyle(fontSize: 19)),
                                    ),
                                  ])
                                ]))
                          ]))
                ])));

  }
}
