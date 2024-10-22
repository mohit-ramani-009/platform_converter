import 'package:flutter/material.dart';
import 'package:platform_converter/provider/contact_provider.dart';
import 'package:platform_converter/provider/home_provider.dart';
import 'package:platform_converter/screens/add_contact_screen.dart';
import 'package:platform_converter/screens/detail_screen.dart';
import 'package:platform_converter/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContactProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) =>  HomeScreen(),
          'AddContact': (context) => AddContact(),
          'DetailScreen': (context) => DetailScreen(),
        },
      ),
    ),
  );
}
