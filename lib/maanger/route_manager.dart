

import 'package:get/get.dart';

import '../presentation/event_details_screen.dart';

List<GetPage> appRoute(){
  return [
    GetPage(name: "/event_details_screen", page:()=> EventDetailsScreen(
      data: Get.arguments["data"],
      onSave: Get.arguments["onSave"],
    ),)
  ];
}