import 'package:flutter/material.dart';

class Confirm {
  late BuildContext context;
  late Function callBackFunction;
  late String textConfirm;

  Confirm({required this.context, required this.callBackFunction, required this.textConfirm});

  showAlertDialog<bool>() {
    Widget noButton = ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).pop(true);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey)

      ),
      label: const Text(
          "NON",
          style: TextStyle(
              fontSize: 19
          )
      ),
      icon: const Icon(
        Icons.cancel,
        size: 19.0,
      ),
    );

    Widget yesButton = ElevatedButton.icon(
      onPressed: () {
        callBackFunction();
        Navigator.of(context).pop(true);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red)

      ),
      label: const Text(
          "OUI",
          style: TextStyle(
              fontSize: 19
          )
      ),
      icon: const Icon(
        Icons.delete,
        size: 19.0,
      ),
    );

    AlertDialog alert = AlertDialog(
      title: Text("Confirmation"),
      content: Text(textConfirm),
      actions: [
        noButton,
        yesButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
