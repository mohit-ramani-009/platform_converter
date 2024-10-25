import 'package:flutter/material.dart';
import 'package:platform_converter/provider/contact_provider.dart';
import 'package:platform_converter/provider/home_provider.dart';
import 'package:platform_converter/provider/theme_provider.dart';
import 'package:platform_converter/screens/ios/views/add_contact_screen.dart';
import 'package:platform_converter/screens/ios/views/detail_screen.dart';
import 'package:platform_converter/screens/ios/views/home_screen.dart';
import 'package:platform_converter/screens/ios/views/splash_screen.dart';
import 'package:platform_converter/screens/ios/views/theme_screen.dart';
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
      initialRoute: 'SplashScreen',

      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.getThemeMode() == ThemeMode.system
          ? ThemeMode.system
          : themeProvider.getThemeMode(),
      routes: {
        '/': (context) => HomeScreen(),
        'AddContact': (context) => AddContact(),
        'DetailScreen': (context) => DetailScreen(),
        'SplashScreen': (context) => SplashScreen(),
      },
    );
  }
}
