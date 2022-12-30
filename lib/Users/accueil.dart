import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:core';
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../_state/store_user.dart';
import '../_state/store_connect.dart';
import '../_models/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class accueil extends StatefulWidget {
  final dynamic store;
   accueil({Key? key,required context, required this.store}) : super(key: key);
    @override
   _accueil createState() => _accueil();

}
class _accueil extends State<accueil> {
  bool modifyProfile=false;
  final controllerEmailLogin = TextEditingController();
  @override
  void initState() {
    dynamic store = widget.store;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      dynamic store = widget.store;
      double widthContainer = MediaQuery.of(context).size.width * 0.8;
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
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
                              child: Text('Bienvenue dans votre espace Team Weight',
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
                                child: Wrap(
                                  spacing: 15.0, // gap between adjacent chips
                                  runSpacing: 15.0,
                                  children: [
                                    for(var item in store.state.user.usersFamily)avatarProFil(pseudo: item.pseudo,uuid: item.uuid, imgBase64: item.imageprofil, modifyProfile: modifyProfile,store: store),
                                     avatarAdd(store: store)
                                  ],
                                )
                            ),
                          ]
                      ),
                    ]
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: 60, // fixed height
                          child: Container(
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  modifyProfile = !modifyProfile;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15
                                  ),
                                  textStyle: const TextStyle(
                                      fontSize: 15
                                  )
                              ),
                              child: Text(
                                (modifyProfile ? 'Terminer' : 'Modifier'),
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          )
                      )
                    ]
                ),
              ]
          );
    }

  }

   Row avatarProFil({required String pseudo,required String uuid,required String imgBase64, required bool modifyProfile,required dynamic store}) {
      return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(mainAxisSize: MainAxisSize.max, children: [
                InkWell(
                    onTap: () {
                      (modifyProfile ? store.dispatch(LoggedEditUser1(uuidMofify: uuid)) : store.dispatch(loginActions.LoggedViewPoids));
                    },
                    child: Container(
                      child: Column(mainAxisSize: MainAxisSize.max, children: [
                         circleAvatar(imagebase64:  imgBase64 ,modifyProfile: modifyProfile),
                          Text(
                            pseudo,
                            style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )
                        ]))
                ),
            ])
          ]
      );
    }

   Column circleAvatar({required String imagebase64, required bool modifyProfile}) {
      double opacityImage=(!modifyProfile ? 1.0 : 0.4);
      return Column(children: [
        Container(
            width: 102,
            height: 102,
            decoration: BoxDecoration(
              color: const Color(0xff7c94b6),
              image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(opacityImage),BlendMode.dstATop),
                image: Image.memory(base64Decode(imagebase64)).image,
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(100)),
              border: Border.all(
                  color: (!modifyProfile ? Colors.grey : Colors.deepPurple),
                  width: (!modifyProfile ? 0 : 1),
                )
        ),
            child:stackIconView(modifyProfile: modifyProfile),
         )
     ]);
    }

   Align stackIconView({required bool modifyProfile}){
      if(modifyProfile) {
        return const Align(
            child: Icon(
              Icons.edit,
              size: 40,
              color: Colors.white,
            ),
        );
      }
      else{
        return const Align();
      }
    }

   Row avatarAdd({required dynamic store}) {
      return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
           InkWell(
              onTap: () {
                store.dispatch(loginActions.LoggedAddUser1);
              },
              child:Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: CircleAvatar(
                              radius: 51.00,
                              child: Padding(
                              padding: EdgeInsets.only(bottom: 10),
                                  child:Text(
                                    '+',
                                     style:TextStyle(
                                        fontSize: 60.00,
                                    )
                                  )
                              ),
                            ),
                          ),
                          Text("Ajouter",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              )
                          ),
                        ]
                    )
           )
          ]
      );
    }

