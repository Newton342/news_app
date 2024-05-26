import 'package:flutter/material.dart';
import 'package:get/get.dart';

void materialSnackbar(BuildContext context,
    {required String title, required void Function() onPressed}) {
  final snackBar = SnackBar(
    content: Text(title),
    action: SnackBarAction(
      label: '',
      onPressed: onPressed,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void getxErrorSnackbar({required String title, required String message}) {
  Get.snackbar(title, message,
      backgroundColor: Colors.redAccent, colorText: Colors.white);
}
