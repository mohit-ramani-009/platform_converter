import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/model/contact.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/home_provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    Contact contact = ModalRoute.of(context)!.settings.arguments as Contact;
    if (Provider.of<HomeProvider>(context).isAndroid) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Detail Screen"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(color: Colors.blueAccent),
                  child: Center(
                    child: Text(
                      "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  )),
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse("tel://${contact.number}"));
                      },
                      child: Icon(
                        Icons.call,
                        color: Colors.green,
                        size: MediaQuery.of(context).size.width * 0.07,
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "+91 ${contact.number ?? " "}",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.06),
                      ),
                      Text("Phone")
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Share.share(contact.number!);
                      },
                      child: Icon(
                        Icons.share,
                        color: Colors.black54,
                        size: MediaQuery.of(context).size.width * 0.07,
                      )),
                  GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse("mailto:${contact.email}"));
                      },
                      child:  Image.network("https://mailmeteor.com/logos/assets/PNG/Gmail_Logo_512px.png",
                        width: MediaQuery.of(context).size.width * 0.07,),),
                  GestureDetector(
                      onTap: () {
                        launchUrl(Uri.parse("mailto:${contact.email}"));
                      },
                      child: Image.network("https://upload.wikimedia.org/wikipedia/commons/5/5e/WhatsApp_icon.png",
                          width: MediaQuery.of(context).size.width * 0.07,),
                  )
                ]),
            SizedBox(height: 10),
            Divider()
          ],
        ),
      );
    } else {
      return CupertinoPageScaffold(child: Center(child: Text("Detail Screen")));
    }
  }
}
