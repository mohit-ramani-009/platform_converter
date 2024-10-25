import 'package:flutter/material.dart';
import 'package:platform_converter/provider/contact_provider.dart';
import 'package:platform_converter/provider/home_provider.dart';
import 'package:platform_converter/provider/theme_provider.dart';
import 'package:platform_converter/screens/add_contact_screen.dart';
import 'package:platform_converter/screens/detail_screen.dart';
import 'package:platform_converter/screens/home_screen.dart';
import 'package:platform_converter/screens/theme_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContactProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.getThemeMode() == ThemeMode.system
          ? ThemeMode.system
          : themeProvider.getThemeMode(),
      routes: {
        '/': (context) => HomeScreen(),
        'AddContact': (context) => AddContact(),
        'DetailScreen': (context) => DetailScreen(),
      },
    );
  }
}
