import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '_state/appState.dart';
import '_state/store.dart';

import 'login/view.dart';

void main() {
  AppState combinedInitialState = AppState(1);
  final store = Store<AppState>(appStateReducer, initialState: combinedInitialState);
  runApp(
    MyApp(
      store: store,
    ),
  );
}



class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.store}) : super(key: key);
  final Store<dynamic> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<dynamic>(
      store: store,
      child:   MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: TextButton.styleFrom(
              padding:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 15.00, bottom: 15.0),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 3, color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(5),
              )),
          brightness: Brightness.light,
          primarySwatch: Colors.deepPurple,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.deepPurple,
            iconTheme: IconThemeData(color: Colors.white),
            actionsIconTheme: IconThemeData(color: Colors.amber),
            centerTitle: true,
            elevation: 15,
            titleTextStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          timePickerTheme: const TimePickerThemeData(
            backgroundColor: Colors.red,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Colors.deepPurple,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          dataTableTheme: DataTableThemeData(
              headingRowColor:
              MaterialStateColor.resolveWith((states) => Colors.deepPurple),
              headingTextStyle: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple,
            elevation: 15.00,
          ),
        ),
        title: 'Mon poids comme j\'aime',
        home: LoginPage(store: store),
      ),
    );
  }
}