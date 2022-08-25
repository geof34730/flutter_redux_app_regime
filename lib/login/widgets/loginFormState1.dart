import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validators/validators.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../_state/store.dart';
import '../../_services/login.dart';



Widget loginFormState1({required context, required formKey, required dynamic store}) {
  double widthContainer = MediaQuery.of(context).size.width * 0.8;
  final controllerEmailLogin = TextEditingController();
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
                                textStyle : const TextStyle(
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
                          constraints: const BoxConstraints(maxWidth: 600),
                          padding: const EdgeInsets.all(10),
                          width: widthContainer,
                          child: TextFormField(
                            controller: controllerEmailLogin,
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              hintText: 'Saisissez votre Email',
                              labelText: 'Email',
                            ),
                            validator: (val) => !isEmail(val!) ? "Merci de saisir un email valide" : null,
                          )),
                      Container(
                          child: Column(children: [
                            Row(mainAxisSize: MainAxisSize.min, children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Traitement en cours, veuillez patienter')),
                                    );
                                    Login().sendEmailLogin(email: controllerEmailLogin.text,store: store)
                                        .then((value) =>{
                                            print('SERVICE TERMINE')
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
                    ]))
          ]
      )
     )
  );
}