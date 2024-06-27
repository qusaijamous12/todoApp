import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todoappnew/moduel/todoapp/cubit/cubit.dart';
import 'package:todoappnew/moduel/todoapp/cubit/state.dart';
import 'package:todoappnew/moduel/todoapp/models/homescreen.dart';

import 'package:todoappnew/shared/blocObserver.dart';
import 'package:todoappnew/shared/constants/constants.dart';

void main()async {
  Bloc.observer = MyBlocObserver();


  runApp(MyApp());
}
class MyApp extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:HomeScreen(),


    );

  }

}
