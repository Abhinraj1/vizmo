

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../maanger/font_manager.dart';

customSnackBar({required String message}){
  Get.snackbar(
    "Note", "",
    messageText: Text(message,style: snackBarMessage,)
  );
}