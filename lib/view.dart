import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:regime_redux_v2/_widgets/appBar.dart';
import 'package:regime_redux_v2/_widgets/bottomNavigationBar.dart';
import 'package:regime_redux_v2/_widgets/drawerUser.dart';
import 'LoginRegister/loginFormState1.dart';
import 'LoginRegister/loginFormState2.dart';
import 'LoginRegister/register.dart';
import 'Users/accueil.dart';
import 'Users/addEdit.dart';

import 'package:regime_redux_v2/Poids/view.dart';
import '_models/loginState.dart';

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
                preferredSize: const Size.fromHeight(60.0), // here the desired height
                child: appBarWidgets(context: context, store: store),
            ),
            endDrawer:drawerUser(context: context, store: store),
            bottomNavigationBar: bottomNavigationBarWidgets(context: context, store: store),
            body: LayoutBuilder(builder: (context, constraints) {
                      return SingleChildScrollView(
                          child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
                            child: IntrinsicHeight(
                                child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:[
                                      StoreConnector<dynamic, LoginState>(
                                      converter: (store) => store.state.loginState,
                                      builder: (context, loginState) {
                                        switch (loginState.widget) {
                                          case "email":
                                            returnWidget=loginFormState1(context: context,store:store);
                                            break;
                                          case "password":
                                            returnWidget=loginFormState2(context: context,store:store);
                                            break;
                                          case "register1": case "register2": case "register3":
                                            returnWidget=register(context: context, store:store);
                                            break;
                                          case "logged":
                                            returnWidget=accueil(context: context,store:store);
                                            break;
                                          case "logged-add-user-1": case "logged-add-user-2":
                                            returnWidget=usersAddEdit(context: context,store:store,edit: false);
                                            break;
                                          case "logged-edit-user-1": case "logged-edit-user-2":
                                            returnWidget=usersAddEdit(context: context,store:store,edit: true);
                                            break;
                                          case "logged-view-poids":
                                            returnWidget=poidsView(context: context,store:store);
                                            break;
                                        }
                                        return returnWidget;
                                      },
                                    ),
                                    ]
                                  )
                            )
                          )
                    );
            })
        )
    );
  }
}

