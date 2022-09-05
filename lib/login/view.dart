import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:regime_redux_v2/_widgets/appBar.dart';
import 'package:regime_redux_v2/_widgets/bottomNavigationBar.dart';
import 'package:regime_redux_v2/_widgets/drawer.dart';
import 'widgets/loginFormState1.dart';
import 'widgets/loginFormState2.dart';
import 'widgets/register.dart';
import 'widgets/accueil.dart';


class LoginPage extends StatelessWidget {
  final Store<dynamic> store;

  LoginPage({
    required this.store,
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  late dynamic returnWidget;
  @override
  Widget build(BuildContext context) {
    return StoreProvider<dynamic>(
        store: store,
        child:Scaffold(
            appBar:PreferredSize(
                preferredSize: Size.fromHeight(60.0), // here the desired height
                child: appBarWidgets(context: context, store: store),
            ),
            drawer: (dotenv.get("DEBUG")=="true" ?  drawerWidget(context: context, store: store):null),
            bottomNavigationBar: bottomNavigationBarWidgets(context: context, store: store),
            body: SingleChildScrollView(
            child: StoreConnector<dynamic, dynamic>(
              converter: (store) => store.state.loginState,
              builder: (context, loginState) {
                switch (loginState) {
                  case "email":
                    returnWidget=loginFormState1(context: context, formKey: _formKey,store:store);
                    break;
                  case "password":
                    returnWidget=loginFormState2(context: context, formKey: _formKey,store:store);
                    break;
                  case "register":
                    returnWidget=register(context: context, formKey: _formKey,store:store);
                    break;
                  case "logged":
                    returnWidget=accueil(context: context, formKey: _formKey,store:store);
                    break;
                }
                return returnWidget;
              },
            ),
          ))
    );
  }

}

