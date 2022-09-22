import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class Loader{
  late BuildContext context;
  late bool snackBar;
  late String messageSnackBar;
  late String themeSnackBar;

  Loader({
    required this.context,
    required this.snackBar,
    this.messageSnackBar='',
    this.themeSnackBar=''
  });

  showLoader(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text((messageSnackBar!='' ? messageSnackBar : 'Traitement en cours, veuillez patienter.')),
          backgroundColor: (themeSnackBar!='' ? getThemeSnackBar(): null),
          duration:const Duration(days: 365)
      ),
    );
      context.loaderOverlay.show();
  }

  hideLoader(){
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    context.loaderOverlay.hide();
  }

  getThemeSnackBar(){
    late dynamic colorsReturn;
    switch (themeSnackBar) {
       case 'success':
        colorsReturn=Colors.green;
        break;
      case 'error':
        colorsReturn=Colors.red;
        break;
    }
    return colorsReturn;
    }
}