import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:vizmo/core/cubit/home_cubit/home_cubit.dart';
import 'package:vizmo/core/repository/main_repo.dart';
import 'package:vizmo/presentation/event_details_screen.dart';
import 'package:vizmo/presentation/home_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'core/model/event_model.dart';
import 'maanger/route_manager.dart';

void main() async{
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MainRepo>(
          create: (context) => MainRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HomeCubit>(
            create: (BuildContext context) =>
                HomeCubit(repo: context.read<MainRepo>()),
          ),
        ],
        child: ResponsiveSizer(builder: (context, orientation, screenType) {
          return GetMaterialApp(
            title: 'Event Calendar',
            getPages: appRoute(),
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              textSelectionTheme:
                  const TextSelectionThemeData(cursorColor: Colors.white),
            ),
            home: HomeScreen()
          );
        }),
      ),
    );
  }
}

//1. details screen ui
//2. store hive and get hive
//3. condition to check data
///4. edit event
///5. save event
///6. show event in home
///7. change bg of details
