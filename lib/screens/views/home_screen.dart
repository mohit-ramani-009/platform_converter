import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/provider/home_provider.dart';
import 'package:platform_converter/screens/ios/ios_home_page.dart';
import 'package:platform_converter/screens/ios/ios_missed_call_page.dart';
import 'package:provider/provider.dart';
import '../android/home_page.dart';
import '../android/missed_call_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    if (Provider
        .of<HomeProvider>(context)
        .isAndroid) {
      return Scaffold(
        // appBar: AppBar(
        //   foregroundColor: Colors.white,
        //   backgroundColor: Colors.blue,
        //   title: const Text("Contact App"),
        //   centerTitle: true,
          // actions: [
          //   Consumer<HomeProvider>(
          //     builder: (context, homeProvider, child) {
          //       return Switch(
          //         activeColor: Colors.white,
          //         value: homeProvider.isAndroid,
          //         onChanged: (value) {
          //           homeProvider.change(); // Toggle between Android and iOS
          //         },
          //       );
          //     },
          //   )
          // ],
        // ),
        bottomNavigationBar: Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            return BottomNavigationBar(
              currentIndex: homeProvider.menuIndex,
              onTap: (index) {
                homeProvider.changeMenuIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.call),
                  label: "Missed Calls",
                ),
              ],
            );
          },
        ),
        body:
        Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            switch (homeProvider.menuIndex) {
              case 0:
                return HomePage(); 
              case 1:
                return MissedCallPage();
              default:
                return HomePage();
            }
          },
        ),

      );
    } else {
      return CupertinoPageScaffold(
        child: Column(
          children: [
            Expanded(
              child: Consumer<HomeProvider>(
                builder: (context, homeProvider, child) {
                  switch (homeProvider.menuIndex) {
                    case 0:
                      return const IosHomePage(); 
                    case 1:
                      return const IosMissedCallPage(); 
                    default:
                      return const IosHomePage();
                  }
                },
              ),
            ),
            CupertinoTabBar(
              currentIndex: Provider
                  .of<HomeProvider>(context)
                  .menuIndex,
              onTap: (index) {
                Provider.of<HomeProvider>(context, listen: false)
                    .changeMenuIndex(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.phone),
                  label: "Missed Calls",
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
