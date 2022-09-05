import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../_state/store_user.dart';
import '../_state/store_connect.dart';

Widget bottomNavigationBarWidgets({required context, required dynamic store}) {
  return StoreProvider<dynamic>(
      store: store,
      child: StoreConnector<dynamic, dynamic>(
          converter: (store) => store.state,
          builder: (context, state) {
            if(state.loginState!="logged"){
              return SizedBox();
            }
            else {
              return BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.group),
                    label: 'Ma Team',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_outlined),
                    label: 'Mon Profil',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.logout),
                    label: 'Déconnexion',
                  ),
                ],
                currentIndex: 0,
                selectedItemColor: Colors.deepPurple,
                onTap: (int index) {
                    switch (index) {
                      case 0:
                        print("navigate to Ma team");
                        break;
                      case 1:
                        print("navigate to Mon profil");
                        break;
                      case 2:
                        store.dispatch(loginActions.Logout);
                        break;
                    }
                  ;
                },
              );
            }
    }
    ));
}


//store.dispatch(loginActions.Logout);