import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SnakBar{
  late BuildContext context;
  late String messageSnackBar;
  late String themeSnackBar;

  SnakBar({
    required this.context,
    required this.messageSnackBar,
    required this.themeSnackBar
  });

  showSnakBar(){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(messageSnackBar),
          backgroundColor: getThemeSnackBar(),
          duration:const Duration(seconds: 3)
      ),
    );

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