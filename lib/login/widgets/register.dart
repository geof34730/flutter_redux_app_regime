import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regime_redux_v2/_models/user.dart';
import 'package:validators/validators.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../_state/store.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';
import '../../_state/store_connect.dart';

import '../../_state/store_user.dart';
class register extends StatefulWidget {
  final dynamic store;
  register({Key? key,required context,  required this.store}) : super(key: key);
  @override
  _register createState() => _register();
}

class _register extends State<register> {


  @override
  void initState() {
    dynamic store = widget.store;
    super.initState();
  }
  String valueRadio = '';
  bool errorGenre=false;
  int registerState=1;
  final _formRegister = GlobalKey<FormState>();
  TextEditingController  controllerRegisterSize = TextEditingController();
  TextEditingController controllerRegisterDateBirth = TextEditingController();
  TextEditingController controllerRegisterPseudo= TextEditingController();
  TextEditingController controllerRegisterFirstName= TextEditingController();
  TextEditingController controllerRegisterLasttName= TextEditingController();

  @override
  Widget build(BuildContext context) {
    double widthContainer = MediaQuery.of(context).size.width * 0.8;
    dynamic store = widget.store;
    return StoreProvider<dynamic>(
        store: store,
        child: Form(
            key: _formRegister,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                    Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContenaireFormRegister(
                                widthContainer: widthContainer,
                                content: Text("Inscrivez-vous",
                                    style: GoogleFonts.pacifico(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 30.00,
                                            height: 1.2)),
                                    textAlign: TextAlign.center)
                            ),
                            ContenaireFormRegister(
                                widthContainer: widthContainer,
                                content: Text("Etape $registerState/3",
                                    style:const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.00,
                                            height: 0.1),
                                    textAlign: TextAlign.center)
                            ),
                          StoreConnector<dynamic, dynamic>(
                                      converter: (store) => store.state.loginState,
                                         builder: (context, loginState) {
                                         print("loginState");
                                        print(loginState);
                                           switch (loginState) {
                                             case "register1":
                                                return formRegisterState1(widthContainer: widthContainer);
                                             case "register2":
                                                return formRegisterState2(widthContainer: widthContainer);
                                             case "register3":
                                                return formRegisterState3(widthContainer: widthContainer);
                                             default:
                                                return formRegisterState1(widthContainer: widthContainer);
                                           }
                                         }
                          ),
                          Container(
                                constraints: const BoxConstraints(minWidth: 300, maxWidth: 600),
                                padding: const EdgeInsets.all(10),
                                width: widthContainer,
                                child: Column(children: [
                                  Row(mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            errorGenre=(valueRadio=='');
                                            if (_formRegister.currentState!.validate() && valueRadio!='' ) {
                                              if(registerState==1) {
                                                store.dispatch(
                                                    SetRegisterState1(
                                                        user: Userdata(
                                                            uuid: null,
                                                            pseudo: controllerRegisterPseudo.text,
                                                            firstname: controllerRegisterFirstName.text,
                                                            lastname: controllerRegisterLasttName.text,
                                                            email: store.state.user.email,
                                                            profil: "familyadmin",
                                                            datenaissance: controllerRegisterDateBirth.text,
                                                            sexe: valueRadio,
                                                            taille: 186,
                                                            imageprofil: null,
                                                            uuidfamillyadmin: "uuidfamillyadmin",
                                                            token: null
                                                        )
                                                    ));
                                                    store.dispatch(loginActions.Register2);
                                                    setState(() {
                                                      registerState=2;
                                                    });
                                              }
                                              if(registerState==2) {
                                                print("go register 2" +controllerRegisterDateBirth.text);
                                                store.dispatch(loginActions.Register3);
                                                  setState(() {
                                                  registerState=3;
                                                });
                                              }
                                               if(registerState==3) {
                                                  print("terminé");
                                                }
                                            }
                                            else{
                                              setState(() {

                                              });
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
                                ]
                                )
                            ),
                          ])
                ])));
      }

  Row RadioButton({required String value,required String libelRadio,required BuildContext context, required String valueRadioWidget,}){
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
            fillColor: (errorGenre ? MaterialStateProperty.all(Colors.red) : MaterialStateProperty.all(Color(0xFF455A64))),
            value: value,
            groupValue: valueRadioWidget,
            onChanged: (val) {
              setState(() {valueRadio = val.toString();errorGenre=false;});
            },
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Text(
              libelRadio,
              style:  TextStyle(
                  color: (errorGenre ? Colors.red :Color(0xFF455A64)),
                  fontWeight: FontWeight.normal
              ),
            ),
            onPressed: () {
              setState(() {valueRadio = value;errorGenre=false;});
            },
          ),
        ]);

  }

  Widget ContenaireFormRegister({required double widthContainer, required Widget content}){
    return Container(
        constraints: const BoxConstraints(minWidth: 300,maxWidth: 600),
        padding: const EdgeInsets.all(10),
        width: widthContainer,
        child: content
    );
  }

  Widget formRegisterState1({required double widthContainer}){
    return Column(
        children:[
          ContenaireFormRegister(
          widthContainer: widthContainer,
          content:Padding(
              padding: EdgeInsets.only(left:40.0),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      RadioButton(value: "H",
                        valueRadioWidget: valueRadio,
                        libelRadio: "Homme",
                        context: context,
                      ),
                      RadioButton(value: "F",
                        valueRadioWidget: valueRadio,
                        libelRadio: "Femme",
                        context: context,
                      )
                    ],
                  ),

                  (errorGenre
                      ?
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left:40.0),
                            child:Text(
                              "Merci de selectionner votre genre",
                              style: TextStyle(
                                  color:Colors.red,
                                  fontSize: 12.0
                              ),
                              textAlign: TextAlign.left,
                            )
                        )
                      ]
                  )
                      :
                  SizedBox()
                  )
                ],
              )
          ),
        ),
          ContenaireFormRegister(
              widthContainer: widthContainer,
              content: TextFormField(
                controller: controllerRegisterLasttName,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Nom',
                  labelText: 'Nom',
                ),
                validator: (val) =>
                val == ''
                    ? "Merci de saisir votre nom"
                    : null,
              )
          ),
          ContenaireFormRegister(
              widthContainer: widthContainer,
              content: TextFormField(
                  controller: controllerRegisterFirstName,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'Prénom',
                    labelText: 'Prénom',
                  ),
                  validator: (val) =>
                  val == ''
                      ? "Merci de saisir votre prénom"
                      : null
              )
          ),
          ContenaireFormRegister(
              widthContainer: widthContainer,
              content: TextFormField(
                controller: controllerRegisterPseudo,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person_outline),
                  hintText: 'Pseudonyme',
                  labelText: 'Pseudonyme',
                ),
                validator: (val) =>
                val == ''
                    ? "Merci de saisir votre Pseudonyme"
                    : null,
              )
          ),
          ContenaireFormRegister(
              widthContainer: widthContainer,
              content: TextFormField(
                controller: controllerRegisterSize,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  icon: Icon(Icons.straighten),
                  hintText: 'Taille (en cm)',
                  labelText: 'Taille (en cm)',
                ),
                validator: (val) =>
                val == ''
                    ? "Merci de saisir votre Taille (en cm)"
                    : null,
              )
          ),
          ContenaireFormRegister(
            widthContainer: widthContainer,
            content: TextFormField(
              controller: controllerRegisterDateBirth,
              validator: (val) =>
              val == ''
                  ? "Merci de saisir votre Date de naissance"
                  : null,
              decoration: const  InputDecoration(
                  icon: Icon(Icons.cake), //icon of text field
                  labelText: "Date de naissance" //label text of field
              ),
              readOnly: true,  //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context, initialDate: DateTime.now(),
                    firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101)
                );
                if(pickedDate != null ){
                  print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                  print(formattedDate); //formatted date output using intl package =>  2021-03-16
                  //you can implement different kind of Date Format here according to your requirement
                  setState(() {
                    controllerRegisterDateBirth.text = formattedDate; //set output date to TextField value.
                  });
                }else{
                  print("Merci de saisir votre Date de naissance");
                }
              },
            ),
          )
      ]
    );
  }

  Widget formRegisterState2({required double widthContainer}){
    return Column(
        children:[
          ContenaireFormRegister(
              widthContainer: widthContainer,
              content: TextFormField(
                //controller: controllerEmailLogin..text = 'geoffrey.petain@gmail.com',
                decoration: const InputDecoration(
                  icon: Icon(Icons.key),
                  hintText: 'Mot de passe',
                  labelText: 'Mot de passe',
                ),
                validator: (val) => val!='' ? "Merci de saisir votre mot de passe" : null,
              )
          ),
          ContenaireFormRegister(
            widthContainer: widthContainer,
            content:TextFormField(
              //controller: controllerEmailLogin..text = 'geoffrey.petain@gmail.com',
              decoration: const InputDecoration(
                icon: Icon(Icons.key),
                hintText: 'Confirmation mot de passe',
                labelText: 'Confirmation mot de passe',
              ),
            ),
          )
        ]
    );
  }

  Widget formRegisterState3({required double widthContainer}){
    return Column(
        children:[
          ContenaireFormRegister(
              widthContainer: widthContainer,
              content: Text("etape 3")
          ),
        ]
    );
  }

}



