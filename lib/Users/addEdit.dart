import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../_class/loader.dart';
import '../../_models/user.dart';
import '../../_services/login.dart';
import '../../_state/store_connect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import '../_class/stringCommon.dart';


class usersAddEdit extends StatefulWidget {
  final dynamic store;
  final bool edit;

  usersAddEdit({Key? key,required context,  required this.store, required this.edit}) : super(key: key);
  @override
  _usersAddEdit createState() => _usersAddEdit();
}

class _usersAddEdit extends State<usersAddEdit> {
  @override
  void initState() {
    dynamic store = widget.store;
    bool edit = widget.edit;
    super.initState();
  }
  String valueRadio = '';
  final _formRegister = GlobalKey<FormState>();
  bool errorGenre=false;

  TextEditingController  controllerRegisterSize = TextEditingController();
  TextEditingController controllerRegisterDateBirth = TextEditingController();
  TextEditingController controllerRegisterPseudo= TextEditingController();
  TextEditingController controllerRegisterFirstName= TextEditingController();
  TextEditingController controllerRegisterLasttName= TextEditingController();





  ImagePicker picker = ImagePicker();
  String imageData = "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";
  bool modifyProfile=true;
  @override
  Widget build(BuildContext context) {
    double widthContainer = MediaQuery.of(context).size.width * 0.8;
    dynamic store = widget.store;
    bool edit = widget.edit;
    String uuidEdit="";

      if(edit){
       Userdata dateUserEdit=getDataUserEdit(dateUsersFamily: store.state.user.usersFamily);
        print(dateUserEdit.pseudo);
        controllerRegisterFirstName.text=dateUserEdit.firstname!;
        controllerRegisterLasttName.text=dateUserEdit.lastname!;
        controllerRegisterPseudo.text=dateUserEdit.pseudo!;
        controllerRegisterSize.text=dateUserEdit.taille!;
        controllerRegisterDateBirth.text=dateUserEdit.datenaissance!;
        valueRadio=dateUserEdit.sexe!;
        uuidEdit=dateUserEdit.uuid!;
      }


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
                                content: Text("${(edit ? 'Modifier' :  'Ajouter')} un utilisateur à votre Team",
                                    style: GoogleFonts.pacifico(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 30.00,
                                            height: 1.2)
                                          ),
                                    textAlign: TextAlign.center
                                    )
                            ),
                            ContenaireFormRegister(
                                widthContainer: widthContainer,
                                content: Text("Etape ${StringCommon(store: store).WriteStateFormString()}/4",
                                    style:const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.00,
                                            height: 0.1),
                                    textAlign: TextAlign.center)
                            ),
                          StoreConnector<dynamic, dynamic>(
                                      converter: (store) => store.state.loginState,
                                         builder: (context, loginState) {
                                          manageStateButtonSubmit(context: context,loginState: loginState);
                                           switch (loginState) {
                                             case "logged-add-user-1":case "logged-edit-user-1":
                                                return formRegisterState1(widthContainer: widthContainer);
                                             case "logged-add-user-2":case "logged-edit-user-2":
                                                return formRegisterState2(widthContainer: widthContainer);
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
                                          onPressed:(){
                                                     errorGenre=(valueRadio=='');
                                                      if (_formRegister.currentState!.validate() && valueRadio!='' ) {
                                                        if(store.state.loginState=="logged-add-user-1" || store.state.loginState=="logged-edit-user-1" ) {
                                                              setState(() {
                                                                (edit ?
                                                                store.dispatch(loginActions.LoggedEditUser2)
                                                                :
                                                                store.dispatch(loginActions.LoggedAddUser2)
                                                                );
                                                              });
                                                        }
                                                        else{
                                                             if(store.state.loginState=="logged-add-user-2" || store.state.loginState=="logged-edit-user-2") {
                                                               Loader(context: context,snackBar: true).showLoader();
                                                                Login().addUserTeam(
                                                                     userDataRegister: Userdata(
                                                                      uuid: (edit ? uuidEdit : null),
                                                                      pseudo: controllerRegisterPseudo.text,
                                                                      firstname: controllerRegisterFirstName.text,
                                                                      lastname: controllerRegisterLasttName.text,
                                                                      email: null,
                                                                      profil: "familyUser",
                                                                      datenaissance: controllerRegisterDateBirth.text,
                                                                      sexe: valueRadio,
                                                                      taille: controllerRegisterSize.text,
                                                                      imageprofil: imageData,
                                                                      uuidfamillyadmin: store.state.user.uuid,
                                                                      token: store.state.user.token,
                                                                      usersFamily: null,
                                                                      usersFamilyGlobalState: null
                                                                      ),
                                                                  store: store,
                                                                  edit:edit
                                                                ).then((value) => {
                                                                    if(value['code']=="UA1"){
                                                                        Loader(context: context,snackBar: true).hideLoader(),
                                                                        store.dispatch(loginActions.Logged)
                                                                        }
                                                                    else{
                                                                        Loader(context: context,snackBar: true).hideLoader(),
                                                                        store.dispatch(loginActions.Logout)
                                                                        }
                                                                });
                                                              }
                                                             else{
                                                               store.dispatch(loginActions.Logged);
                                                             }
                                                          }
                                                        }
                                                      else{
                                                        setState(() {
                                                          
                                                        });
                                                      }
                                                      }

                                          ,
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
                                ]
                                )
                            ),
                          ])
                ])));
  }

  Row RadioButton({required String value,required String libelRadio,required BuildContext context, required String valueRadioWidget}){
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio(
            fillColor: (errorGenre ? MaterialStateProperty.all(Colors.red) : MaterialStateProperty.all(const Color(0xFF455A64))),
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
                  color: (errorGenre ? Colors.red :const Color(0xFF455A64)),
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
                keyboardType: TextInputType.text,
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
                    lastDate: DateTime(2101),
                    //initialDatePickerMode: DatePickerMode.year,
                  initialEntryMode: DatePickerEntryMode.input
                );
                if(pickedDate != null ){
                  String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
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
              content:Column(children: [
                 const Padding(
                  padding: EdgeInsets.only(top: 16.00),
                  child: Text(
                    "Votre photo de profil",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.00
                    ),
                  ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 5.00),
                  child:CircleAvatar(
                      radius: 100.00,
                      backgroundImage:  Image.memory(base64Decode(imageData)).image,
                    ),
                ),
                 Padding(
                  padding: const EdgeInsets.only(top: 3.00),
                  child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                          const SizedBox(
                           height:5.00
                         ),
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.file_open,
                              size: 18.0,
                            ),
                            label: const Text("Télécharger une photo dans ma bibliothèque", style: TextStyle(fontSize: 10)),
                            onPressed: () {
                              pickImage(source: ImageSource.gallery);
                            },
                          ),
                          SizedBox(height:10.0),
                          ElevatedButton.icon(
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              size: 18.0,
                            ),
                            label: const Text("Prendre un photo", style: TextStyle(fontSize: 10)),
                            onPressed: () {
                              pickImage(source: ImageSource.camera);
                            },
                          ),
                          const SizedBox(
                           height:20.00
                         ),
                      ]
                 )
                )
              ])
          ),
        ]
    );
  }

  Widget formRegisterConfirmation({required double widthContainer}){
    return Column(
        children:[
          ContenaireFormRegister(
              widthContainer: widthContainer,
              content:Column(children: [
                 Padding(
                  padding: const EdgeInsets.only(top: 3.00),
                  child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: const [
                          SizedBox(
                           height:5.00
                         ),
                          Text("votre inscription à bien été pris en compte, vous pouvez maintenant vous identifiez pour accèder à l'application"),
                          SizedBox(
                           height:20.00
                         ),
                      ]
                 )
                )
              ])
          ),
        ]
    );
  }

  Future pickImage({required ImageSource source}) async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? chosenImage = await _picker.pickImage(source: source);
    if (chosenImage == null) {
      print("Nous n'avons pas pu récupérer d'image");
    } else {
      ImageProperties properties=await FlutterNativeImage.getImageProperties(chosenImage.path);
      dynamic largeurNew = 400;
      dynamic largeurImg = properties.width;
      dynamic hauteurImg = properties.height;
      dynamic compressedFile = await FlutterNativeImage.compressImage(
          chosenImage.path,
          quality: 100,
          targetWidth: largeurNew,
          targetHeight: (hauteurImg * largeurNew / largeurImg).round());
      final bytes = compressedFile.readAsBytesSync();
      imageData = base64Encode(bytes);
      setState(() {});
    }


  }

  void manageStateButtonSubmit({required BuildContext context,required dynamic loginState}) {

  }


  dynamic getDataUserEdit({required List<Userdata> dateUsersFamily}){
    for (int i = 0; i < dateUsersFamily.length; i++) {
     if (dateUsersFamily[i].uuid == "9adedae0-ea00-4250-978b-92c927d053cb") {
       return dateUsersFamily[i];
     }
    }
  }


}



