import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:redux/redux.dart';
import 'dart:async';
import '_state/appState.dart';
import '_state/store.dart';
import 'view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


Future main() async {
  await dotenv.load(fileName: ".env");
  AppState combinedInitialState = AppState.initial();
  final store = Store<AppState>(appStateReducer, initialState: combinedInitialState);
  runApp(MyApp(store:store));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    return StoreProvider<dynamic>(
      store: store,
      child: StoreConnector<dynamic, dynamic>(
          converter: (store) => store.state,
          builder: (context, state) {
             return MaterialApp(
                 localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [Locale('en', 'EN'),Locale('fr', 'FR')],
                  locale: Locale(store.state.user.localization, store.state.user.localization.toUpperCase()),
                debugShowCheckedModeBanner: (dotenv.get("DEBUG")=="true" ?  true : false),
                theme: ThemeData(
                  elevatedButtonTheme: ElevatedButtonThemeData(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 12.00, bottom: 14.0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  inputDecorationTheme: InputDecorationTheme(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: Colors.transparent),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: Colors.red),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: Color(0xFF455A64)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2, color: Color(0xFF455A64)),
                        borderRadius: BorderRadius.circular(5),
                      )
                  ),
                  brightness: Brightness.light,
                  primarySwatch: Colors.deepPurple,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.deepPurple,
                    iconTheme: IconThemeData(color: Colors.white),
                    actionsIconTheme: IconThemeData(color: Colors.white),
                    centerTitle: true,
                    elevation: 15,
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                    ),
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
                title: 'TeamWeight',
                home: LoaderOverlay(
                    useDefaultLoading: false,
                    overlayWidget: const  Center(
                      child: SpinKitFadingCircle(
                        color: Colors.deepPurple,
                        size: 100.0,
                      ),
                    ),
                    child:LoginPage(store: store)
                ),
              );
          }
      )
    );
  }
}
