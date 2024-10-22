import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/contact.dart';
import '../provider/contact_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<HomeProvider>(context).isAndroid) {
      return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          title: Text("Contact App"),
          centerTitle: true,
          actions: [
            Consumer<HomeProvider>(
              builder: (context, homeprovider, child) {
                return Switch(
                  activeColor: Colors.white,
                  value: homeprovider.isAndroid,
                  onChanged: (value) {
                    homeprovider.chnage();
                  },
                );
              },
            )
          ],
        ),
        body: Consumer<ContactProvider>(
          builder:
              (BuildContext context, ContactProvider value, Widget? child) {
            if (value.contactList.isEmpty) {
              return Center(
                child: Text(
                  "No Contacts",
                  style: TextStyle(fontSize: 50),
                ),
              );
            }
            return ListView.builder(
              itemCount: value.contactList.length,
              itemBuilder: (context, index) {
                Contact contact = value.contactList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shadowColor: Colors.blue,
                    color: Colors.blue.shade50,
                    elevation: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("DetailScreen", arguments: contact);
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          contact.name ?? "",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              contact.number ?? "",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  launchUrl(
                                      Uri.parse("tel://${contact.number}"));
                                },
                                child: Icon(
                                  Icons.call,
                                  color: Colors.green,
                                )),
                            PopupMenuButton(
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, color: Colors.blue),
                                      const SizedBox(width: 8),
                                      Text("Edit"),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, "AddContact",
                                        arguments: index);
                                  },
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      const SizedBox(width: 8),
                                      Text("Delete"),
                                    ],
                                  ),
                                  onTap: () {
                                    _showDeleteConfirmation(context, index);
                                  },
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.share, color: Colors.red),
                                      const SizedBox(width: 8),
                                      Text("share"),
                                    ],
                                  ),
                                  onTap: () {
                                    String shareText = "${contact.number}";
                                    Share.share(shareText);
                                  },
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.email, color: Colors.black),
                                      const SizedBox(width: 8),
                                      Text("Email"),
                                    ],
                                  ),
                                  onTap: () {
                                    launchUrl(
                                        Uri.parse("mailto:${contact.email}"));
                                  },
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.call, color: Colors.black),
                                      const SizedBox(width: 8),
                                      Text("Whatsapp"),
                                    ],
                                  ),
                                  onTap: () {
                                    String url =
                                        "https://wa.me/${contact.number}";
                                    launchUrl(Uri.parse(url));
                                  },
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.sms, color: Colors.black),
                                      const SizedBox(width: 8),
                                      Text("SMS"),
                                    ],
                                  ),
                                  onTap: () {
                                    String url = "sms:${contact.number}";
                                    launchUrl(Uri.parse(url));
                                  },
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.telegram, color: Colors.black),
                                      const SizedBox(width: 8),
                                      Text("Telegram"),
                                    ],
                                  ),
                                  onTap: () {
                                    String url =
                                        "https://t.me/:${contact.number}";
                                    launchUrl(Uri.parse(url));
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, "AddContact");
          },
          child: Icon(Icons.add),
        ),
      );
    } else {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Colors.blue,
          middle: Text(
            "Contacts",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          trailing: CupertinoSwitch(
            value: Platform.isAndroid ? true : false,
            activeColor: Colors.white,
            onChanged: (value) {
              Provider.of<HomeProvider>(context, listen: false).chnage();
            },
          ),
        ),
        child: Consumer<ContactProvider>(
          builder: (context, contactProvider, child) {
            if (contactProvider.contactList.isEmpty) {
              return Center(
                child: Text(
                  "No Contacts",
                  style: TextStyle(fontSize: 40, color: Colors.black),
                ),
              );
            }
            return CupertinoScrollbar(
              child: ListView.builder(
                itemCount: contactProvider.contactList.length,
                itemBuilder: (context, index) {
                  Contact contact = contactProvider.contactList[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed("DetailScreen", arguments: contact);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: CupertinoListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              child: Text(
                                "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            title: Text(
                              contact.name ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            subtitle: Text(
                              contact.number ?? "",
                              style: TextStyle(fontSize: 12),
                            ),
                            trailing: CupertinoButton(
                              child: Icon(Icons.call),
                              onPressed: () {
                                launchUrl(Uri.parse("tel://${contact.number}"));
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    }
  }

  //Show Dialog Box
  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Contact"),
          content: Text("Are you sure you want to delete this contact?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Provider.of<ContactProvider>(context, listen: false)
                    .removeContact(index);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Contact deleted")),
                );
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }
}
