import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../../_class/loader.dart';
import '../../_services/login.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter/services.dart';
import 'dart:async';
class loginFormState2 extends StatefulWidget {
  final dynamic store;
   loginFormState2({Key? key,required context, required this.store}) : super(key: key);
    @override
   _loginFormState2 createState() => _loginFormState2();

}

class _loginFormState2 extends State<loginFormState2> {
  int nbDigitCode=6;
  bool passwordEdit = true;
  bool passwordEditNew1 = true;
  bool passwordEditNew2 = true;
  bool passwordConfirmView=false;
  bool passwordConfirmValueError=false;
  bool passwordConfirmValidateForm=false;
  bool disabledButtonSubmit = true;
  bool confirmUpdatePassword = false;
  bool errorCode = false;
  bool corrigeCode =false;
  bool sendService =false;
  String messageErrorPassword = '';
  List<TextEditingController> _controllers = [];
  List<TextEditingController> _controllersInscription = [];
  List<bool> _enabledControllers = [];
  List<bool> _enabledControllersInscription = [];

  TextEditingController controllerPasswordLogin = TextEditingController();
  TextEditingController controllerPasswordLoginNew1= TextEditingController();
  TextEditingController controllerPasswordLoginNew2= TextEditingController();
  @override
  void initState() {
    dynamic store = widget.store;
    super.initState();
  }
  final _formLoginState2 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    dynamic store = widget.store;
    double widthContainer = MediaQuery.of(context).size.width * 0.8;
    return StoreProvider<dynamic>(
        store: store,
        child: Form(
            key: _formLoginState2,
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
                                controller: controllerPasswordLogin..text = 'Hefpccy%08%08',
                                obscureText: passwordEdit,
                                decoration: InputDecoration(
                                  labelText: 'Mot de passe',
                                  hintText: 'Saisissez votre mot de passe',
                                  //icon: Icon(Icons.key),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      passwordEdit
                                          ? Icons.visibility_off
                                          : Icons.visibility,
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
                                                  if (_formLoginState2.currentState!.validate()) {
                                                      sendLoginPassword(store: store,mail:"valideInscription");
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
                                  Loader(context: context,snackBar: true).showLoader();
                                  ServiceLogin(context: context).sendEmailForgetPassword(email: store.state.user.email,store: store,mail: "forgetPassword").then((value) {
                                    Loader(context: context,snackBar: true).hideLoader();
                                      return _displayCodeForgetPasswordInputDialog(
                                          context: context,
                                          email: store.state.user.email,
                                          timerEnd: value["timeCodeValidate"],
                                          store: store
                                        );
                                      });
                                },
                                child: const Text(
                                  "Mode de passe oubli?? ?",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              ),
                            ),
                          ])
                ])));
  }


  void sendLoginPassword({required dynamic store, required String mail}){
   void functReturn;
    Loader(context: context,snackBar: true).showLoader();
    ServiceLogin(context: context).sendEmailPasswordLogin(password: controllerPasswordLogin.text,store: store,context: context).then((value) =>
        {
        if(value['statut'] == "error"){
          if(value['code']=="ULP2"){
              ServiceLogin(context: context).sendEmailForgetPassword(email: store.state.user.email,store: store,mail:mail).then((value) {
                Loader(context: context,snackBar: true).hideLoader();
                print(value);

                (mail=="valideInscription"
                  ?
                    functReturn=_displayCodeValideInscriptionInputDialog(
                      context: context,
                      email: store.state.user.email,
                      timerEnd: value["timeCodeValidate"],
                      store: store
                     )
                  :
                    functReturn=_displayCodeForgetPasswordInputDialog(
                      context: context,
                      email: store.state.user.email,
                      timerEnd: value["timeCodeValidate"],
                      store: store
                     )
                  );
                  return functReturn;
               })
          }
          else
            {
            Loader(context: context,snackBar: true).hideLoader(),
            setState(() {
                messageErrorPassword = value['messageError']!;
              })
            }
        }
        else{
          Loader(context: context,snackBar: true).hideLoader(),
          }
        });
  }

  void initControllerCode(){
    _controllers=[];
    _enabledControllers=[];
    for(var i = 0; i < nbDigitCode; i++) {
      _controllers.add(TextEditingController());
      _enabledControllers.add(true);
    }
  }

  void initControllerCodeInscrition(){
    _controllersInscription=[];
    _enabledControllersInscription=[];
    for(var i = 0; i < nbDigitCode; i++) {
      _controllersInscription.add(TextEditingController());
      _enabledControllersInscription.add(true);
    }
  }

  Future<void> _displayCodeForgetPasswordInputDialog({required BuildContext context,required String email,required int timerEnd,required dynamic store}) async {
    initControllerCode();
      showDialog(
          context: context,
          builder: (BuildContext context)
            {
              return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      contentPadding: EdgeInsets.only(top: 20, left: 0, bottom: 20),
                      insetPadding: EdgeInsets.symmetric(horizontal: 0),
                      scrollable: true,
                      title:Container(
                           width: 300.0,
                           child:Text(
                              'Saisissez le code ?? 6 chiffres que nous vous avons envoy?? sur ${email}.',
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: const TextStyle(fontSize: 16.0)
                           )
                      ),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for(var i = 0; i < nbDigitCode; i++) SizedBox(
                                      width: 40.0,
                                      height: 40.0,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly
                                            ],
                                            autofocus: _enabledControllers[i],
                                            maxLength: 1,
                                            enabled:_enabledControllers[i],
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(vertical: 36.0),
                                                counterText: ""
                                            ),
                                            controller: _controllers[i],
                                            onChanged: (content) {
                                              if (content != "") {
                                                corrigeCode=true;
                                                if (i < nbDigitCode - 1) {
                                                  setState(() {
                                                    _enabledControllers[i]=false;
                                                    _enabledControllers[i+1]=true;
                                                  });
                                                  FocusScope.of(context).nextFocus();
                                                }
                                                else {
                                                  setState(() {
                                                    _enabledControllers[i]=false;
                                                  });
                                                  String codeSend = "";
                                                  for (var i = 0; i < nbDigitCode; i++) {
                                                    codeSend = codeSend + _controllers[i].text;
                                                  }
                                                  if (codeSend.length == nbDigitCode) {
                                                    sendService=true;
                                                    Loader(context: context,snackBar: true).showLoader();
                                                    ServiceLogin(context: context).sendCodeForgetPassword(
                                                        email: store.state.user.email,
                                                        codereset: codeSend,
                                                        store: store).then((value) {
                                                      sendService=false;
                                                      Loader(context: context,snackBar: true).hideLoader();
                                                      if(value['code']=="UPCR2" || value['code']=="UPCR1"){
                                                        setState(() {
                                                          errorCode = true;
                                                        });
                                                      }
                                                      else{
                                                        Navigator.pop(context, true);
                                                        return _displayNewPasswordInputDialog(
                                                            context: context,
                                                            email: store.state.user.email,
                                                            timerEnd: value["timeCodeValidate"],
                                                            store: store,
                                                            codereset: value['codereset']
                                                        );
                                                      }
                                                    });
                                                  }
                                                }
                                              }
                                            },
                                          )
                                      ),
                                    ),
                                  ]),
                              (corrigeCode
                                  ?
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (sendService
                                      ?
                                      const Padding(
                                          padding: EdgeInsets.only(top: 8.0,bottom: 3.0),
                                          child:SizedBox(
                                            height:25.0,
                                            width:25.0,
                                            child:CircularProgressIndicator(),
                                          )
                                      )
                                      :
                                      Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child:ElevatedButton(
                                      style:  ElevatedButton.styleFrom(
                                        textStyle: const TextStyle(fontSize: 12),
                                        fixedSize:const Size(10.0,7.0),
                                        padding: const EdgeInsets.only(left: 3.0, right: 3.0, top: 0.0, bottom: 0.0),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                        backgroundColor: Colors.grey,
                                      ),
                                      onPressed: () {
                                        initControllerCode();
                                        errorCode=false;
                                        corrigeCode=false;
                                        setState(() {});
                                      },
                                      child: const Text('Corriger'),
                                    ),
                                  )
                                  )
                                ],
                              )
                                  :
                              const SizedBox(height: 36.00,)
                              ),
                              CompteurTimerResetPassword(timerEnd:timerEnd, context: context,titleText: "Temps restants pour saisir votre code :"),
                              (errorCode ?
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
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const[
                                                Icon(
                                                    Icons.error,
                                                    size: 19.0,
                                                    color: Colors.red
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 8.0),
                                                  child: Text(
                                                    "CODE INVALIDE",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.red,
                                                        fontSize: 12.0
                                                    ),
                                                    softWrap: true,
                                                  ),
                                                )
                                              ],
                                            )
                                          ]
                                      )
                                  )
                                ],
                              )
                                  :
                              const SizedBox()
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              );
            }
      );
  }

  Future<void> _displayCodeValideInscriptionInputDialog({required BuildContext context,required String email,required int timerEnd,required dynamic store}) async {
    initControllerCodeInscrition();
      showDialog(
          context: context,
          builder: (BuildContext context)
            {
              return StatefulBuilder(
                  builder: (context, setState) {
                    return AlertDialog(
                      titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      contentPadding: EdgeInsets.only(top: 20, left: 0, bottom: 20),
                      insetPadding: EdgeInsets.symmetric(horizontal: 0),
                      scrollable: true,
                      title: Container(
                           width: 300.0,
                           child:Text(
                              'C\'est votre premi??re connexion, merci de saisir le code ?? 6 chiffres que nous vous avons envoy?? sur ${email}, afin de valider votre inscription.',
                              textAlign: TextAlign.center,
                              softWrap: true,
                              style: const TextStyle(fontSize: 16.0)
                           )
                      ),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for(var i = 0; i < nbDigitCode; i++) SizedBox(
                                      width: 40.0,
                                      height: 40.0,
                                      child: Padding(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly
                                            ],
                                            autofocus: _enabledControllersInscription[i],
                                            maxLength: 1,
                                            enabled:_enabledControllersInscription[i],
                                            textAlign: TextAlign.center,
                                            decoration: const InputDecoration(
                                                contentPadding: EdgeInsets.symmetric(vertical: 36.0),
                                                counterText: ""
                                            ),
                                            controller: _controllersInscription[i],
                                            onChanged: (content) {
                                              if (content != "") {
                                                corrigeCode=true;
                                                if (i < nbDigitCode - 1) {
                                                  setState(() {
                                                    _enabledControllersInscription[i]=false;
                                                    _enabledControllersInscription[i+1]=true;
                                                  });
                                                  FocusScope.of(context).nextFocus();
                                                }
                                                else {
                                                  setState(() {
                                                    _enabledControllersInscription[i]=false;
                                                  });
                                                  String codeSend = "";
                                                  for (var i = 0; i < nbDigitCode; i++) {
                                                    codeSend = codeSend + _controllersInscription[i].text;
                                                  }
                                                  if (codeSend.length == nbDigitCode) {
                                                    sendService=true;
                                                    Loader(context: context,snackBar: true).showLoader();
                                                    ServiceLogin(context: context).sendCodeValidationInscription(
                                                        email: store.state.user.email,
                                                        codevalidation: codeSend,
                                                        store: store).then((value) {
                                                      sendService=false;
                                                      Loader(context: context,snackBar: true).hideLoader();
                                                      if(value['code']=="UPCR2" || value['code']=="UPCR1"){
                                                        setState(() {
                                                          errorCode = true;
                                                        });
                                                      }
                                                      else{
                                                        Navigator.pop(context, true);
                                                        sendLoginPassword(store: store, mail:"valideInscription");
                                                      }
                                                    });
                                                  }
                                                }
                                              }
                                            },
                                          )
                                      ),
                                    ),
                                  ]),
                              (corrigeCode
                                  ?
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (sendService
                                      ?
                                      const Padding(
                                          padding: EdgeInsets.only(top: 8.0,bottom: 3.0),
                                          child:SizedBox(
                                            height:25.0,
                                            width:25.0,
                                            child:CircularProgressIndicator(),
                                          )
                                      )
                                      :
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child:ElevatedButton(
                                          style:  ElevatedButton.styleFrom(
                                            textStyle: const TextStyle(fontSize: 12),
                                            fixedSize:const Size(10.0,7.0),
                                            padding: const EdgeInsets.only(left: 3.0, right: 3.0, top: 0.0, bottom: 0.0),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                            backgroundColor: Colors.grey,
                                          ),
                                          onPressed: () {
                                            initControllerCodeInscrition();
                                            errorCode=false;
                                            corrigeCode=false;
                                            setState(() {});
                                          },
                                          child: const Text('Corriger'),
                                        ),
                                      )
                                  )
                                ],
                              )
                                  :
                              const SizedBox(height: 36.00,)
                              ),
                              CompteurTimerResetPassword(timerEnd:timerEnd, context: context,titleText: "Temps restants pour saisir votre code :"),
                              (errorCode ?
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
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const[
                                                Icon(
                                                    Icons.error,
                                                    size: 19.0,
                                                    color: Colors.red
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(left: 8.0),
                                                  child: Text(
                                                    "CODE INVALIDE",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.red,
                                                        fontSize: 12.0
                                                    ),
                                                    softWrap: true,
                                                  ),
                                                )
                                              ],
                                            )
                                          ]
                                      )
                                  )
                                ],
                              )
                                  :
                              const SizedBox()
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
              );
            }
      );
  }

  Future<void> _displayNewPasswordInputDialog({required BuildContext context,required String email,required int timerEnd,required dynamic store,required dynamic codereset}) async {
    final controllerPasswordLoginNew1 = TextEditingController();
    final controllerPasswordLoginNew2 = TextEditingController();
    passwordConfirmView=false;
    confirmUpdatePassword=false;
    passwordConfirmValueError=false;
    passwordConfirmValidateForm=false;
    initControllerCode();
    showDialog(
        context: context,
        builder: (BuildContext context)
        {
          return StatefulBuilder(
              builder: (context, setState) {
                return (confirmUpdatePassword
                    ?
                    AlertDialog(
                        titlePadding: EdgeInsets.only(top: 20, left: 50, right: 50),
                        contentPadding: EdgeInsets.only(top: 20, left: 0, bottom: 20),
                        insetPadding: EdgeInsets.symmetric(horizontal: 0),
                        scrollable: true,
                        title: const Text(
                            'Votre mot de passe ?? bien ??t?? mise ?? jour, vous pouvez maintenant saisir votre nouveau mot de passe pour vous identifier.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.0)),
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Form(
                                child: Column(
                                  children: [
                                    RowFormPassword(contentRow:
                                    ElevatedButton.icon(
                                      onPressed:(){
                                        Navigator.pop(context, true);
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 19.0,
                                      ),
                                      label: const Text(
                                          "FERMER",
                                          style: TextStyle(fontSize: 19)
                                      ),
                                    ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                    :
                    AlertDialog(
                          titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
                          contentPadding: EdgeInsets.only(top: 20, left: 0, bottom: 20),
                          insetPadding: EdgeInsets.symmetric(horizontal: 0),
                          scrollable: true,
                          title: const Text(
                              'Saisissez votre nouveau mot de passe',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16.0)),
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  RowFormPassword(contentRow:
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: controllerPasswordLoginNew1..text,
                                    onChanged: (value) {
                                      setState(() {
                                        passwordConfirmValueError = checkLiveValueConfirmationPassword(
                                            valuePassword: controllerPasswordLoginNew1.text,
                                            valuePasswordCheck: controllerPasswordLoginNew2.text
                                        );
                                        passwordConfirmValidateForm = checkValueConfirmationPasswordForSubmit(
                                            valuePassword: controllerPasswordLoginNew1.text,
                                            valuePasswordCheck: controllerPasswordLoginNew2.text
                                        );
                                      });
                                    },
                                    obscureText: passwordEditNew1,
                                    decoration: InputDecoration(
                                        labelText: 'Nouveau mot de passe',
                                        hintText: 'Saisissez votre nouveau mot de passe',
                                        //icon: Icon(Icons.key),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                            passwordEditNew1
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Theme.of(context).primaryColorDark,
                                          ),
                                          onPressed: () {
                                            passwordEditNew1 = !passwordEditNew1;
                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  (passwordConfirmView
                                      ?
                                      RowFormPassword(contentRow:
                                        TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: controllerPasswordLoginNew2..text,
                                        obscureText: passwordEditNew2,
                                        style: TextStyle(color: (passwordConfirmValueError ? Colors.red : Colors.black)),
                                        onChanged: (value) {
                                          setState(() {
                                            passwordConfirmValueError = checkLiveValueConfirmationPassword(
                                                valuePassword: controllerPasswordLoginNew1.text,
                                                valuePasswordCheck: controllerPasswordLoginNew2.text
                                            );
                                            passwordConfirmValidateForm = checkValueConfirmationPasswordForSubmit(
                                                valuePassword: controllerPasswordLoginNew1.text,
                                                valuePasswordCheck: controllerPasswordLoginNew2.text
                                            );
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Confirmation nouveau mot de passe',
                                          hintText: 'Confirmer votre nouveau mot de passe',
                                          //icon: Icon(Icons.key),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              // Based on passwordVisible state choose the icon
                                              passwordEditNew2
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Theme.of(context).primaryColorDark,
                                            ),
                                            onPressed: () {
                                              passwordEditNew2 = !passwordEditNew2;
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                      )
                                      :
                                    SizedBox()
                                  ),
                                  CompteurTimerResetPassword(timerEnd:timerEnd, context: context,titleText: "Temps restants pour saisir votre nouveau mot de passe:"),
                                  RowFormPassword(contentRow:
                                    FlutterPwValidator(
                                    controller: controllerPasswordLoginNew1,
                                    minLength: 6,
                                    uppercaseCharCount: 1,
                                    numericCharCount: 3,
                                    specialCharCount: 1,
                                    width: 400,
                                    height: 110,
                                    onSuccess: () {
                                      setState(() {
                                        passwordConfirmView = true;
                                      });
                                    },
                                    onFail: () {
                                      setState(() {
                                        passwordConfirmView = false;
                                      });
                                    },
                                  )
                                  ),
                                  RowFormPassword(contentRow:
                                    ElevatedButton.icon(
                                    onPressed:(passwordConfirmValidateForm
                                        ?
                                        (){
                                          Loader(context: context,snackBar: true).showLoader();
                                          ServiceLogin(context: context).sendForgetNewPassword(email: store.state.user.email, codereset: codereset, password: controllerPasswordLoginNew1.text, store: store).then((value) {
                                            setState((){
                                              confirmUpdatePassword=true;
                                            });
                                            Loader(context: context,snackBar: true).hideLoader();
                                          });
                                        }
                                        :
                                      null
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
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                );
              }
          );
        }
    );
  }
}

Widget CompteurTimerResetPassword({required int timerEnd,required BuildContext context, required String titleText}){
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
          padding: EdgeInsets.only(top: 0.0),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titleText,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12.0
                  ),
                  softWrap: true,
                ),
                CountdownTimer(
                  //endTime:endTime,
                    endTime: timerEnd,
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold
                    ),
                    onEnd: () {
                      Navigator.pop(context, true);
                    },
                    endWidget: const Center(
                        child: Text('Termin??',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.0,
                                fontWeight:FontWeight.bold
                            )
                        )
                    )
                ),
              ]
          )
      )
    ],
  );
}

Widget RowFormPassword({required Widget contentRow}){
  return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(10),
          width: 300,
          child: contentRow
        )
      ]
  );
}

bool checkLiveValueConfirmationPassword({required String valuePassword, required String valuePasswordCheck}){
  if(valuePasswordCheck.length>valuePassword.length){
    return true;
  }
  return valuePassword.substring(0, valuePasswordCheck.length)!=valuePasswordCheck;
}

bool checkValueConfirmationPasswordForSubmit({required String valuePassword, required String valuePasswordCheck}){
  return valuePassword==valuePasswordCheck;
}


