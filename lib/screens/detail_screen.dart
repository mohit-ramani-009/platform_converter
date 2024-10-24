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
          foregroundColor: Colors.white,
          centerTitle: true,
          backgroundColor: Colors.blue,
          title: Text("Detail Screen", style: TextStyle(fontSize: 24)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(color: Colors.blue.shade200),
                child: Center(
                  child: Text(
                    "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.06,
                        backgroundColor: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            String url = "sms:${contact.number}";
                            launchUrl(Uri.parse(url));
                          },
                          child: Image.network(
                            "https://downloadr2.apkmirror.com/wp-content/uploads/2022/04/61/6268f507b82d1.png",
                            width: MediaQuery.of(context).size.width * 0.09,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.06,
                        backgroundColor: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse("https://wa.me/${contact.number}  "));},
                          child: Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/5/5e/WhatsApp_icon.png",
                            width: MediaQuery.of(context).size.width * 0.09,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.06,
                        backgroundColor: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse("mailto:${contact.email}"));
                          },
                          child: Image.network(
                            "https://mailmeteor.com/logos/assets/PNG/Gmail_Logo_512px.png",
                            width: MediaQuery.of(context).size.width * 0.09,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.06,
                        backgroundColor: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            Share.share(contact.number!);
                          },
                          child: Image.network(
                            "https://cdn3d.iconscout.com/3d/premium/thumb/share-button-3d-icon-download-in-png-blend-fbx-gltf-file-formats--sharing-send-it-user-interface-pack-icons-4820410.png",
                            width: MediaQuery.of(context).size.width * 0.09,
                          ),
                        ),
                      ),
                    ]),
              ),
            ]),
            SizedBox(height: 20),
            GestureDetector(
              onLongPress: () {
                launchUrl(Uri.parse("tel://${contact.number}"));
              },
              child: Row(
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
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.06),
                        ),
                        Text("Phone")
                      ],
                    ),
                  ]),
            ),
            SizedBox(height: 10),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("call logs",
                        style: TextStyle(fontSize: 18, color: Colors.grey)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Missed",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        Spacer(),
                        Text("2024/10/22 02.31 pm",
                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Called 20 min",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        Spacer(),
                        Text("2024/9/22 04.20 pm",
                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Called 4 min",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        Spacer(),
                        Text("2024/9/21 02.00 pm",
                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Called 50 sec",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        Spacer(),
                        Text("2024/8/10 12.00 pm",
                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Missed",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        Spacer(),
                        Text("2024/7/02 05.00 pm",
                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text("Missed,rang 14 sec",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        Spacer(),
                        Text("2024/7/01 03.45 pm",
                            style: TextStyle(fontSize: 18, color: Colors.grey)),
                      ],
                    ),
                  ]),
            )
          ],
        ),
      );
    } else {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: const Text(
            "Detail Screen",
            style: TextStyle(fontSize: 24, color: CupertinoColors.white),
          ),
          backgroundColor: CupertinoColors.activeBlue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemBlue.withOpacity(0.5),
                  ),
                  child: Center(
                    child: Text(
                      "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
                      style: TextStyle(decoration: TextDecoration.none,
                        color: CupertinoColors.white,
                        fontSize: MediaQuery.of(context).size.width * 0.2,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.06,
                        backgroundColor: CupertinoColors.white,
                        child: GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse("sms:${contact.number}"));
                          },
                          child: Icon(CupertinoIcons.conversation_bubble,
                              color: CupertinoColors.activeGreen, size: 30),
                        ),
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.06,
                        backgroundColor: CupertinoColors.white,
                        child: GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse("https://wa.me/${contact.number}  "));},
                          child: Icon(CupertinoIcons.phone_circle,
                              color: CupertinoColors.activeGreen, size: 30),
                        ),
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.06,
                        backgroundColor: CupertinoColors.white,
                        child: GestureDetector(
                          onTap: () {
                            launchUrl(Uri.parse("mailto:${contact.email}"));
                          },
                          child: Icon(CupertinoIcons.mail,
                              color: CupertinoColors.activeOrange, size: 30),
                        ),
                      ),
                      CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.06,
                        backgroundColor: CupertinoColors.white,
                        child: GestureDetector(
                          onTap: () {
                            Share.share(contact.number!);
                          },
                          child: Icon(CupertinoIcons.share,
                              color: CupertinoColors.activeBlue, size: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onLongPress: () {
                launchUrl(Uri.parse("tel://${contact.number}"));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse("tel://${contact.number}"));
                    },
                    child: Icon(
                      CupertinoIcons.phone,
                      color: CupertinoColors.activeGreen,
                      size: MediaQuery.of(context).size.width * 0.07,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "+91 ${contact.number ?? ' '}",
                        style: TextStyle(decoration: TextDecoration.none,
                            fontSize: MediaQuery.of(context).size.width * 0.06,
                            color: CupertinoColors.black),
                      ),
                      Text(
                        "Phone",
                        style: TextStyle(decoration: TextDecoration.none,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: CupertinoColors.systemGrey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Call Logs",
                      style: TextStyle(decoration: TextDecoration.none,
                          fontSize: 18, color: CupertinoColors.systemGrey)),
                  const SizedBox(height: 10),
                  // Inline call logs
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Text("Missed",
                            style: TextStyle(decoration: TextDecoration.none,
                                fontSize: 17, color: CupertinoColors.black)),
                        const Spacer(),
                        const Text("2024/10/22 02:31 PM",
                            style: TextStyle(decoration: TextDecoration.none,
                                fontSize: 15,
                                color: CupertinoColors.systemGrey)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Text("Called 20 min",
                            style: TextStyle(decoration: TextDecoration.none,
                                fontSize: 17, color: CupertinoColors.black)),
                        const Spacer(),
                        const Text("2024/09/22 04:20 PM",
                            style: TextStyle(decoration: TextDecoration.none,
                                fontSize: 15,
                                color: CupertinoColors.systemGrey)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Text("Called 4 min",
                            style: TextStyle(decoration: TextDecoration.none,
                                fontSize: 17, color: CupertinoColors.black)),
                        const Spacer(),
                        const Text("2024/09/21 02:00 PM",
                            style: TextStyle(decoration: TextDecoration.none,
                                fontSize: 15,
                                color: CupertinoColors.systemGrey)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Text("Called 50 sec",
                            style: TextStyle(decoration: TextDecoration.none,
                                fontSize: 17, color: CupertinoColors.black)),
                        const Spacer(),
                        const Text("2024/08/10 12:00 PM",
                            style: TextStyle(decoration: TextDecoration.none,
                                fontSize: 15,
                                color: CupertinoColors.systemGrey)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Text("Missed",
                            style: TextStyle(decoration: TextDecoration.none,
                                fontSize: 17, color: CupertinoColors.black)),
                        const Spacer(),
                        const Text("2024/07/02 05:00 PM",
                            style: TextStyle(decoration: TextDecoration.none,
                                fontSize: 15,
                                color: CupertinoColors.systemGrey)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        const Text("Missed, rang 14 sec",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                                fontSize: 17, color: CupertinoColors.black)),
                        const Spacer(),
                        const Text("2024/07/01 03:45 PM",
                            style: TextStyle(decoration: TextDecoration.none,
                                fontSize: 15,
                                color: CupertinoColors.systemGrey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
