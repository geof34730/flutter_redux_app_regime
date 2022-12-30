import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../_state/store_connect.dart';
import '../_state/store_user.dart';

Widget drawerUser({required context, required dynamic store}) {
  return StoreProvider<dynamic>(
      store: store,
      child: StoreConnector<dynamic, dynamic>(
          converter: (store) => store.state,
          builder: (context, state) {
            if (state.loginState.widget.indexOf("logged")<0 ) {
              return SizedBox();
            } else {
              return Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(bottom:0.0),
                        decoration: const BoxDecoration(color: Colors.deepPurple),
                        child: Column(children: [
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15.0, top: 10.0, left: 10.0),
                              child: CircleAvatar(
                                radius: 40.00,
                                backgroundImage: Image.memory(
                                        base64.decode(state.user.imageprofil))
                                    .image,
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.00, top: 10.0, bottom: 25.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(state.user.pseudo,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white)),
                                      Text(
                                          "${state.user.firstname} ${state.user.lastname}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white)),
                                      Text(state.user.email,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white))
                                    ]))
                          ])
                        ])),
                    const Divider(height: 1), //here is a divider
                    const ListTile(
                      title: Text("Ma Team"),
                    ),

                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 20.0,
                              children:[
                                 for(var item in store.state.user.usersFamily ) Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children:[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 15.0, ),
                                        child: CircleAvatar(
                                          radius: 25.00,
                                          backgroundImage: Image.memory(
                                              base64.decode(item.imageprofil))
                                              .image,
                                        ),
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5.00,right: 15.00, top: 15.0,bottom: 25.0,),
                                          child: Column(
                                              children: [
                                                Text(item.pseudo,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black)),
                                              ])
                                      ),
                                    ]
                                ),

                              ]
                          ),
                    ]),
                    Divider(height: 1,),
                    ListTile(
                      leading: const Icon(Icons.group),
                      title: const Text("Gérer votre Team"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: const Text("Mon Profil"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text("Déconnexion"),
                      onTap: () {
                        Scaffold.of(context).closeEndDrawer();
                        store.dispatch(loginActions.Logout);
                        store.dispatch(SetUserLogOutLoginAction(store));
                      },
                    ),
                  ],
                ),
              );
            }
          }));
}
