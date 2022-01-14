import 'package:fg_task/View/main_screen.dart';
import 'package:fg_task/ViewModel/main_screen_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main ()
{
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MainScreenViewModel()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    ),
  ));
}