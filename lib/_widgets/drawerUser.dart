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
            if (state.loginState != "logged") {
              return SizedBox();
            } else {
              return Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,

                  children: <Widget>[
                    Container(
                        margin:EdgeInsets.only(bottom:0.0),
                        decoration: BoxDecoration(color: Colors.deepPurple),
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
                    Divider(height: 1), //here is a divider
                    ListTile(
                      title: Text("Ma team"),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.group),
                      title: Text("Accueil Team"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text("Mon Profil"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.logout),
                      title: Text("Déconnexion"),
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
