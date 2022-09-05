import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../_services/login.dart';
import 'package:regime_redux_v2/_state/store_user.dart';
import '../../_state/store_connect.dart';
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
                                onChanged: (text) {
                                  print('First text field: $text');
                                },
                                keyboardType: TextInputType.text,
                                controller: controllerPasswordLogin..text,
                                obscureText: passwordEdit,
                                decoration: InputDecoration(
                                  labelText: 'Mot de passe',
                                  hintText: 'Saisissez votre mot de passe',
                                  icon: Icon(Icons.person),
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
                                      //store.dispatch(SetPasswordAction(controllerPasswordLogin.text)),
                                      //store.dispatch(SetEditPasswordAction())
                                    },
                                  ),
                                ),
                              ),

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
                                    print('success');
                                    setState((){disabledButtonSubmit=false;});
                                  },
                                  onFail: (){
                                    print('fail');
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

                                        Login().sendEmailPasswordLogin(password: controllerPasswordLogin.text, store: store, context: context);
                                        if (formKey.currentState!.validate()) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                                content: Text('Traitement en cours, veuillez patienter'),
                                                backgroundColor: Colors.green,
                                            ),
                                          );
                                         // store.dispatch(loginActions.State1);
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


/*
Widget widgetLoginFormState2({required context, required formKey, required dynamic store}) {
  double widthContainer = MediaQuery.of(context).size.width * 0.8;
  final controllerPasswordLogin = TextEditingController();
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
                        child: Text('Bienvenue, saisissez votre mot de de passe,',
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
                              onChanged: (text) {
                                print('First text field: $text');
                              },
                              keyboardType: TextInputType.text,
                              controller: controllerPasswordLogin..text = store.state.user.password,
                              obscureText: !store.state.user.passwordEdit,
                              decoration: InputDecoration(
                                labelText: 'Mot de passe',
                                hintText: 'Saisissez votre mot de passe',
                                icon: Icon(Icons.person),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    store.state.user.passwordEdit
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () => {
                                    store.dispatch(SetPasswordAction(controllerPasswordLogin.text)),
                                    store.dispatch(SetEditPasswordAction())
                                  },
                                ),
                              ),
                            ),

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
                              onSuccess: () => {
                                print('success'),
                               // store.dispatch(SetPasswordAction(controllerPasswordLogin.text)),
                               // store.dispatch(SetDisabledButtonSubmit(false))
                              },
                              onFail: () => {
                                print('fail'),
                              //  store.dispatch(SetPasswordAction(controllerPasswordLogin.text)),
                              //  store.dispatch(SetDisabledButtonSubmit(true)),
                              },
                          )
                      ),

                      Container(
                          child: Column(children: [
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              ElevatedButton.icon(
                                onPressed: (store.state.user.disabledSubmitForm
                                ?
                                null
                                :
                                 () {
                                  if (formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Traitement en cours, veuillez patienter')),
                                    );
                                    store.dispatch(loginActions.State1);
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
*/