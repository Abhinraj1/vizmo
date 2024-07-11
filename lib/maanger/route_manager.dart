

import 'package:get/get.dart';
import 'package:vizmo/presentation/home_screen.dart';

import '../presentation/event_details_screen.dart';

List<GetPage> appRoute(){
  return [
    GetPage(name: "/", page:()=> const HomeScreen(),),
    GetPage(name: "/event_details_screen", page:()=> const EventDetailsScreen(),)
  ];
}