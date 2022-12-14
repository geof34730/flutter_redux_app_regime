import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../_state/store_user.dart';
import '../_state/store_connect.dart';
import 'drawerDevTools.dart';

Widget bottomNavigationBarWidgets({required context, required dynamic store}) {
  print("************** init dev tools*************");



  return StoreProvider<dynamic>(
      store: store,
      child: StoreConnector<dynamic, dynamic>(
          converter: (store) => store,
          builder: (context, store) {
           return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
               children:[
                  Row(
                     mainAxisSize: MainAxisSize.max,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children:[
                        Container(
                            height: 60,
                            width:MediaQuery.of(context).size.width * (store.state.loginState.widget.indexOf("logged")<0 ? 1 : 0.50),
                            color: Colors.black12,
                            child: InkWell(
                              onTap: () =>  showDialog(
                                  context: context,
                                  builder: (BuildContext context)
                                      {
                                        return drawerWidget(context: context, store: store);
                                      }
                                  ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.javascript_sharp,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    const Text(
                                      'Debug Tools',
                                      style:TextStyle(
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ),
                        if(store.state.loginState.widget.indexOf("logged")>=0)Container(
                            height: 60,
                            width:MediaQuery.of(context).size.width * 0.50,
                            color: Colors.black12,
                            child: InkWell(
                              onTap: () =>  {
                                Scaffold.of(context).closeEndDrawer(),
                                store.dispatch(loginActions.Logout)




                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Column(
                                  children: <Widget>[
                                    Icon(
                                      Icons.logout,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    const Text('D??connexion',
                                      style:TextStyle(
                                        fontWeight: FontWeight.bold
                                      )),
                                  ],
                                ),
                              ),
                            ),
                        )
                    ]
                 )
               ]);
            }
          //}
      ));
}


//store.dispatch(loginActions.Logout);