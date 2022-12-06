import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../_state/store_connect.dart';
import '../_models/loginState.dart';
Widget appBarWidgets({required context, required dynamic store}) {
    void mangageActionBackNavigation({required dynamic store}){
        switch (store.state.loginState.widget) {
           case "register1":
             store.dispatch(loginActions.State1);
             break;
           case "register2":
              store.dispatch(loginActions.Register1);
              break;
           case "register3":
              store.dispatch(loginActions.Register2);
              break;
           case "password":
              store.dispatch(loginActions.State1);
              break;
           case "logged-add-user-1":
              store.dispatch(loginActions.Logged);
              break;
           case "logged-add-user-2":
              store.dispatch(loginActions.LoggedAddUser1);
              break;
           case "logged-edit-user-1":
              store.dispatch(loginActions.Logged);
              break;
           case "logged-edit-user-2":
              store.dispatch(LoggedEditUser1(uuidMofify: store.state.loginState.param.uuid));
              break;
           case "logged-view-poids":
              store.dispatch(loginActions.Logged);
              break;
           default:null;
         }
    }

  return StoreProvider<dynamic>(
      store: store,
      child: StoreConnector<dynamic, dynamic>(
          converter: (store) => store.state,
          builder: (context, state) {
            if(state.loginState.widget!="logged") {
              return AppBar(
                title: Text(
                  'TeamWeight   '+Localizations.localeOf(context).toString(),
                  style: GoogleFonts.pacifico(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      )),
                ),
                leading:
                 (
                  state.loginState=="email"
                      ?
                      null
                      :
                         IconButton(
                           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                           onPressed: () => mangageActionBackNavigation(store: store),
                        )
                      ),
                actions: const[
                  SizedBox(),
                ],
              );
            }
            else{
              return AppBar(
                title: Text(
                  'TeamWeight',
                  style: GoogleFonts.pacifico(
                      textStyle: const TextStyle(
                        color: Colors.white,
                      )),
                ),
                leading:
                 (
                  state.loginState.widget!="email" && state.loginState.widget!="logged"
                      ?
                      IconButton(
                           icon: const Icon(
                               Icons.arrow_back_ios_new, color: Colors.white
                           ),
                           onPressed: () => mangageActionBackNavigation(store: store),
                        )
                      :
                        null
                  ),
                  actions: <Widget> [
                    Padding(
                        padding: const  EdgeInsets.only(top:5.00,right:5.00),
                        //child: PopupMenuButton(
                        child:InkWell(
                          onTap: (){
                              Scaffold.of(context).openEndDrawer();
                          },
                          child:CircleAvatar(
                              radius: 28,
                              backgroundImage: Image.memory(base64.decode(state.user.imageprofil)).image,
                              child: Stack(
                                children: const  [
                                 Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(
                                        Icons.arrow_drop_down_outlined,
                                        size:12.0
                                    ),
                                  )
                                ],
                              ),
                            ),
                        )
                       // ),
                    ),
                  ]
              );
            }
          }));
}


