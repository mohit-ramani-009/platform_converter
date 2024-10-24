import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/contact.dart';
import '../../provider/contact_provider.dart';

class IosMissedCallPage extends StatefulWidget {
  const IosMissedCallPage({super.key});

  @override
  State<IosMissedCallPage> createState() => _IosMissedCallPageState();
}

class _IosMissedCallPageState extends State<IosMissedCallPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Missed Calls",
          style: TextStyle(color: CupertinoColors.white, fontSize: 24),
        ),
        backgroundColor: CupertinoColors.activeBlue,
      ),
      child: Consumer<ContactProvider>(
        builder: (BuildContext context, ContactProvider value, Widget? child) {
          if (value.MissedCallList.isEmpty) {
            return const Center(
              child: Text(
                "No Missed Calls",
                style: TextStyle(fontSize: 30, color: CupertinoColors.black),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: value.MissedCallList.length,
              itemBuilder: (context, index) {
                Contact contact = value.MissedCallList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      launchUrl(Uri.parse("tel://${contact.number}"));
                    },
                    onLongPress: () {
                      _showDeleteConfirmation(context, index);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemRed.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: CupertinoColors.systemGrey.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: CupertinoColors.systemRed,
                            child: Text(
                              "${contact.name?.isNotEmpty == true ? contact.name![0].toUpperCase() : '?'}",
                              style: const TextStyle(color: CupertinoColors.white),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contact.name ?? "",
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.systemRed,
                                  ),
                                ),
                                Text(
                                  contact.number ?? "",
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: CupertinoColors.systemGrey,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: const Icon(CupertinoIcons.info, color: CupertinoColors.systemGrey),
                            onPressed: () {
                              Navigator.of(context).pushNamed("DetailScreen", arguments: contact);
                            },
                          ),
                        ],
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

  void _showDeleteConfirmation(BuildContext context, int index) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Delete Contact"),
          content: const Text("Are you sure you want to delete this contact?"),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Provider.of<ContactProvider>(context, listen: false).removeContact(index);
                Navigator.of(context).pop();
                _showContactDeletedMessage(context);
              },
              isDestructiveAction: true,
              child: const Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _showContactDeletedMessage(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Contact Deleted"),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}